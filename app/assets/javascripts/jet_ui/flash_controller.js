import { Controller } from "@hotwired/stimulus"

export default class FlashController extends Controller {
  static values = {
    dismissAfter: Number,
    showDelay: { type: Number, default: 0 }
  }

  connect() {
    setTimeout(() => this.#show(), this.showDelayValue)

    if (this.hasDismissAfterValue) {
      setTimeout(() => this.close(), this.showDelayValue + this.dismissAfterValue)
    }
  }

  close() {
    this.element.classList.remove("flash-item--visible")
    const fallback = setTimeout(() => this.element.remove(), 400)
    this.element.addEventListener("transitionend", () => {
      clearTimeout(fallback)
      this.element.remove()
    }, { once: true })
  }

  #show() {
    this.element.classList.remove("flash-item--hidden")
    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        this.element.classList.add("flash-item--visible")
      })
    })
  }
}
