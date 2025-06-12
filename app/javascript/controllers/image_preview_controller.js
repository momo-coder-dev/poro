import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="file-preview"
export default class extends Controller {
  static values = {
    url: String, // Initial image URL
  };

  connect() {
    if (this.urlValue) { this.insertImage(this.urlValue);}
  }

  change(event) {
    const file = event.target.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (e) => {
      this.insertImage(e.target.result); // Insert the preview image
    };

    reader.readAsDataURL(file); // Read the file as a data URL
  }

  insertImage(src) {
   let img = this.element.parentElement.querySelector('img')
    if (!img) {
      img = document.createElement("img"); 
      img.alt = "Preview image"; // Provide a meaningful alt text
      img.className = "file-preview h-60 w-70"; // Add a class for styling (optional)
    }
    img.src = src;
     
    // Insert the image before the controller's element
    this.element.parentNode.insertBefore(img, this.element);
  }
}
