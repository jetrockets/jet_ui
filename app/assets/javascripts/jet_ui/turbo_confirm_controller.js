import { Controller } from "@hotwired/stimulus"

export default class TurboConfirmController extends Controller {
  connect() {
    window.Turbo.config.forms.confirm = (message) => {
      const dialog = this.element
      const messageEl = dialog.querySelector("p")
      if (messageEl) messageEl.textContent = message
      dialog.showModal()

      return new Promise((resolve) => {
        dialog.addEventListener("close", () => {
          resolve(dialog.returnValue === "confirm")
        }, { once: true })

        dialog.addEventListener("click", (event) => {
          if (event.target === dialog) {
            dialog.returnValue = "cancel"
            dialog.close()
          }
        })
      })
    }
  }
}
