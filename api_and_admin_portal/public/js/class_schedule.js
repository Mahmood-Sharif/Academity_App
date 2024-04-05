(()=>{var m=class c extends HTMLElement{createMode=!0;timings={sun:[{start_time:"08:00",end_time:"09:00"}]};classCounters=[];i18n=c.l10n.en;static l10n={en:{classTimings:"Class Timings",showWeekend:"Show Weekend",sun:"Sun",mon:"Mon",tue:"Tue",wed:"Wed",thu:"Thu",fri:"Fri",sat:"Sat",helpCreate:"Left Click to Create New Timing",helpRemove:"Right Click to Remove Timing",from:"From",to:"To",remove:"Remove"},ar:{classTimings:"\u062A\u0648\u0642\u064A\u062A\u0627\u062A \u0627\u0644\u0635\u0641",showWeekend:"\u0623\u0638\u0647\u0631 \u0646\u0647\u0627\u064A\u0629 \u0627\u0644\u0623\u0633\u0628\u0648\u0639",sun:"\u0627\u0644\u0623\u062D\u062F",mon:"\u0627\u0644\u0625\u062B\u0646\u064A\u0646",tue:"\u0627\u0644\u062B\u0644\u0627\u062B\u0627\u0621",wed:"\u0627\u0644\u0623\u0631\u0628\u0639\u0627\u0621",thu:"\u0627\u0644\u062E\u0645\u064A\u0633",fri:"\u0627\u0644\u062C\u0645\u0639\u0629",sat:"\u0627\u0644\u0633\u0628\u062A",helpCreate:"\u0627\u0636\u063A\u0637 \u0632\u0631 \u0627\u0644\u0645\u0624\u0634\u0631 \u0627\u0644\u0623\u064A\u0633\u0631 \u0644\u0625\u0646\u0634\u0627\u0621 \u062A\u0648\u0642\u064A\u062A",helpRemove:"\u0627\u0636\u063A\u0637 \u0632\u0631 \u0627\u0644\u0645\u0624\u0634\u0631 \u0627\u0644\u0623\u064A\u0645\u0646 \u0644\u0625\u0632\u0627\u0644\u0629 \u062A\u0648\u0642\u064A\u062A",from:"\u0645\u0646",to:"\u0625\u0644\u0649",remove:"\u0625\u0632\u0627\u0644\u0629"}};timingExtents(a){let{start_time:t,end_time:n}=a,s=r=>Math.min(Math.max(r,6),18)-6+1,e=+t.split(":")[0],i=+n.split(":")[0];return`grid-row-start: ${s(e)}; grid-row-end: ${s(i)}`}formatTime(a){let{start_time:t,end_time:n}=a,s=/^(\d\d):(\d\d)(:\d\d)?/,[e,i,r]=t.match(s),[d,o,l]=n.match(s);return`${+i}:${r} &ndash; ${+o}:${l}`}constructor(){super(),this.i18n=c.l10n[document.querySelector("html").lang];let a=JSON.parse(this.innerText.trim()||"null");a!==null&&(this.timings=a),this.classCounters=this.dataset.classCounters?.split(",")??[],this.innerHTML=`
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
        margin: 0 0.5rem;
        user-select: none;
      }
      .timing>[type="button"] {
        height: 100%;
        width: 100%;
        font-weight: 400;
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
    <textarea class="visually-hidden" name="${this.getAttribute("name")}" hidden></textarea>
    <div class="card mb-3">
      <div class="card-header d-flex">
        <span>${this.i18n.classTimings}</span>
        <div class="form-check form-check-inline ms-auto">
          <input class="form-check-input" type="checkbox" id="weekendCheck">
          <label class="form-check-label" for="weekendCheck">${this.i18n.showWeekend}</label>
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
            ${["sun","mon","tue","wed","thu","fri","sat"].map(t=>`<div class="day" data-day="${t}">
                <div class="date-day">${this.i18n[t]}</div>
                <div class="timings">
                </div>
              </div>`).join("")}
          </div>
        </div>
      </div>
    </div>
    `,this.hasAttribute("readonly")||(this.querySelector(".card").innerHTML+=`
      <div class="card-footer d-flex gap-2 text-muted">
        <span>${this.i18n.helpCreate}</span>
        &centerdot;
        <span>${this.i18n.helpRemove}</span>
      </div>
    `),this.updateValue();{let t=this.timings.fri||this.timings.sat;this.querySelector("#weekendCheck").checked=t,this.querySelector('.day[data-day="fri"]').classList.toggle("d-none",!t),this.querySelector('.day[data-day="sat"]').classList.toggle("d-none",!t)}for(let[t,n]of Object.entries(this.timings)){let s=this.querySelector(`[data-day="${t}"]>.timings`);n.forEach((e,i)=>{this.appendTimingDOM(s,e,t,i)})}this.querySelector("#weekendCheck").addEventListener("change",t=>{this.querySelector('.day[data-day="fri"]').classList.toggle("d-none",t.value),this.querySelector('.day[data-day="sat"]').classList.toggle("d-none",t.value)}),!this.hasAttribute("readonly")&&this.querySelectorAll(".timings").forEach(t=>{t.addEventListener("click",n=>{if(n.target===t&&this.createMode){let s=t.closest(".day").dataset.day,e=Math.floor(6+13*(n.offsetY/t.getBoundingClientRect().height));if(Object.values(this.timings[s]??[]).find(d=>{let{start_time:o,end_time:l}=d,u=+o.split(":")[0],h=+l.split(":")[0];return e>=u&&e<h}))return;let i={start_time:e.toString().padStart(2,"0")+":00",end_time:(e+1).toString().padStart(2,"0")+":00"};this.timings[s]||(this.timings[s]=[]);let r=this.timings[s].push(i)-1;this.appendTimingDOM(t,i,s,r),this.updateClassCounters()}})})}appendTimingDOM(a,t,n,s){let e=document.createElement("div");e.classList.add("dropend","timing"),e.dataset.day=n,e.dataset.index=s,e.style=this.timingExtents(t),e.innerHTML=`
      <div type="button"
        class="btn btn-secondary px-0 fs-5 ${this.hasAttribute("readonly")?" pe-none":""}"
        ${this.hasAttribute("readonly")?"":'data-bs-toggle="dropdown"'} aria-expanded="false">
        ${this.formatTime(t)}
      </div>
      <div class="dropdown-menu">
        <div class="vstack gap-3 p-2">
        <div>
          <label>${this.i18n.from}</label>
          <input class="form-control fromtime" type="time" value="${t.start_time}" onkeydown="return event.key != 'Enter';">
        </div>
        <div>
          <label>${this.i18n.to}</label>
          <input class="form-control totime" type="time" value="${t.end_time}" onkeydown="return event.key != 'Enter';">
        </div>
        <button type="button" class="btn btn-danger removebtn">${this.i18n.remove}</button>
        </div>
      </div>
      `,a.append(e),!this.hasAttribute("readonly")&&(e.querySelector(".fromtime").addEventListener("change",i=>this.onTimeInputChanged(i.target,"from")),e.querySelector(".totime").addEventListener("change",i=>this.onTimeInputChanged(i.target,"to")),e.querySelector(".removebtn").addEventListener("click",i=>this.removeTiming(i.target)),e.querySelector('[type="button"]').addEventListener("contextmenu",i=>(i.preventDefault(),!1),!1),e.querySelector('[type="button"]').addEventListener("mouseup",i=>{i.button==2&&this.removeTiming(i.target)}),e.querySelector('[type="button"]').addEventListener("hide.bs.dropdown",()=>{this.createMode=!0}),e.querySelector('[type="button"]').addEventListener("show.bs.dropdown",()=>{setTimeout(()=>{this.createMode=!1},100)}))}onTimeInputChanged(a,t){let n=a.closest(".timing"),s=n.dataset.day,e=n.dataset.index,i=this.timings[s][e];if(t=="from"){this.timings[s][e].start_time=a.value;let r=+a.value.split(":")[0],[d,o]=i.end_time.split(":");r>=+d&&(this.timings[s][e].end_time=(r+1).toString().padStart(2,"0")+":"+o,n.querySelector(".totime").value=i.end_time)}else this.timings[s][e].end_time=a.value;n.style=this.timingExtents(i),n.querySelector('[type="button"]').innerHTML=this.formatTime(i),this.updateValue()}removeTiming(a){let t=a.closest(".timing"),n=t.dataset.day,s=t.dataset.index;this.timings[n][s]=null,delete this.timings[n][s],t.remove(),this.updateClassCounters(),this.createMode=!0}updateClassCounters(){this.classCounters.forEach(a=>{let t=document.getElementById(a);t.dataset.classesPerWeek=Object.values(this.timings).flat().length}),this.updateValue()}updateValue(){this.querySelector("textarea").innerText=JSON.stringify(Object.entries(this.timings).flatMap(([a,t])=>t.map(n=>({...n,day_of_week:a.toUpperCase()}))))}};customElements.define("class-schedule-editor",m);})();
