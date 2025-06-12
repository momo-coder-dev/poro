import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Connects to data-controller="flatpickr"
export default class extends Controller {

  static values = {
    showMonths: { type: Number, default: 1 },
    enableTime: { type: Boolean, default: false },
    enableSeconds: { type: Boolean, default: false },
    minDate: { type: String, default: null },
    onlyTime: { type: Boolean, default: false },
  }

  connect() {
    const options = {
      showMonths: this.showMonthsValue,
      enableTime: this.enableTimeValue,
      enableSeconds: this.enableSecondsValue,
      minDate: this.minDateValue,
      dateFormat: "Y-m-d H:i:S",
      time_24hr: true,
    }

    flatpickr(this.element, options);

  }
}
