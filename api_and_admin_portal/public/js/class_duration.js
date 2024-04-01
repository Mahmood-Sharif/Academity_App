class ClassDurationInput extends HTMLElement {
  static observedAttributes = ['data-classes-per-week'];

  durId = this.id + '-dur';
  duration = 0;
  unit = '';
  classesPerWeek = 0;
  value = 0;

  constructor() {
    super();

    this.unit = this.dataset.unit ?? 'week';
    this.classesPerWeek = this.dataset.classesPerWeek; // required attribute
    this.value = this.getAttribute('value') ?? this.classesPerWeek;
    this.duration = this.dataset.duration ?? Math.floor(this.value / this.classesPerWeek) ?? 1;

    if (this.hasAttribute('readonly')) {
      this.normalizeDuration();
      this.innerHTML = `
        <div class="d-flex align-items-baseline">
          <div class="form-floating">
            <input type="text" value="${this.duration} ${this.unit}s" id="${this.durId}" class="form-control-plaintext" readonly placeholder="">
            <label for="${this.durId}" class="form-label">${this.dataset.label}</label>
          </div>
          <div>
            <span>  =  </span>
            <span class="numclasses">${this.numClassesText()}</span>
          </div>
        </div>
    `;
    } else {
      this.innerHTML = `
    <input type="hidden" value="${this.value}" name="${this.getAttribute('name')}" hidden>
    <div class="input-group">
      <div class="form-floating">
        <input type="number" value="${this.duration}" id="${this.durId}" class="form-control" placeholder="">
        <label for="${this.durId}" class="form-label">${this.dataset.label}</label>
      </div>
      <select class="form-select" style="flex: 0.25 0; min-width: fit-content;">
        <option value="day" ${this.unit == 'day' ? 'selected' : ''}>Days</option>
        <option value="week" ${this.unit == 'week' ? 'selected' : ''}>Weeks</option>
        <option value="month" ${this.unit == 'month' ? 'selected' : ''}>Months</option>
      </select>
      <div class="numclasses input-group-text">${this.numClassesText()}</div>
    </div>
    `;
    }

    this.updateNumClasses();

    this.querySelector('#' + this.durId).addEventListener('change', (event) => this.onDurChange(event));
    this.querySelector('.form-select').addEventListener('change', (event) => this.onUnitChange(event));
  }

  attributeChangedCallback(name, _oldValue, newValue) {
    if (name != 'data-classes-per-week') return;
    this.classesPerWeek = newValue;
    this.updateNumClasses();
  }

  numClassesText() {
    return this.value + (this.value == 1 ? ' Class' : ' Classes');
  }

  updateNumClasses() {
    if (this.unit == 'day') {
      this.value = this.duration;
    }
    else if (this.unit == 'week') {
      this.value = this.duration * this.classesPerWeek;
    }
    else if (this.unit == 'month') {
      this.value = this.duration * 4 * this.classesPerWeek;
    }

    this.querySelector('.numclasses').innerText = this.numClassesText();
    this.querySelector('input[type="hidden"]').value = this.value;
  }

  /** @param {Event} event */
  onDurChange(event) {
    this.duration = event.target.value;
    this.updateNumClasses();
  }

  /** @param {Event} event */
  onUnitChange(event) {
    this.unit = event.target.value;
    this.updateNumClasses();
  }

  normalizeDuration() {
    this.duration = this.duration / this.classesPerWeek;
    this.unit = 'week';
    if (this.duration >= 4) {
      this.duration = this.duration / 4;
      this.unit = 'month';
    }
  }
}

customElements.define('duration-input', ClassDurationInput);
