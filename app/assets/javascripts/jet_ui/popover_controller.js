import { Controller } from "@hotwired/stimulus"

export default class PopoverController extends Controller {
  static targets = ["content"]
  static values = {
    open: { type: Boolean, default: false },
    placement: { type: String, default: "bottom" }
  }

  connect() {
    this._mouseEnter = () => { this.openValue = true }
    this._mouseLeave = () => { this.openValue = false }
    this._handleMorph = this.#handleMorph.bind(this)
    this.element.addEventListener("mouseenter", this._mouseEnter)
    this.element.addEventListener("mouseleave", this._mouseLeave)
    document.addEventListener("turbo:morph", this._handleMorph)
  }

  disconnect() {
    this.element.removeEventListener("mouseenter", this._mouseEnter)
    this.element.removeEventListener("mouseleave", this._mouseLeave)
    document.removeEventListener("turbo:morph", this._handleMorph)
  }

  openValueChanged(isOpen) {
    isOpen ? this.#showContent() : this.#hideContent()
  }

  #showContent() {
    this.contentTarget.classList.add("popover--visible")
    this.#updatePosition()
  }

  #hideContent() {
    this.contentTarget.classList.remove("popover--visible")
  }

  #handleMorph() {
    if (this.openValue) this.#showContent()
  }

  #updatePosition() {
    const ref = this.element
    const floating = this.contentTarget
    const refRect = ref.getBoundingClientRect()
    const floatRect = floating.getBoundingClientRect()
    const viewport = { w: window.innerWidth, h: window.innerHeight }
    const gap = 12
    const placement = this.placementValue

    let x, y, effectivePlacement = placement

    switch (placement) {
      case "bottom":
        x = (refRect.width - floatRect.width) / 2
        y = refRect.height + gap
        if (refRect.bottom + gap + floatRect.height > viewport.h) {
          y = -(floatRect.height + gap); effectivePlacement = "top"
        }
        break
      case "top":
        x = (refRect.width - floatRect.width) / 2
        y = -(floatRect.height + gap)
        if (refRect.top - gap - floatRect.height < 0) {
          y = refRect.height + gap; effectivePlacement = "bottom"
        }
        break
      case "right":
        x = refRect.width + gap
        y = (refRect.height - floatRect.height) / 2
        if (refRect.right + gap + floatRect.width > viewport.w) {
          x = -(floatRect.width + gap); effectivePlacement = "left"
        }
        break
      case "left":
        x = -(floatRect.width + gap)
        y = (refRect.height - floatRect.height) / 2
        if (refRect.left - gap - floatRect.width < 0) {
          x = refRect.width + gap; effectivePlacement = "right"
        }
        break
      default:
        x = (refRect.width - floatRect.width) / 2
        y = refRect.height + gap
    }

    // Shift horizontally to stay in viewport
    const absoluteX = refRect.left + x
    if (absoluteX < 8) x += (8 - absoluteX)
    if (absoluteX + floatRect.width > viewport.w - 8) x -= (absoluteX + floatRect.width - viewport.w + 8)

    Object.assign(floating.style, { left: `${x}px`, top: `${y}px` })
    floating.dataset.placement = effectivePlacement
  }
}
