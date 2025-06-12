import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["quantity", "total", "submit"]
  static values = {
    price: Number
  }

  connect() {
    this.updateTotal()
    this.updateSubmitButton()
  }

  updateQuantity(event) {
    const input = event.target
    const max = parseInt(input.max)
    const value = parseInt(input.value)

    // Ensure value is not negative
    if (value < 0) {
      input.value = 0
    }
    // Ensure value doesn't exceed available tickets
    else if (value > max) {
      input.value = max
    }

    this.updateTotal()
    this.updateSubmitButton()
  }

  updateTotal() {
    let total = 0
    this.quantityTargets.forEach(input => {
      const price = parseFloat(input.dataset.price)
      const quantity = parseInt(input.value) || 0
      total += price * quantity
    })

    this.totalTarget.textContent = this.formatCurrency(total)
  }

  updateSubmitButton() {
    const hasTickets = this.quantityTargets.some(input => (parseInt(input.value) || 0) > 0)
    this.submitTarget.disabled = !hasTickets
    
    // Update button appearance
    if (hasTickets) {
      this.submitTarget.classList.remove('bg-gray-300', 'cursor-not-allowed')
      this.submitTarget.classList.add('btn-primary', 'cursor-pointer')
    } else {
      this.submitTarget.classList.add('bg-gray-300', 'cursor-not-allowed')
      this.submitTarget.classList.remove('btn-primary', 'cursor-pointer')
    }
  }

  formatCurrency(amount) {
    return new Intl.NumberFormat('fr-FR', {
      style: 'currency',
      currency: 'XOF',
      minimumFractionDigits: 0
    }).format(amount)
  }
} 