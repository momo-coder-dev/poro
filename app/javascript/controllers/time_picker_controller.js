import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
// Connects to data-controller="flatpickr"
export default class extends Controller {

  static values = {
    time_24hr: { type: Boolean, default: true },
  }


  connect() {
    const options = {
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      time_24hr: this.time24hrValue
    }

    flatpickr(this.element, options);

    console.log(this.time24hrValue)

  }
}
