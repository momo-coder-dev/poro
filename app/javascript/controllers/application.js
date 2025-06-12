import { Application } from "@hotwired/stimulus"
import SlimSelect from 'slim-select'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
window.SlimSelect = SlimSelect

export { application }
