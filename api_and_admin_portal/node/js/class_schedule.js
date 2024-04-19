const hourStart = 6;
const hourEnd = 18;
class ClassScheduleEditor extends HTMLElement {
  createMode = true;
  timings = { sun: [{ start_time: '08:00', end_time: '09:00' }] };
  classCounters = [];
  i18n = ClassScheduleEditor.l10n.en;
  coachSelect;
  coachEndpoint;
  csrfToken;

  static l10n = {
    en: {
      classTimings: 'Class Timings',
      showWeekend: 'Show Weekend',
      showCoachSchedule: 'Show Coach Schedule',
      sun: 'Sun',
      mon: 'Mon',
      tue: 'Tue',
      wed: 'Wed',
      thu: 'Thu',
      fri: 'Fri',
      sat: 'Sat',
      helpCreate: 'Left Click to Create New Timing',
      helpRemove: 'Right Click to Remove Timing',
      from: 'From',
      to: 'To',
      remove: 'Remove',
      coachBusy: 'coach is busy at this time',
    },
    ar: {
      classTimings: 'توقيتات الصف',
      showWeekend: 'أظهر نهاية الأسبوع',
      showCoachSchedule: 'أظهر جدول المدرب',
      sun: 'الأحد',
      mon: 'الإثنين',
      tue: 'الثلاثاء',
      wed: 'الأربعاء',
      thu: 'الخميس',
      fri: 'الجمعة',
      sat: 'السبت',
      helpCreate: 'اضغط زر المؤشر الأيسر لإنشاء توقيت',
      helpRemove: 'اضغط زر المؤشر الأيمن لإزالة توقيت',
      from: 'من',
      to: 'إلى',
      remove: 'إزالة',
      coachBusy: 'المدرب مشغول هذا الوقت',
    },
  };

  /**
   * @typedef {{start_time: String, end_time: String}} Timing
   */


