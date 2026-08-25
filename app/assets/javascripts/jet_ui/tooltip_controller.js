import { Controller } from "@hotwired/stimulus"

export default class TooltipController extends Controller {
  static values = {
    content: String,
    placement: { type: String, default: "top" }
  }

  connect() {
    this._show = this.#show.bind(this)
    this._hide = this.#hide.bind(this)
    this._handleKeydown = this.#handleKeydown.bind(this)
    this.element.addEventListener("mouseenter", this._show)
    this.element.addEventListener("mouseleave", this._hide)
    this.element.addEventListener("focus", this._show)
    this.element.addEventListener("blur", this._hide)
    this.element.addEventListener("keydown", this._handleKeydown)
  }

  disconnect() {
    this.element.removeEventListener("mouseenter", this._show)
    this.element.removeEventListener("mouseleave", this._hide)
    this.element.removeEventListener("focus", this._show)
    this.element.removeEventListener("blur", this._hide)
    this.element.removeEventListener("keydown", this._handleKeydown)
    this.#hide()
  }

  updateContent(event) {
    const text = event.detail?.content
    if (text) this.contentValue = text
  }

  contentValueChanged(value) {
    if (this.tooltip) {
      this.tooltip.innerHTML = value
      this.#updatePosition()
    }
  }

  #show() {
    this.#createTooltip()
    this.#updatePosition()
  }

  #hide() {
    this.tooltip?.remove()
    this.tooltip = null
    this.element.removeAttribute("aria-describedby")
  }

  #handleKeydown(event) {
    if (event.key === "Escape") this.#hide()
  }

  #createTooltip() {
    this.#hide()
    this.tooltip = document.createElement("div")
    this.tooltip.className = "tooltip"
    this.tooltip.id = `tooltip-${crypto.randomUUID()}`
    this.tooltip.role = "tooltip"
    this.tooltip.innerHTML = this.contentValue
    this.element.setAttribute("aria-describedby", this.tooltip.id)
    const container = this.element.closest("dialog") || document.body
    container.appendChild(this.tooltip)
  }

  #updatePosition() {
    if (!this.tooltip) return

    // Measure tooltip dimensions
    this.tooltip.style.visibility = "hidden"
    this.tooltip.style.position = "fixed"
    this.tooltip.style.left = "-9999px"
    const floatRect = this.tooltip.getBoundingClientRect()
    this.tooltip.style.visibility = ""
    this.tooltip.style.position = ""
    this.tooltip.style.left = ""

    const ref = this.element
    const refRect = ref.getBoundingClientRect()
    const viewport = { w: window.innerWidth, h: window.innerHeight }
    const gap = 8
    const placement = this.placementValue

    let x, y, effectivePlacement = placement

    switch (placement) {
      case "top":
        x = refRect.left + (refRect.width - floatRect.width) / 2
        y = refRect.top - floatRect.height - gap
        if (y < 0) { y = refRect.bottom + gap; effectivePlacement = "bottom" }
        break
      case "bottom":
        x = refRect.left + (refRect.width - floatRect.width) / 2
        y = refRect.bottom + gap
        if (y + floatRect.height > viewport.h) { y = refRect.top - floatRect.height - gap; effectivePlacement = "top" }
        break
      case "left":
        x = refRect.left - floatRect.width - gap
        y = refRect.top + (refRect.height - floatRect.height) / 2
        if (x < 0) { x = refRect.right + gap; effectivePlacement = "right" }
        break
      case "right":
        x = refRect.right + gap
        y = refRect.top + (refRect.height - floatRect.height) / 2
        if (x + floatRect.width > viewport.w) { x = refRect.left - floatRect.width - gap; effectivePlacement = "left" }
        break
      default:
        x = refRect.left + (refRect.width - floatRect.width) / 2
        y = refRect.top - floatRect.height - gap
    }

    // Shift to keep within viewport
    x = Math.max(8, Math.min(x + window.scrollX, viewport.w + window.scrollX - floatRect.width - 8))
    y = Math.max(8, Math.min(y + window.scrollY, viewport.h + window.scrollY - floatRect.height - 8))

    Object.assign(this.tooltip.style, { left: `${x}px`, top: `${y}px` })
    this.tooltip.dataset.placement = effectivePlacement
  }
}
