import { Controller } from "@hotwired/stimulus"

// @deprecated JetUi::Modal::Component's sync-mode markup now targets
// data-dialogs-target="dialog" (see JetUi::Dialog::Component), not
// data-modals-target="dialog" — this controller no longer matches it. Migrate your
// data-controller="modals" wrapper and click->modals#open actions to "dialogs" /
// click->dialogs#open. Removed in the next major version.
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
