import { Controller } from "@hotwired/stimulus"

export default class ClipboardController extends Controller {
  static values = {
    content: String,
    sourceId: String,
    successText: { type: String, default: "Copied!" },
    timeout: { type: Number, default: 2000 }
  }

  connect() {
    this.originalText = this.#hasTooltip
      ? this.element.dataset.tooltipContentValue
      : this.element.textContent
  }

  disconnect() {
    this.liveRegion?.remove()
    this.liveRegion = null
  }

  // Keyboard activation for the <span role="button"> variant. Space would otherwise scroll the
  // page, so we swallow the default and trigger the copy ourselves.
  copyOnKeydown(event) {
    if (event.key === "Enter" || event.key === " ") {
      event.preventDefault()
      this.copy()
    }
  }

  async copy() {
    const text = this.#getContent()
    await navigator.clipboard.writeText(text)

    if (!this.#hasTooltip) {
      this.element.textContent = this.successTextValue
      this.#announce(this.successTextValue)
    }

    this.dispatch("change", { detail: { content: this.successTextValue } })

    setTimeout(() => {
      if (!this.#hasTooltip) {
        this.element.textContent = this.originalText
      }
      this.dispatch("change", { detail: { content: this.originalText } })
    }, this.timeoutValue)
  }

  // Announce success to assistive tech via an off-screen polite live region. Used only for the
  // non-tooltip variant; the tooltip variant surfaces the change through its own element.
  #announce(message) {
    if (!this.liveRegion) {
      this.liveRegion = document.createElement("span")
      this.liveRegion.setAttribute("role", "status")
      this.liveRegion.setAttribute("aria-live", "polite")
      Object.assign(this.liveRegion.style, {
        position: "absolute", width: "1px", height: "1px", padding: "0", margin: "-1px",
        overflow: "hidden", clip: "rect(0, 0, 0, 0)", whiteSpace: "nowrap", border: "0"
      })
      document.body.appendChild(this.liveRegion)
    }
    // Clear first so re-copying the same text is re-announced.
    this.liveRegion.textContent = ""
    requestAnimationFrame(() => { this.liveRegion.textContent = message })
  }

  get #hasTooltip() {
    return this.element.dataset.controller?.includes("tooltip")
  }

  #getContent() {
    if (this.hasSourceIdValue) {
      const el = document.getElementById(this.sourceIdValue)
      return el?.value ?? el?.textContent ?? ""
    }
    return this.contentValue
  }
}
