import { Controller } from "@hotwired/stimulus"

// ui.jetrockets.com's TextArea field used the third-party
// `stimulus-textarea-autogrow` package (stimulus-components.com) for this.
// jet_ui has no external JS dependencies (every other controller in this
// gem is hand-written), so this is a small built-in equivalent instead of
// adding the first one. It matches the package's documented behavior,
// including the part that's easy to miss: height is recalculated on
// window resize too, not just on input, since a change in the textarea's
// width changes how many lines the same text wraps into.
export default class TextareaAutogrowController extends Controller {
  static values = {
    resizeDebounceDelay: { type: Number, default: 100 }
  }

  connect() {
    this.#resize()
    this.element.addEventListener("input", this.#resize)

    if (this.resizeDebounceDelayValue > 0) {
      window.addEventListener("resize", this.#debouncedResize)
    }
  }

  disconnect() {
    this.element.removeEventListener("input", this.#resize)
    window.removeEventListener("resize", this.#debouncedResize)
    clearTimeout(this.resizeTimeout)
  }

  #resize = () => {
    this.element.style.height = "auto"
    this.element.style.height = `${this.element.scrollHeight}px`
  }

  #debouncedResize = () => {
    clearTimeout(this.resizeTimeout)
    this.resizeTimeout = setTimeout(this.#resize, this.resizeDebounceDelayValue)
  }
}
