import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["filterSecondaryFields", "filterButton"]
  static values = {
    indexUrl: String
  }

  connect() {
    console.log("Item table controller connected")
  }

  toggleSecondaryFields() {
    this.filterSecondaryFieldsTarget.classList.toggle("hidden")
    this.filterButtonTarget.classList.toggle("filter-open")
  }

  changePageLimit(event) {
    event.preventDefault();
    const value = event.target.value;
    console.log("changePageLimit", value)
  
    const url = new URL(window.location.href);
    url.searchParams.set('items', value);
  
    window.location.replace(url.toString());
  }
  
} 