  constructor() {
    super();

    this.i18n = ClassScheduleEditor.l10n[document.querySelector('html').lang];

    const presetTimings = JSON.parse(this.innerText.trim() || 'null');
    if (presetTimings !== null) this.timings = presetTimings;

    this.classCounters = this.dataset.classCounters?.split(',') ?? [];
    this.coachSelect = this.dataset.coachSelect;
    this.coachEndpoint = this.dataset.coachEndpoint;
    this.csrfToken = this.dataset.csrfToken;

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
        direction: ltr;
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
        flex-grow: 1;
        min-width: 150px;
      }
      .timings {
        display: grid;
        grid-template-rows: repeat(var(--numHours), var(--timeHeight));
        border-radius: 5px;
        background: var(--calBgColor);
      }
      .timing {
        margin: 0 0 3px;
        user-select: none;
      }
      .timing>[type="button"] {
        height: 100%;
        width: 100%;
        font-weight: 400;
      }
      .timing>[type="button"].is-coach {
        --bs-bg-opacity: 0.5;
        --bs-border-opacity: 1;
        color: #fff;
        border-color: rgba(var(--bs-light-rgb), var(--bs-border-opacity)) !important;
        background-color: RGBA(var(--bs-dark-rgb), var(--bs-bg-opacity, 1)) !important;
        font-size: 1rem !important;
        pointer-events: none;
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
        <span>${this.i18n.classTimings}</span>
        <div class="form-check form-check-inline ms-auto">
          <input class="form-check-input" type="checkbox" id="weekendCheck">
          <label class="form-check-label" for="weekendCheck">${this.i18n.showWeekend}</label>
        </div>
        <div class="form-check form-check-inline ms-3">
          <input class="form-check-input" type="checkbox" id="coachCheck">
          <label class="form-check-label" for="coachCheck">${this.i18n.showCoachSchedule}</label>
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
            ${['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'].map(
      day => `<div class="day" data-day="${day}">
                <div class="date-day">${this.i18n[day]}</div>
                <div class="timings">
                </div>
              </div>`).join('')}
          </div>
        </div>
      </div>
    </div>
    `;
    if (!this.hasAttribute('readonly')) {
      this.querySelector('.card').innerHTML += `
      <div class="card-footer d-flex gap-2 text-muted">
        <span>${this.i18n.helpCreate}</span>
        &centerdot;
        <span>${this.i18n.helpRemove}</span>
      </div>
    `;
    }

    this.updateValue();

    {
      const showWeekend = this.timings['fri'] || this.timings['sat'];
      this.querySelector('#weekendCheck').checked = showWeekend;
      this.querySelector('.day[data-day="fri"]').classList.toggle('d-none', !showWeekend);
      this.querySelector('.day[data-day="sat"]').classList.toggle('d-none', !showWeekend);
    };

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

    this.querySelector('#coachCheck').addEventListener('change', (event) => {
      this.querySelectorAll('.is-coach').forEach(el => el.parentElement.classList.toggle('show', event.target.checked));
    });


    // get coach schedule
    if (this.hasAttribute('readonly')) {
      this.getCoachSchedule(this.dataset.coachId);
    }

    // the rest of listeners only apply to edit mode
    if (this.hasAttribute('readonly')) return;

    // get coach schedule
    const coachSelect = document.querySelector(this.coachSelect);
    this.getCoachSchedule(coachSelect.value);
    this.querySelector('#coachCheck').checked = true;
    coachSelect.addEventListener('change', (event) => {
      document.querySelectorAll('.is-coach').forEach(element => {
        element.parentElement.remove();
      });
      this.getCoachSchedule(event.target.value);
    });

    this.querySelectorAll('.timings').forEach((elem) => {
      elem.addEventListener('click', (event) => {
        if (event.target === elem && this.createMode) {
          const day = elem.closest('.day').dataset.day;
          const start_time =
            Math.floor(
              hourStart + (hourEnd - hourStart + 1) * (event.offsetY / elem.getBoundingClientRect().height)
            );

          // if timing exists don't create another one
          const timings = (this.timings[day] ?? []).concat(this.coachTimings[day] ?? []);
          if (Object.values(timings).find((e) => {
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

  /**
   * @param {Timing} timing
  */
  timingExtents(timing) {
    const { start_time, end_time } = timing;
    const hourMap = (hour) => Math.min(Math.max(hour, hourStart), hourEnd) - hourStart + 1;
    const fromHour = +start_time.split(':')[0];
    const toHour = +end_time.split(':')[0];
    return `grid-row: ${hourMap(fromHour)} / ${hourMap(toHour)}`;
  }

  /** @param {Timing} timing  */
  formatTime(timing) {
    const { start_time, end_time } = timing;
    const regex = /^(\d\d):(\d\d)(:\d\d)?/;
    const [_from, fromHour, fromMinute] = start_time.match(regex);
    const [_to, toHour, toMinute] = end_time.match(regex);
    return `${+fromHour}:${fromMinute} &ndash; ${+toHour}:${toMinute}`
  }

  appendTimingDOM(elem, timing, day, index, isCoach = false) {
    const timingElem = document.createElement('div');
    timingElem.classList.add('dropend', 'timing', 'fade');
    timingElem.dataset.day = day;
    timingElem.dataset.index = index;
    timingElem.style = this.timingExtents(timing);
    let classes = 'btn btn-secondary px-0 fs-5'; {
      if (this.hasAttribute('readonly')) classes += ' pe-none';
      if (isCoach) classes += ' is-coach';
      if (!(this.hasAttribute('readonly') && isCoach)) timingElem.classList.add('show');
    }

    timingElem.innerHTML = `
      <div type="button"
        class="${classes}"
        ${this.hasAttribute('readonly') ? '' : 'data-bs-toggle="dropdown"'} 
        aria-expanded="false">
        ${this.formatTime(timing)}${isCoach ? '<br>' + timing.class_name : ''}
      </div>
      <div class="dropdown-menu">
        <div class="vstack gap-3 p-2">
        <div>
          <label>${this.i18n.from}</label>
          <input class="form-control fromtime" type="time" value="${timing.start_time}" onkeydown="return event.key != 'Enter';">
        </div>
        <div>
          <label>${this.i18n.to}</label>
          <input class="form-control totime" type="time" value="${timing.end_time}" onkeydown="return event.key != 'Enter';">
        </div>
        <button type="button" class="btn btn-danger removebtn">${this.i18n.remove}</button>
        </div>
      </div>
      `;

    if (isCoach) {
      timingElem.title = this.i18n.coachBusy;
      timingElem.addEventListener('click', _ => {
        const check = this.querySelector('#coachCheck');
        if (!check.checked)
          check.dispatchEvent(new PointerEvent('click'))
      });
    }

    elem.append(timingElem);

    // attach timing listeners 
    if (this.hasAttribute('readonly') || isCoach) return;

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

  /** @param {number} coachId  */
  getCoachSchedule(coachId) {
    const request = new XMLHttpRequest();
    request.open('GET', this.coachEndpoint + '?coach_id=' + coachId, true);
    request.setRequestHeader('X-CSRF-TOKEN', this.csrfToken);
    request.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
    request.onloadend = () => {
      this.coachTimings = JSON.parse(request.response);
      for (const [day, timings] of Object.entries(this.coachTimings)) {
        const elem = this.querySelector(`[data-day="${day}"]>.timings`);
        timings.forEach((timing, index) => {
          this.appendTimingDOM(elem, timing, day, index, true);
        });
      }
    }
    request.send();
  }

}

/** @param {Event} e */
function preventContext(e) {
  e.preventDefault();
  return false;
}

customElements.define('class-schedule-editor', ClassScheduleEditor);
