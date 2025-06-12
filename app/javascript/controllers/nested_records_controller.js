import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-records"
export default class extends Controller {
  static targets = ['container', 'newRecordTemplate']
  
  connect() {
    console.log(this.activeRecords.length)
    if(!this.activeRecords.length){ this._addNewRecord()}
  }

  addNewRecord(e){
    e.preventDefault()
    this._addNewRecord()
  }

  get activeRecords(){ return this.containerTarget.querySelectorAll('.nestedRecord') }

  _addNewRecord(){
    const template = this.newRecordTemplateTarget.textContent.replace(/NEW_RECORD/g, new Date().getTime());
    const a = new DOMParser().parseFromString(template, 'text/html').body.firstChild;
    this.containerTarget.appendChild(a)
  }

}
