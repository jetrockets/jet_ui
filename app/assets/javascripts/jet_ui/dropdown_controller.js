import { Controller } from "@hotwired/stimulus"

export default class DropdownController extends Controller {
  static targets = ["menu", "autofocus"]
  static values = { open: { type: Boolean, default: false } }

  connect() {
    this._handleClick = this.#handleClick.bind(this)
    this._clickOutside = this.#clickOutside.bind(this)
    this._handleKeydown = this.#handleKeydown.bind(this)
    this._handleMorph = this.#handleMorph.bind(this)
    this.element.addEventListener("click", this._handleClick)
    document.addEventListener("turbo:morph", this._handleMorph)
  }

  disconnect() {
    this.element.removeEventListener("click", this._handleClick)
    document.removeEventListener("click", this._clickOutside)
    document.removeEventListener("keydown", this._handleKeydown)
    document.removeEventListener("turbo:morph", this._handleMorph)
  }

  toggle() { this.openValue = !this.openValue }
  show()   { this.openValue = true }
  hide()   { this.openValue = false }

  openValueChanged(isOpen) {
    isOpen ? this.#showMenu() : this.#hideMenu()
  }

  #handleClick(event) {
    if (!this.menuTarget.contains(event.target)) {
      this.toggle()
    }
  }

  #showMenu() {
    this.menuTarget.classList.remove("hidden")
    this.menuTarget.classList.add("block")
    this.#updatePosition()
    if (this.hasAutofocusTarget) this.autofocusTarget.focus()
    document.addEventListener("click", this._clickOutside)
    document.addEventListener("keydown", this._handleKeydown)
  }

  #hideMenu() {
    this.menuTarget.classList.remove("block")
    this.menuTarget.classList.add("hidden")
    document.removeEventListener("click", this._clickOutside)
    document.removeEventListener("keydown", this._handleKeydown)
  }

  #handleKeydown(event) {
    if (event.key === "Escape") this.hide()
  }

  #clickOutside(event) {
    if (!this.element.contains(event.target)) this.hide()
  }

  #handleMorph() {
    if (this.openValue) this.#showMenu()
  }

  #updatePosition() {
    const ref = this.element
    const floating = this.menuTarget
    const refRect = ref.getBoundingClientRect()
    const floatRect = floating.getBoundingClientRect()
    const viewport = { w: window.innerWidth, h: window.innerHeight }
    const gap = 5

    // Coordinates relative to the .dropdown parent (position: relative)
    let x = 0
    let y = ref.offsetHeight + gap

    // Flip up if overflows bottom viewport
    if (refRect.bottom + gap + floatRect.height > viewport.h) {
      y = -(floatRect.height + gap)
    }

    // Shift left if overflows right edge
    if (refRect.left + floatRect.width > viewport.w - 8) {
      x = ref.offsetWidth - floatRect.width
    }

    // Clamp so menu doesn't overflow left edge of viewport
    x = Math.max(-refRect.left + 8, x)

    Object.assign(floating.style, {
      left: `${x}px`,
      top: `${y}px`
    })
  }
}
