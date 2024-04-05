(()=>{var e=class t extends HTMLElement{static observedAttributes=["data-classes-per-week"];durId=this.id+"-dur";duration=0;unit="";classesPerWeek=0;value=0;i18n=t.l10n.en;static l10n={en:{days:"Days",weeks:"Weeks",months:"Months",class:"Class",classes:"Classes"},ar:{days:"\u0623\u064A\u0627\u0645",weeks:"\u0623\u0633\u0627\u0628\u064A\u0639",months:"\u0623\u0634\u0647\u0631",class:"\u0635\u0641",classes:"\u0635\u0641\u0648\u0641"}};constructor(){super(),this.i18n=t.l10n[document.querySelector("html").lang],this.unit=this.dataset.unit??"week",this.classesPerWeek=this.dataset.classesPerWeek,this.value=this.getAttribute("value")??this.classesPerWeek,this.duration=this.dataset.duration??Math.floor(this.value/this.classesPerWeek)??1,this.hasAttribute("readonly")?(this.normalizeDuration(),this.innerHTML=`
        <div class="d-flex align-items-baseline">
          <div class="form-floating">
            <input type="text" value="${this.duration} ${this.i18n[this.unit+"s"]}" id="${this.durId}" class="form-control-plaintext" readonly placeholder="">
            <label for="${this.durId}" class="form-label">${this.dataset.label}</label>
          </div>
          <div>
            <span>  =  </span>
            <span class="numclasses">${this.numClassesText()}</span>
          </div>
        </div>
    `):this.innerHTML=`
    <input type="hidden" value="${this.value}" name="${this.getAttribute("name")}" hidden>
    <div class="input-group">
      <div class="form-floating">
        <input type="number" value="${this.duration}" id="${this.durId}" class="form-control" placeholder="">
        <label for="${this.durId}" class="form-label">${this.dataset.label}</label>
      </div>
      <select class="form-select" style="flex: 0.25 0; min-width: fit-content;">
        <option value="day" ${this.unit=="day"?"selected":""}>${this.i18n.days}</option>
        <option value="week" ${this.unit=="week"?"selected":""}>${this.i18n.weeks}</option>
        <option value="month" ${this.unit=="month"?"selected":""}>${this.i18n.months}</option>
      </select>
      <div class="numclasses input-group-text">${this.numClassesText()}</div>
    </div>
    `,this.updateNumClasses(),this.querySelector("#"+this.durId).addEventListener("change",s=>this.onDurChange(s)),this.querySelector(".form-select").addEventListener("change",s=>this.onUnitChange(s))}attributeChangedCallback(s,a,i){s=="data-classes-per-week"&&(this.classesPerWeek=i,this.updateNumClasses())}numClassesText(){return this.value+" "+(this.value==1?this.i18n.class:this.i18n.classes)}updateNumClasses(){this.unit=="day"?this.value=this.duration:this.unit=="week"?this.value=this.duration*this.classesPerWeek:this.unit=="month"&&(this.value=this.duration*4*this.classesPerWeek),this.querySelector(".numclasses").innerText=this.numClassesText(),this.querySelector('input[type="hidden"]').value=this.value}onDurChange(s){this.duration=s.target.value,this.updateNumClasses()}onUnitChange(s){this.unit=s.target.value,this.updateNumClasses()}normalizeDuration(){this.duration=this.duration/this.classesPerWeek,this.unit="week",this.duration>=4&&(this.duration=this.duration/4,this.unit="month")}};customElements.define("duration-input",e);})();
