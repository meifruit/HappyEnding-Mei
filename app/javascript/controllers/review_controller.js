import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review-popup"
export default class extends Controller {
  static targets = ["items", "form"]
  connect() {
    console.log("hello")
    console.log("my form", this.formTarget)
    console.log("my items", this.itemsTarget)
    this.csrToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
  }
  send(event) {
    event.preventDefault()
    // console.log(event)
    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": this.csrToken },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data.form)
      if (data.form) {
      this.itemsTarget.insertAdjacentHTML('beforeend', data.form)
      }
      this.formTarget.outerHTML = data.my_form
    })
  }
}
