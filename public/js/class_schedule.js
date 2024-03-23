const hourStart = 6;
const hourEnd = 18;
class ClassScheduleEditor extends HTMLElement {
  createMode = true;
  timings = { sun: [{ start_time: '08:00', end_time: '09:00' }] };
  classCounters = [];

  /**
   * @typedef {{start_time: String, end_time: String}} Timing
   */

  /**
   * @param {Timing} timing
  */
  timingExtents(timing) {
    const { start_time, end_time } = timing;
    const hourMap = (hour) => Math.min(Math.max(hour, hourStart), hourEnd) - hourStart + 1;
    const fromHour = +start_time.split(':')[0];
    const toHour = +end_time.split(':')[0];
    return `grid-row-start: ${hourMap(fromHour)}; grid-row-end: ${hourMap(toHour)}`;
  }

  /** @param {Timing} timing  */
  formatTime(timing) {
    const { start_time, end_time } = timing;
    const regex = /^(\d\d):(\d\d)(:\d\d)?/;
    const [_from, fromHour, fromMinute] = start_time.match(regex);
    const [_to, toHour, toMinute] = end_time.match(regex);
    return `${+fromHour}:${fromMinute} &ndash; ${+toHour}:${toMinute}`
  }

  constructor() {
    super();

    const presetTimings = JSON.parse(this.innerText.trim() || 'null');
    if (presetTimings !== null) this.timings = presetTimings;

    this.classCounters = this.dataset.classCounters?.split(',') ?? [];

    this.innerHTML = `
    <style>
      .card-body {position: relative;}
      .card-body::before {
        content: '';
        display: block;
        width: 4.2rem;
        height: 3rem;
        background-color: var(--bs-body-bg);
        z-index: 3;
        position: absolute;
        top: 0;
        inset-inline-start: 0;
      }
      .calendar {
        --numDays: 5;
        --numHours: 13;
        --timeHeight: 60px;
        --calBgColor: var(--bs-secondary-bg);
        display: grid;
        grid-template-columns: auto 1fr;
        max-height: 50vh;
        overflow-y: scroll;
        overflow-x: auto;
      }
      .timeline {
        display: grid;
        grid-template-rows: repeat(var(--numHours), var(--timeHeight));
        position: sticky;
        inset-inline-start: 0;
        z-index: 1;
        background: var(--bs-body-bg);
        padding-inline-end: 10px;
      }
      .timeline>.spacer {
        height: 2rem;
        background: var(--bs-body-bg);
      }
      .time-marker {
        margin-top: -1.5rem;
      }
      .days {
        display: flex;
        flex-wrap: nowrap;
        gap: 5px;
        position: relative;
        min-width: 10vw;
        margin-inline-end: 10px;
      }
      .day {
        flex: 1 1 0;
        min-width: 150px;
      }
      .timings {
        display: grid;
        grid-template-rows: repeat(var(--numHours), var(--timeHeight));
        border-radius: 5px;
        background: var(--calBgColor);
      }
      .timing {
        border-radius: 5px;
        padding: 0.5rem;
        margin: 0 0.5rem;
        user-select: none;
        background-color: var(--bs-secondary);
        border-radius: var(--bs-border-radius);
        padding: 0.25rem;
      }
      .timing>[type="button"] {
        height: 100%;
        width: 100%;
      }
      .date-day {
        background: var(--bs-body-bg);
        font-size: 1.5rem;
        font-weight: 400;
        position: sticky;
        top: 0;
        z-index: 1;
      }
    </style>
    <textarea class="visually-hidden" name="${this.getAttribute('name')}" hidden></textarea>
    <div class="card mb-3">
      <div class="card-header d-flex">
        <span>Class Timings</span>
        <div class="form-check form-check-inline ms-auto">
          <input class="form-check-input" type="checkbox" id="weekendCheck">
          <label class="form-check-label" for="weekendCheck">Show Weekend</label>
        </div>
      </div>
      <div class="card-body">
        <div class="calendar">
          <div class="timeline">
            <div class="spacer"></div>
            <div class="time-marker">6 AM</div>
            <div class="time-marker">7 AM</div>
            <div class="time-marker">8 AM</div>
            <div class="time-marker">9 AM</div>
            <div class="time-marker">10 AM</div>
            <div class="time-marker">11 AM</div>
            <div class="time-marker">12 PM</div>
            <div class="time-marker">1 PM</div>
            <div class="time-marker">2 PM</div>
            <div class="time-marker">3 PM</div>
            <div class="time-marker">4 PM</div>
            <div class="time-marker">5 PM</div>
            <div class="time-marker">6 PM</div>
          </div>
          <div class="days">
            <div class="day" data-day="sun">
              <div class="date-day">Sun</div>
              <div class="timings">
              </div>
            </div>
            <div class="day" data-day="mon">
              <div class="date-day">Mon</div>
              <div class="timings">
              </div>
            </div>
            <div class="day" data-day="tue">
              <div class="date-day">Tue</div>
              <div class="timings">
              </div>
            </div>
            <div class="day" data-day="wed">
              <div class="date-day">Wed</div>
              <div class="timings">
              </div>
            </div>
            <div class="day" data-day="thu">
              <div class="date-day">Thu</div>
              <div class="timings">
              </div>
            </div>
            <div class="day d-none" data-day="fri">
              <div class="date-day">Fri</div>
              <div class="timings">
              </div>
            </div>
            <div class="day d-none" data-day="sat">
              <div class="date-day">Sat</div>
              <div class="timings">
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    `;
    if (!this.hasAttribute('readonly')) {
      this.querySelector('.card').innerHTML += `
      <div class="card-footer d-flex gap-2 text-muted">
        <span>Left Click to Create New Timing</span>
        &centerdot;
        <span>Right Click to Remove Timing</span>
      </div>
    `;
    }

    this.updateValue();

    if (this.timings['fri'] || this.timings['sat']) {
      this.querySelector('#weekendCheck').checked = true;
      this.querySelector('.day[data-day="fri"]').classList.toggle('d-none', false);
      this.querySelector('.day[data-day="sat"]').classList.toggle('d-none', false);
    }

    // Render class timings
    for (const [day, timings] of Object.entries(this.timings)) {
      const elem = this.querySelector(`[data-day="${day}"]>.timings`);
      timings.forEach((timing, index) => {
        this.appendTimingDOM(elem, timing, day, index);
      });
    }

    // attach listeners
    this.querySelector('#weekendCheck').addEventListener('change', (event) => {
      this.querySelector('.day[data-day="fri"]').classList.toggle('d-none', event.value);
      this.querySelector('.day[data-day="sat"]').classList.toggle('d-none', event.value);
    });

    if (this.hasAttribute('readonly')) return;

    this.querySelectorAll('.timings').forEach((elem) => {
      elem.addEventListener('click', (event) => {
        if (event.target === elem && this.createMode) {
          const day = elem.closest('.day').dataset.day;
          const start_time =
            Math.floor(
              hourStart + (hourEnd - hourStart + 1) * (event.offsetY / elem.getBoundingClientRect().height)
            );

          // if timing exists don't create another one
          if (Object.values(this.timings[day] ?? []).find((e) => {
            const { start_time: from, end_time: to } = e;
            const fromHour = +from.split(':')[0];
            const toHour = +to.split(':')[0];
            return start_time >= fromHour && start_time < toHour;
          })) {
            return;
          }

          const timing = {
            start_time: start_time.toString().padStart(2, '0') + ':00',
            end_time: (start_time + 1).toString().padStart(2, '0') + ':00'
          };
          if (!this.timings[day]) this.timings[day] = [];
          const index = this.timings[day].push(timing) - 1;
          this.appendTimingDOM(elem, timing, day, index);
          this.updateClassCounters();
        }
      });
    });
  }

