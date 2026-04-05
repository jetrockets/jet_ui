import { Controller } from "@hotwired/stimulus"

export default class ModalsController extends Controller {
  static targets = ["dialog"]

  disconnect() {
    this.openedDialog?.removeEventListener("click", this.#closeOnBackdropClick.bind(this))
  }

  open(e) {
    this.openedDialog = this.#getDialog(e)
    this.openedDialog?.addEventListener("click", this.#closeOnBackdropClick.bind(this))
    this.openedDialog?.showModal()
  }

  close(e) {
    this.#getDialog(e)?.close()
  }

  #getDialog(e) {
    const id = e.currentTarget.dataset.id
    return this.dialogTargets.find(dialog => dialog.id === id)
  }

  #closeOnBackdropClick(e) {
    if (e.target === this.openedDialog) {
      this.openedDialog.close()
    }
  }
}
