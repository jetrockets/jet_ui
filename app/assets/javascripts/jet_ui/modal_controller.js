import { Controller } from "@hotwired/stimulus"

export default class ModalController extends Controller {
  connect() {
    this._closeOnBackdropClick = this.#closeOnBackdropClick.bind(this)
    this._closeOnCancel = this.#closeOnCancel.bind(this)
    this.element.addEventListener("click", this._closeOnBackdropClick)
    this.element.addEventListener("cancel", this._closeOnCancel)
    this.element.showModal()
  }

  disconnect() {
    this.element.removeEventListener("click", this._closeOnBackdropClick)
    this.element.removeEventListener("cancel", this._closeOnCancel)
    this.close()
  }

  show() {
    this.element.showModal()
  }

  close() {
    try {
      this.element.close()
      ModalController.turboFrame.src = null
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

  static get turboFrame() {
    return document.querySelector("turbo-frame[id='modal']")
  }
}
