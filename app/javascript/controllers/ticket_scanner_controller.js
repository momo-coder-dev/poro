import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form', 'searchInput']
  connect() {
    console.log(this.formTarget)
    console.log(this.searchInputTarget)
    const qrRegionId = 'reader'
    const html5QrCode = new Html5Qrcode(qrRegionId);

    const qrConfig = {
      fps: 10,
      qrbox: { width: 250, height: 250 }
    };

    const onScanSuccess = (decodedText, decodedResult) => {
      console.log("Scanned code:", decodedText);
      document.getElementById("scan-result").innerText = `✅ Ticket scanned: ${decodedText}`;
      this.searchInputTarget.value = decodedText
       this.formTarget.requestSubmit()

      html5QrCode.stop();
    };

    const onScanFailure = error => {
      // Handle scan errors silently
    };

    Html5Qrcode.getCameras().then(cameras => {
      if (cameras && cameras.length) {
        html5QrCode.start(
          { facingMode: "environment" },
          qrConfig,
          onScanSuccess,
          onScanFailure
        );
      } else {
        document.getElementById("scan-result").innerText = "❌ No camera found.";
      }
    }).catch(err => {
      console.error(err);
      document.getElementById("scan-result").innerText = "❌ Camera access denied.";
    });
  }
}
