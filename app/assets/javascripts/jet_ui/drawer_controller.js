import { Controller } from "@hotwired/stimulus"

export default class DrawerController extends Controller {
  static values = {
    swipeThreshold: { type: Number, default: 100 }
  }

  connect() {
    this._closeOnBackdropClick = this.#closeOnBackdropClick.bind(this)
    this._closeOnCancel = this.#closeOnCancel.bind(this)
    this._onTouchStart = this.#onTouchStart.bind(this)
    this._onTouchMove = this.#onTouchMove.bind(this)
    this._onTouchEnd = this.#onTouchEnd.bind(this)
    this.element.addEventListener("click", this._closeOnBackdropClick)
    this.element.addEventListener("cancel", this._closeOnCancel)
    this.element.addEventListener("touchstart", this._onTouchStart, { passive: true })
    this.element.addEventListener("touchmove", this._onTouchMove, { passive: true })
    this.element.addEventListener("touchend", this._onTouchEnd, { passive: true })
    this.element.showModal()
  }

  disconnect() {
    this.element.removeEventListener("click", this._closeOnBackdropClick)
    this.element.removeEventListener("cancel", this._closeOnCancel)
    this.element.removeEventListener("touchstart", this._onTouchStart)
    this.element.removeEventListener("touchmove", this._onTouchMove)
    this.element.removeEventListener("touchend", this._onTouchEnd)
    this.close()
  }

  show() {
    this.element.showModal()
  }

  close() {
    try {
      this.element.close()
      DrawerController.turboFrame.src = null
      this.element.remove()
    } catch (e) {}
  }

  #closeOnBackdropClick(event) {
    if (event.target === this.element) {
      this.close()
    }
  }

  #closeOnCancel(event) {
    event.preventDefault()
    this.close()
  }

  #onTouchStart(event) {
    this.touchStartX = event.touches[0].clientX
    this.element.style.transition = "none"
  }

  #onTouchMove(event) {
    const currentX = event.touches[0].clientX
    const diff = Math.max(0, currentX - this.touchStartX)
    this.element.style.transform = `translateX(${diff}px)`
  }

  #onTouchEnd(event) {
    const touchEndX = event.changedTouches[0].clientX
    const diff = touchEndX - this.touchStartX

    this.element.style.transition = "transform 0.2s ease-out"

    if (diff > this.swipeThresholdValue) {
      this.element.style.transform = "translateX(100%)"
      this.element.addEventListener("transitionend", () => this.close(), { once: true })
    } else {
      this.element.style.transform = "translateX(0)"
    }
  }

  static get turboFrame() {
    return document.querySelector("turbo-frame[id='drawer']")
  }
}
