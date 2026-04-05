import { Controller } from "@hotwired/stimulus"

export default class DrawersController extends Controller {
  static targets = ["dialog"]
  static values = {
    swipeThreshold: { type: Number, default: 100 }
  }

  disconnect() {
    this.#removeDialogListeners()
  }

  open(e) {
    this.openedDialog = this.#getDialog(e)
    this.#addDialogListeners()
    this.openedDialog?.showModal()
  }

  close(e) {
    this.#removeDialogListeners()
    this.#getDialog(e)?.close()
  }

  #getDialog(e) {
    const id = e.currentTarget.dataset.id
    return this.dialogTargets.find(dialog => dialog.id === id)
  }

  #addDialogListeners() {
    if (!this.openedDialog) return
    this._backdropClick = this.#closeOnBackdropClick.bind(this)
    this._touchStart = this.#onTouchStart.bind(this)
    this._touchMove = this.#onTouchMove.bind(this)
    this._touchEnd = this.#onTouchEnd.bind(this)
    this.openedDialog.addEventListener("click", this._backdropClick)
    this.openedDialog.addEventListener("touchstart", this._touchStart, { passive: true })
    this.openedDialog.addEventListener("touchmove", this._touchMove, { passive: true })
    this.openedDialog.addEventListener("touchend", this._touchEnd, { passive: true })
  }

  #removeDialogListeners() {
    if (!this.openedDialog || !this._backdropClick) return
    this.openedDialog.removeEventListener("click", this._backdropClick)
    this.openedDialog.removeEventListener("touchstart", this._touchStart)
    this.openedDialog.removeEventListener("touchmove", this._touchMove)
    this.openedDialog.removeEventListener("touchend", this._touchEnd)
  }

  #closeOnBackdropClick(e) {
    if (e.target === this.openedDialog) {
      this.openedDialog.close()
    }
  }

  #onTouchStart(event) {
    this.touchStartX = event.touches[0].clientX
    this.openedDialog.style.transition = "none"
  }

  #onTouchMove(event) {
    const currentX = event.touches[0].clientX
    const diff = Math.max(0, currentX - this.touchStartX)
    this.openedDialog.style.transform = `translateX(${diff}px)`
  }

  #onTouchEnd(event) {
    const touchEndX = event.changedTouches[0].clientX
    const diff = touchEndX - this.touchStartX

    this.openedDialog.style.transition = "transform 0.2s ease-out"

    if (diff > this.swipeThresholdValue) {
      this.openedDialog.style.transform = "translateX(100%)"
      this.openedDialog.addEventListener("transitionend", () => {
        this.openedDialog.close()
        this.openedDialog.style.transform = ""
        this.openedDialog.style.transition = ""
      }, { once: true })
    } else {
      this.openedDialog.style.transform = "translateX(0)"
    }
  }
}
