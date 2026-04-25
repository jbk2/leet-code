import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-user-form"
export default class extends Controller {
  static targets = [ "dealerNameField" ]
  connect() {
    console.log(`NewUserForm Controller connected; ${this.identifier}`);
    console.log('NewUserForm dealerNameFieldTarget is;', this.dealerNameFieldTarget);
  }

  toggleDealerNameField(event) {
    const isDealer = event.target.checked;
    this.dealerNameFieldTarget.hidden = !isDealer;
  }
}