  appendTimingDOM(elem, timing, day, index) {
    const timingElem = document.createElement('div');
    timingElem.classList.add('dropend', 'timing');
    timingElem.dataset.day = day;
    timingElem.dataset.index = index;
    timingElem.style = this.timingExtents(timing);
    timingElem.innerHTML = `
      <div type="button" class="" ${this.hasAttribute('readonly') ? '' : 'data-bs-toggle="dropdown"'} aria-expanded="false">
        ${this.formatTime(timing)}</div>
      <div class="dropdown-menu">
        <div class="vstack gap-3 p-2">
        <div>
          <label>From</label>
          <input class="form-control fromtime" type="time" value="${timing.start_time}" onkeydown="return event.key != 'Enter';">
        </div>
        <div>
          <label>To</label>
          <input class="form-control totime" type="time" value="${timing.end_time}" onkeydown="return event.key != 'Enter';">
        </div>
        <button type="button" class="btn btn-danger removebtn">Remove</button>
        </div>
      </div>
      `;

    elem.append(timingElem);

    // attach timing listeners 
    if (this.hasAttribute('readonly')) return;

    timingElem.querySelector('.fromtime').addEventListener('change', (e) => this.onTimeInputChanged(e.target, 'from'));
    timingElem.querySelector('.totime').addEventListener('change', (e) => this.onTimeInputChanged(e.target, 'to'));
    timingElem.querySelector('.removebtn').addEventListener('click', (e) => this.removeTiming(e.target));
    timingElem.querySelector('[type="button"]').addEventListener('contextmenu', (e) => { e.preventDefault(); return false; }, false);
    timingElem.querySelector('[type="button"]').addEventListener('mouseup', (event) => {
      if (event.button == 2) {
        this.removeTiming(event.target);
      }
    });
    timingElem.querySelector('[type="button"]').addEventListener('hide.bs.dropdown', () => { this.createMode = true; });
    timingElem.querySelector('[type="button"]').addEventListener('show.bs.dropdown', () => {
      setTimeout(() => {
        this.createMode = false;
      }, 100)
    });
  }

