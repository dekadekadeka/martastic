import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="rail"
export default class extends Controller {
  static targets = [ 'station', 'line', 'destination' ];

  connect() {
    console.log('💙💛🧡 MARTASTIC 2.0 by Deka Ambia 🧡💛💙');
    console.log('https://github.com/dekadekadeka/');
    console.log('https://www.linkedin.com/in/renee-deka-ambia-96731773/');
    console.log('Portfolio at https://www.deka.ooo');
    console.log('This is not an official MARTA website! They\'re over at https://www.itsmarta.com');
    console.log('💙💛🧡 Have a Martastic day!! 🧡💛💙');
    document.getElementById('filter-form').reset();
    fetch('/filter')
      .then(resp => resp.json())
      .then(resp => this.renderScheduleCards(resp.rail_data))
  };

  filter(event) {
    // Query params structure: /filter?station=<>&destination=<>&line=<>
    const queryParams = [];

    if (event.target === this.stationTarget) {
      this.destinationTarget.value = '';
      this.lineTarget.value = '';
    }
    
    [this.stationTarget, this.destinationTarget, this.lineTarget].forEach(element => {
      queryParams.push(`${element.id}=${element.value}`);
    });

    const filterString = queryParams.join('&');

    fetch(`/filter?${filterString}`)
      .then(resp => resp.json())
      .then(resp => {
        if (resp.error) {
          const scheduleContainer = document.getElementById('schedule-container');
          scheduleContainer.innerHTML = `
            <div class="empty">
              <h1>${resp.error}</h1>
            </div>
          `
        } else {
          const destinationValue = this.destinationTarget.value;
          const lineValue = this.lineTarget.value;
          this.renderDropdownOptions(resp.destinations, 'destination', destinationValue);
          this.renderDropdownOptions(resp.lines, 'line', lineValue);
          this.renderScheduleCards(resp.rail_data);
        }
      })
      .catch(err => console.log(err));
  };

  renderDropdownOptions(options, optionType, value) {
    const optionSelect = document.getElementById(optionType);
    let optionString = `<option value="">Any ${optionType}</option>`;
    options.map(option => {
      optionString += `<option value="${option}">${option} ${optionType === 'line' ? 'line' : ''}</option>`
    });
    optionSelect.innerHTML = optionString;
    if (options.length === 1) {
      optionSelect.value = options[0];
    } else {
      optionSelect.value = value;
    }
  };

  renderScheduleCards(railData) {
    const scheduleContainer = document.getElementById('schedule-container');
    let scheduleCardString = '';
    railData.map(data => {
      scheduleCardString += `
        <div class="schedule-card ${data["LINE"].toLowerCase()}">
        <div class="arriving-at-container">
          <div class="arriving-at">
            <span class="secondary-info">
              Next ${data["LINE"].toLowerCase()} line train arriving at
            </span>
            <span class="arrow">
              ${data["DIRECTION"]}
              <img src="/assets/arrow-up.svg" class="arrow ${data["DIRECTION"]}">
            </span>
          </div>
          <span class="station-name">
            ${data["STATION"].split(" STATION")[0].toLowerCase()}
          </span>
        </div>
        <div class="bound-for">
          <span class="secondary-info">Bound for</span>
          <br>
          <span class="station-name">${data["DESTINATION"]}</span>
        </div>
        <span class="time-info">
        ${data["WAITING_TIME"] === 'Arriving' ? 'now' : `in ${data["WAITING_TIME"]} at ${data["NEXT_ARR"]}`}
        </span>
      </div>
      `
    });
    scheduleContainer.innerHTML = scheduleCardString;
  };
};
