(()=>{var l=class h extends HTMLElement{createMode=!0;timings={sun:[{start_time:"08:00",end_time:"09:00"}]};classCounters=[];i18n=h.l10n.en;coachSelect;coachEndpoint;csrfToken;static l10n={en:{classTimings:"Class Timings",showWeekend:"Show Weekend",showCoachSchedule:"Show Coach Schedule",sun:"Sun",mon:"Mon",tue:"Tue",wed:"Wed",thu:"Thu",fri:"Fri",sat:"Sat",helpCreate:"Left Click to Create New Timing",helpRemove:"Right Click to Remove Timing",from:"From",to:"To",remove:"Remove",coachBusy:"coach is busy at this time"},ar:{classTimings:"\u062A\u0648\u0642\u064A\u062A\u0627\u062A \u0627\u0644\u0635\u0641",showWeekend:"\u0623\u0638\u0647\u0631 \u0646\u0647\u0627\u064A\u0629 \u0627\u0644\u0623\u0633\u0628\u0648\u0639",showCoachSchedule:"\u0623\u0638\u0647\u0631 \u062C\u062F\u0648\u0644 \u0627\u0644\u0645\u062F\u0631\u0628",sun:"\u0627\u0644\u0623\u062D\u062F",mon:"\u0627\u0644\u0625\u062B\u0646\u064A\u0646",tue:"\u0627\u0644\u062B\u0644\u0627\u062B\u0627\u0621",wed:"\u0627\u0644\u0623\u0631\u0628\u0639\u0627\u0621",thu:"\u0627\u0644\u062E\u0645\u064A\u0633",fri:"\u0627\u0644\u062C\u0645\u0639\u0629",sat:"\u0627\u0644\u0633\u0628\u062A",helpCreate:"\u0627\u0636\u063A\u0637 \u0632\u0631 \u0627\u0644\u0645\u0624\u0634\u0631 \u0627\u0644\u0623\u064A\u0633\u0631 \u0644\u0625\u0646\u0634\u0627\u0621 \u062A\u0648\u0642\u064A\u062A",helpRemove:"\u0627\u0636\u063A\u0637 \u0632\u0631 \u0627\u0644\u0645\u0624\u0634\u0631 \u0627\u0644\u0623\u064A\u0645\u0646 \u0644\u0625\u0632\u0627\u0644\u0629 \u062A\u0648\u0642\u064A\u062A",from:"\u0645\u0646",to:"\u0625\u0644\u0649",remove:"\u0625\u0632\u0627\u0644\u0629",coachBusy:"\u0627\u0644\u0645\u062F\u0631\u0628 \u0645\u0634\u063A\u0648\u0644 \u0647\u0630\u0627 \u0627\u0644\u0648\u0642\u062A"}};constructor(){super(),this.i18n=h.l10n[document.querySelector("html").lang];let n=JSON.parse(this.innerText.trim()||"null");n!==null&&(this.timings=n),this.classCounters=this.dataset.classCounters?.split(",")??[],this.coachSelect=this.dataset.coachSelect,this.coachEndpoint=this.dataset.coachEndpoint,this.csrfToken=this.dataset.csrfToken,this.innerHTML=`
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
    <textarea class="visually-hidden" name="${this.getAttribute("name")}" hidden></textarea>
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
            ${["sun","mon","tue","wed","thu","fri","sat"].map(e=>`<div class="day" data-day="${e}">
                <div class="date-day">${this.i18n[e]}</div>
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
    `),this.updateValue();{let e=this.timings.fri||this.timings.sat;this.querySelector("#weekendCheck").checked=e,this.querySelector('.day[data-day="fri"]').classList.toggle("d-none",!e),this.querySelector('.day[data-day="sat"]').classList.toggle("d-none",!e)}for(let[e,s]of Object.entries(this.timings)){let a=this.querySelector(`[data-day="${e}"]>.timings`);s.forEach((t,o)=>{this.appendTimingDOM(a,t,e,o)})}if(this.querySelector("#weekendCheck").addEventListener("change",e=>{this.querySelector('.day[data-day="fri"]').classList.toggle("d-none",e.value),this.querySelector('.day[data-day="sat"]').classList.toggle("d-none",e.value)}),this.querySelector("#coachCheck").addEventListener("change",e=>{this.querySelectorAll(".is-coach").forEach(s=>s.parentElement.classList.toggle("show",e.target.checked))}),this.hasAttribute("readonly")&&this.getCoachSchedule(this.dataset.coachId),this.hasAttribute("readonly"))return;let i=document.querySelector(this.coachSelect);this.getCoachSchedule(i.value),this.querySelector("#coachCheck").checked=!0,i.addEventListener("change",e=>{document.querySelectorAll(".is-coach").forEach(s=>{s.parentElement.remove()}),this.getCoachSchedule(e.target.value)}),this.querySelectorAll(".timings").forEach(e=>{e.addEventListener("click",s=>{if(s.target===e&&this.createMode){let a=e.closest(".day").dataset.day,t=Math.floor(6+13*(s.offsetY/e.getBoundingClientRect().height)),o=(this.timings[a]??[]).concat(this.coachTimings[a]??[]);if(Object.values(o).find(c=>{let{start_time:m,end_time:u}=c,g=+m.split(":")[0],p=+u.split(":")[0];return t>=g&&t<p}))return;let r={start_time:t.toString().padStart(2,"0")+":00",end_time:(t+1).toString().padStart(2,"0")+":00"};this.timings[a]||(this.timings[a]=[]);let d=this.timings[a].push(r)-1;this.appendTimingDOM(e,r,a,d),this.updateClassCounters()}})})}timingExtents(n){let{start_time:i,end_time:e}=n,s=o=>Math.min(Math.max(o,6),18)-6+1,a=+i.split(":")[0],t=+e.split(":")[0];return`grid-row: ${s(a)} / ${s(t)}`}formatTime(n){let{start_time:i,end_time:e}=n,s=/^(\d\d):(\d\d)(:\d\d)?/,[a,t,o]=i.match(s),[r,d,c]=e.match(s);return`${+t}:${o} &ndash; ${+d}:${c}`}appendTimingDOM(n,i,e,s,a=!1){let t=document.createElement("div");t.classList.add("dropend","timing","fade"),t.dataset.day=e,t.dataset.index=s,t.style=this.timingExtents(i);let o="btn btn-secondary px-0 fs-5";this.hasAttribute("readonly")&&(o+=" pe-none"),a&&(o+=" is-coach"),this.hasAttribute("readonly")&&a||t.classList.add("show"),t.innerHTML=`
      <div type="button"
        class="${o}"
        ${this.hasAttribute("readonly")?"":'data-bs-toggle="dropdown"'} 
        aria-expanded="false">
        ${this.formatTime(i)}${a?"<br>"+i.class_name:""}
      </div>
      <div class="dropdown-menu">
        <div class="vstack gap-3 p-2">
        <div>
          <label>${this.i18n.from}</label>
          <input class="form-control fromtime" type="time" value="${i.start_time}" onkeydown="return event.key != 'Enter';">
        </div>
        <div>
          <label>${this.i18n.to}</label>
          <input class="form-control totime" type="time" value="${i.end_time}" onkeydown="return event.key != 'Enter';">
        </div>
        <button type="button" class="btn btn-danger removebtn">${this.i18n.remove}</button>
        </div>
      </div>
      `,a&&(t.title=this.i18n.coachBusy,t.addEventListener("click",r=>{let d=this.querySelector("#coachCheck");d.checked||d.dispatchEvent(new PointerEvent("click"))})),n.append(t),!(this.hasAttribute("readonly")||a)&&(t.querySelector(".fromtime").addEventListener("change",r=>this.onTimeInputChanged(r.target,"from")),t.querySelector(".totime").addEventListener("change",r=>this.onTimeInputChanged(r.target,"to")),t.querySelector(".removebtn").addEventListener("click",r=>this.removeTiming(r.target)),t.querySelector('[type="button"]').addEventListener("contextmenu",r=>(r.preventDefault(),!1),!1),t.querySelector('[type="button"]').addEventListener("mouseup",r=>{r.button==2&&this.removeTiming(r.target)}),t.querySelector('[type="button"]').addEventListener("hide.bs.dropdown",()=>{this.createMode=!0}),t.querySelector('[type="button"]').addEventListener("show.bs.dropdown",()=>{setTimeout(()=>{this.createMode=!1},100)}))}onTimeInputChanged(n,i){let e=n.closest(".timing"),s=e.dataset.day,a=e.dataset.index,t=this.timings[s][a];if(i=="from"){this.timings[s][a].start_time=n.value;let o=+n.value.split(":")[0],[r,d]=t.end_time.split(":");o>=+r&&(this.timings[s][a].end_time=(o+1).toString().padStart(2,"0")+":"+d,e.querySelector(".totime").value=t.end_time)}else this.timings[s][a].end_time=n.value;e.style=this.timingExtents(t),e.querySelector('[type="button"]').innerHTML=this.formatTime(t),this.updateValue()}removeTiming(n){let i=n.closest(".timing"),e=i.dataset.day,s=i.dataset.index;this.timings[e][s]=null,delete this.timings[e][s],i.remove(),this.updateClassCounters(),this.createMode=!0}updateClassCounters(){this.classCounters.forEach(n=>{let i=document.getElementById(n);i.dataset.classesPerWeek=Object.values(this.timings).flat().length}),this.updateValue()}updateValue(){this.querySelector("textarea").innerText=JSON.stringify(Object.entries(this.timings).flatMap(([n,i])=>i.map(e=>({...e,day_of_week:n.toUpperCase()}))))}getCoachSchedule(n){let i=new XMLHttpRequest;i.open("GET",this.coachEndpoint+"?coach_id="+n,!0),i.setRequestHeader("X-CSRF-TOKEN",this.csrfToken),i.setRequestHeader("X-Requested-With","XMLHttpRequest"),i.onloadend=()=>{this.coachTimings=JSON.parse(i.response);for(let[e,s]of Object.entries(this.coachTimings)){let a=this.querySelector(`[data-day="${e}"]>.timings`);s.forEach((t,o)=>{this.appendTimingDOM(a,t,e,o,!0)})}},i.send()}};customElements.define("class-schedule-editor",l);})();
