import { Controller } from "@hotwired/stimulus"

export default class DropdownController extends Controller {
  static targets = ["trigger", "menu", "item", "autofocus"]
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

  // `refocus` returns focus to the trigger — used when closing via keyboard (Esc) so the user
  // is not stranded on a hidden element.
  hide(refocus = false) {
    this.openValue = false
    if (refocus && this.hasTriggerTarget) this.triggerTarget.focus()
  }

  openValueChanged(isOpen) {
    if (this.hasTriggerTarget) this.triggerTarget.setAttribute("aria-expanded", String(isOpen))
    isOpen ? this.#showMenu() : this.#hideMenu()
  }

  // Keyboard activation on the trigger. The default trigger is a <span role="button">, which
  // does not fire a native click on Enter/Space, so we drive it here. preventDefault also stops
  // native buttons/links from firing their own click, keeping the toggle from double-firing.
  triggerKeydown(event) {
    switch (event.key) {
      case "Enter":
      case " ":
        event.preventDefault()
        this.toggle()
        if (this.openValue) this.#focusItem(0)
        break
      case "ArrowDown":
        event.preventDefault()
        this.show()
        this.#focusItem(0)
        break
      case "ArrowUp":
        event.preventDefault()
        this.show()
        this.#focusItem(-1)
        break
      case "Escape":
        if (this.openValue) { event.preventDefault(); this.hide(true) }
        break
    }
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

  // Roving keyboard navigation while the menu is open (WAI-ARIA menu button pattern).
  #handleKeydown(event) {
    switch (event.key) {
      case "Escape":
        event.preventDefault()
        this.hide(true)
        break
      case "ArrowDown":
        event.preventDefault()
        this.#focusItem(this.#currentItemIndex() + 1)
        break
      case "ArrowUp":
        event.preventDefault()
        this.#focusItem(this.#currentItemIndex() - 1)
        break
      case "Home":
        event.preventDefault()
        this.#focusItem(0)
        break
      case "End":
        event.preventDefault()
        this.#focusItem(-1)
        break
      case "Tab":
        this.hide()
        break
    }
  }

  #currentItemIndex() {
    return this.itemTargets.indexOf(document.activeElement)
  }

  // Focus the item at `index`, wrapping around both ends (index -1 focuses the last item).
  #focusItem(index) {
    const items = this.itemTargets
    if (items.length === 0) return
    const count = items.length
    items[((index % count) + count) % count].focus()
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
