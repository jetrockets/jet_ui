import { Controller } from "@hotwired/stimulus"

// @deprecated Only the async (Turbo Frame) dialog markup rendered by JetUi::Dialog::Component
// still uses "modal"/"drawer" as data-turbo-frame aliases — those keep working automatically,
// handled by DialogsController. This standalone controller matches the pre-Dialog async modal
// markup and is no longer wired up by JetUi::Modal::Component. Kept only for apps with custom
// markup still registering it directly. Migrate to the "dialog" controller. Removed in the
// next major version.
export default class ModalController extends Controller {
  connect() {
    this.element.addEventListener("click", this.#closeOnBackdropClick.bind(this))
    this.element.showModal()
  }

  disconnect() {
    this.element.removeEventListener("click", this.#closeOnBackdropClick.bind(this))
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

  static get turboFrame() {
    return document.querySelector("turbo-frame[id='modal']")
  }
}
