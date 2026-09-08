import { Controller } from "@hotwired/stimulus"

const FRAME_ID = "dialog"
const DEFAULT_POSITION = "center"
const DEFAULT_SIZE = "2xl"
const HORIZONTAL_POSITIONS = ["top", "bottom"]

// Legacy `data-turbo-frame` values kept working after the Modal/Drawer → Dialog unification.
// Each alias presets a position and is rewritten to the real frame id ("dialog") before Turbo
// resolves it, so existing async links need no edits — see docs/components/dialog.md.
const FRAME_ALIASES = {
  dialog: DEFAULT_POSITION,
  modal: "center",
  drawer: "right"
}

// Stack manager for every <dialog> on the page — sync (declared inline with an `id`) and
// remote (opened via a link/form with data-turbo-frame="dialog", or the deprecated "modal"/
// "drawer" aliases). Unlimited nesting works because the manager, not any single dialog, owns
// depth tracking, the flash portal and the "sentinel" <turbo-frame id="dialog"> that every
// async open adopts.
export default class DialogsController extends Controller {
  static targets = ["root", "sentinel", "dialog"]

  #stack = []
  #frameCounter = 0

  connect() {
    window.addEventListener("click", this.#interceptTrigger, { capture: true })
    window.addEventListener("submit", this.#interceptTrigger, { capture: true })
    document.addEventListener("turbo:frame-load", this.#handleFrameLoad)
    document.addEventListener("turbo:frame-missing", this.#handleFrameMissing)
    document.addEventListener("turbo:fetch-request-error", this.#handleFrameMissing)
    document.addEventListener("turbo:before-visit", this.closeAll)
    document.addEventListener("turbo:before-cache", this.closeAll)
    document.addEventListener("turbo:before-render", this.#handleBeforeRender)
    document.addEventListener("turbo:render", this.#handleRender)
  }

  disconnect() {
    window.removeEventListener("click", this.#interceptTrigger, { capture: true })
    window.removeEventListener("submit", this.#interceptTrigger, { capture: true })
    document.removeEventListener("turbo:frame-load", this.#handleFrameLoad)
    document.removeEventListener("turbo:frame-missing", this.#handleFrameMissing)
    document.removeEventListener("turbo:fetch-request-error", this.#handleFrameMissing)
    document.removeEventListener("turbo:before-visit", this.closeAll)
    document.removeEventListener("turbo:before-cache", this.closeAll)
    document.removeEventListener("turbo:before-render", this.#handleBeforeRender)
    document.removeEventListener("turbo:render", this.#handleRender)
  }

  // Sync open — data-action="click->dialogs#open" data-id="myDialog" on the trigger.
  open(event) {
    const id = event.currentTarget.dataset.id
    const dialog = this.dialogTargets.find((d) => d.id === id)
    if (!dialog || this.#stack.includes(dialog)) return

    this.#push(dialog, { remote: false })
  }

  closeAll = () => {
    // Copy first: closing dispatches 'close' synchronously, which mutates #stack.
    ;[...this.#stack].reverse().forEach((dialog) => dialog.close())
  }

  // --- async open: adopt the sentinel frame before Turbo navigates it ---------------------

  #interceptTrigger = (event) => {
    const frameName = this.#resolveFrameName(event)
    if (!(frameName in FRAME_ALIASES)) return
    if (!this.hasSentinelTarget) return
    if (this.#opensInNewTab(event)) return

    const sentinel = this.sentinelTarget
    if (sentinel.dataset.pending === "true") return // already adopted, let Turbo re-navigate it

    const trigger = this.#resolveTrigger(event)
    const position = trigger?.dataset.dialogPosition || FRAME_ALIASES[frameName]
    const size = trigger?.dataset.dialogSize || DEFAULT_SIZE
    const dismissible = trigger?.dataset.dialogDismissible !== "false"

    // Deprecated aliases ("modal"/"drawer") point at a frame id that no longer exists in the
    // DOM — only the "dialog" sentinel does. Rewrite the trigger before Turbo reads it (we run
    // first, same capture phase) so its own getElementById(frameName) lookup still finds it.
    // Persist the resolved position on the trigger too: once data-turbo-frame becomes "dialog"
    // it no longer carries the alias, so without this a second click on the same trigger would
    // resolve to the "dialog" default position instead of the alias's preset.
    if (frameName !== FRAME_ID) {
      this.#rewriteFrameName(event, trigger)
      if (trigger && !trigger.dataset.dialogPosition) trigger.dataset.dialogPosition = position
    }

    sentinel.dataset.pending = "true"

    const shell = this.#buildShell({ position, size, dismissible })
    shell.append(sentinel)
    this.rootTarget.append(shell)

    this.#push(shell, { remote: true })
  }

  // A modified click (Cmd/Ctrl/Shift/Alt, middle-click) or a link with target/download makes
  // the browser open a new tab/window instead of navigating in place — Turbo itself ignores
  // these clicks and lets the browser handle them, so we must too, or we'd adopt the sentinel
  // and show an overlay for a navigation that never actually happens on this page.
  #opensInNewTab(event) {
    if (event.type !== "click") return false
    if (event.button !== 0) return true
    if (event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return true

    const trigger = this.#resolveTrigger(event)
    const target = trigger?.getAttribute?.("target")
    if (target && target !== "_self") return true

    return trigger?.hasAttribute?.("download") ?? false
  }

  #resolveFrameName(event) {
    if (event.type === "submit") {
      const form = event.target
      return event.submitter?.dataset.turboFrame || form?.dataset.turboFrame || null
    }

    const trigger = event.target?.closest?.("[data-turbo-frame]")
    return trigger?.dataset.turboFrame || null
  }

  #resolveTrigger(event) {
    if (event.type === "submit") {
      return event.submitter?.dataset.turboFrame ? event.submitter : event.target
    }

    return event.target?.closest?.("[data-turbo-frame]") || null
  }

  #rewriteFrameName(event, trigger) {
    if (!trigger) return
    trigger.dataset.turboFrame = FRAME_ID
  }

  #buildShell({ position, size, dismissible }) {
    const horizontal = HORIZONTAL_POSITIONS.includes(position)
    const edge = position !== DEFAULT_POSITION

    const dialog = document.createElement("dialog")
    dialog.tabIndex = -1
    dialog.className = `dialog dialog-${position} ${horizontal ? "h" : "w"}-${size}`
    dialog.dataset.controller = "dialog"
    dialog.dataset.dialogPositionValue = position
    dialog.dataset.dialogDismissibleValue = String(dismissible)
    dialog.dataset.dialogSwipeValue = String(edge)
    return dialog
  }

  #handleFrameLoad = (event) => {
    const frame = event.target
    if (frame?.tagName !== "TURBO-FRAME") return
    if (frame.id !== FRAME_ID) return

    delete frame.dataset.pending
    delete frame.dataset.dialogsTarget
    frame.id = `${FRAME_ID}-${++this.#frameCounter}`

    this.#respawnSentinel()
    this.#portalFlash()
  }

  #handleFrameMissing = (event) => {
    const frame = event.target
    if (frame?.tagName !== "TURBO-FRAME") return
    if (!new RegExp(`^${FRAME_ID}(-\\d+)?$`).test(frame.id)) return

    const shell = frame.closest("dialog.dialog")
    if (!shell) return

    if (frame.id === FRAME_ID) this.#respawnSentinel()
    shell.close()
  }

  #respawnSentinel() {
    const sentinel = document.createElement("turbo-frame")
    sentinel.id = FRAME_ID
    sentinel.dataset.dialogsTarget = "sentinel"
    this.rootTarget.append(sentinel)
  }

  // --- stack bookkeeping -------------------------------------------------------------------

  #push(dialog, { remote }) {
    dialog.dataset.remote = String(remote)
    this.#stack.push(dialog)
    this.#renumber()

    dialog.addEventListener("close", this.#handleDialogClosed, { once: true })
    dialog.showModal()

    this.#portalFlash()
    dialog.dispatchEvent(new CustomEvent("jet-ui:dialog:opened", {
      bubbles: true,
      detail: { depth: this.#stack.indexOf(dialog), position: dialog.dataset.dialogPositionValue }
    }))
  }

  #handleDialogClosed = (event) => {
    const dialog = event.target
    const index = this.#stack.indexOf(dialog)
    if (index === -1) return

    this.#stack.splice(index, 1)
    this.#renumber()

    dialog.dispatchEvent(new CustomEvent("jet-ui:dialog:closed", { bubbles: true }))

    if (dialog.dataset.remote === "true") dialog.remove()

    this.#portalFlash()
  }

  #renumber() {
    this.#stack.forEach((dialog, index) => { dialog.dataset.depth = String(index) })
  }

  // --- flash portal --------------------------------------------------------------------------
  // The topmost open dialog is promoted to the browser's top layer, which makes everything
  // outside it inert — a flash frame left in <body> would be invisible and unclickable.
  // We move #flash into the topmost dialog's .dialog__flash-slot instead (see dialog.css).

  #portalFlash = () => {
    const flashFrame = document.getElementById("flash")
    if (!flashFrame) return

    const top = this.#stack.at(-1)
    const target = top ? top.querySelector(".dialog__flash-slot") : document.body
    if (target && flashFrame.parentElement !== target) target.append(flashFrame)
  }

  // #dialogs is data-turbo-permanent so open dialogs survive a morph refresh — but that also
  // means Turbo won't merge a fresh #flash into a copy that is currently portaled inside it.
  // Pull it back out to <body> before every render, then re-portal it after.
  #handleBeforeRender = () => {
    const flashFrame = document.getElementById("flash")
    if (flashFrame && flashFrame.parentElement !== document.body) document.body.append(flashFrame)
  }

  #handleRender = () => {
    this.#portalFlash()
  }
}