  /** @param {HTMLElement} elem  */
  onTimeInputChanged(elem, type) {
    const timingElem = elem.closest('.timing');
    const day = timingElem.dataset.day;
    const index = timingElem.dataset.index;
    const timing = this.timings[day][index];
    if (type == 'from') {
      this.timings[day][index].start_time = elem.value;

      const newHour = +elem.value.split(':')[0];
      const [endTimeHour, endTimeMinute] = timing.end_time.split(':');
      if (newHour >= +endTimeHour) {
        this.timings[day][index].end_time = (newHour + 1).toString().padStart(2, '0') + ':' + endTimeMinute;
        timingElem.querySelector('.totime').value = timing.end_time;
      }
    } else {
      this.timings[day][index].end_time = elem.value;
    }
    timingElem.style = this.timingExtents(timing);
    timingElem.querySelector('[type="button"]').innerHTML = this.formatTime(timing);
    this.updateValue();
  }

  /** @param {HTMLElement} elem  */
  removeTiming(elem) {
    const timingElem = elem.closest('.timing');
    const day = timingElem.dataset.day;
    const index = timingElem.dataset.index;
    this.timings[day][index] = null;
    delete this.timings[day][index];
    timingElem.remove();
    this.updateClassCounters();
    this.createMode = true;
  }

  updateClassCounters() {
    this.classCounters.forEach(classCounterId => {
      const elem = document.getElementById(classCounterId);
      elem.dataset.classesPerWeek = Object.values(this.timings).flat().length;
    });
    this.updateValue();
  }

  updateValue() {
    this.querySelector('textarea').innerText = JSON.stringify(Object.entries(this.timings)
      .flatMap(
        ([day, timings]) => timings.map((timing) => ({
          ...timing,
          day_of_week: day.toUpperCase()
        }))
      ));
  }

}

/** @param {Event} e */
function preventContext(e) {
  e.preventDefault();
  return false;
}

customElements.define('class-schedule-editor', ClassScheduleEditor);
