import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review-popup"
export default class extends Controller {
  connect() {
    console.log("hello")
  }
}
