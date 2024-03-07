import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="rail"
export default class extends Controller {
  static targets = [ "station", "line", "destination" ];

  connect() {
    console.log('💙💛🧡 MARTASTIC 2.0 by Deka Ambia 🧡💛💙');
    console.log('https://github.com/dekadekadeka/');
    console.log('https://www.linkedin.com/in/renee-deka-ambia-96731773/');
    console.log('Portfolio at https://www.deka.ooo');
    console.log('This is not an official MARTA website! They\'re over at https://www.itsmarta.com');
    console.log('💙💛🧡 Have a Martastic day!! 🧡💛💙')
  };

  selectStation() {
    const element = this.stationTarget;
    const station = element.value;
    this.filter(station);
  };
  
  selectDestination() {
    const element = this.destinationTarget;
    const destination = element.value;
    this.filter(destination);
  };

  selectLine() {
    const element = this.lineTarget;
    const line = element.value;
    this.filter(line);
  };

  filter(item) {
    const value = item;

    fetch(`/filter?station=${value}`, {
      contentType: 'application/json',
      hearders: 'application/json',
    })
    .then(resp => resp.text())
    .then(resp => {
      const container = document.getElementById("schedule-container");
      container.innerHTML = resp;
    });
  };

};
