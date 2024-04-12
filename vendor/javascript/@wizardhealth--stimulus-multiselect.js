import{Controller as e}from"@hotwired/stimulus";const t="[aria-selected='true']";class Multiselect extends e{static targets=["hidden","list","search","preview","dropdown","item","addable","inputContainer"];static values={items:Array,selected:Array,searchUrl:String,searchRemote:{type:Boolean,default:false},preloadUrl:String,addableUrl:String,disabled:{type:Boolean,default:false}};connect(){this.hiddenTarget.insertAdjacentHTML("afterend",this.template);this.selectedValue.length&&this.selectedValueChanged();this.search=debounce(this.search.bind(this),300);this.enhanceHiddenSelect();this.preloadUrlValue&&this.preload()}enhanceHiddenSelect(){Object.defineProperty(this.hiddenTarget,"values",{get:()=>this.selectedValue.length<=0?[]:this.selectedValue.map((e=>e.value))})}search(){if(this.searchRemoteValue)return this.searchRemote();this.searchLocal()}async searchRemote(){if(""===this.searchTarget.value)return;const e=await fetch(this.searchUrlValue+"?"+new URLSearchParams({q:this.searchTarget.value,preselects:this.selectedValue.map((e=>e.value)).join(",")}));const t=await e.json();this.itemsValue=t;this.dropdownTarget.classList.add("multiselect__dropdown--open")}searchLocal(){this.dropdownTarget.classList.add("multiselect__dropdown--open");if(""===this.searchTarget.value){let e=this.itemsValue.filter((e=>!this.selectedValue.map((e=>e.value)).includes(e.value)));this.listTarget.innerHTML=this.selectedItems;this.listTarget.insertAdjacentHTML("beforeend",this.items(e))}let e=this.itemsValue.filter((e=>e.text.toLowerCase().includes(this.searchTarget.value.toLowerCase())));let t=this.selectedValue.filter((e=>e.text.toLowerCase().includes(this.searchTarget.value.toLowerCase())));e=e.filter((e=>!t.map((e=>e.value)).includes(e.value)));if(0===e.length&&this.addableUrlValue)return this.listTarget.innerHTML=this.noResultsTemplate;0===e.length&&this.dropdownTarget.classList.remove("multiselect__dropdown--open");this.listTarget.innerHTML=this.items(t,true);this.listTarget.insertAdjacentHTML("beforeend",this.items(e))}async preload(){const e=await fetch(this.preloadUrlValue);const t=await e.json();this.itemsValue=t}toggleDropdown(){if(this.dropdownTarget.classList.contains("multiselect__dropdown--open")){this.dropdownTarget.classList.remove("multiselect__dropdown--open");this.selectedValue.length>0&&(this.inputContainerTarget.style.display="none");this.searchTarget.blur()}else{this.itemsValue.length&&this.dropdownTarget.classList.add("multiselect__dropdown--open");this.searchTarget.focus()}}closeOnClickOutside({target:e}){if(!this.element.contains(e)){this.dropdownTarget.classList.remove("multiselect__dropdown--open");this.selectedValue.length>0&&(this.inputContainerTarget.style.display="none");this.searchTarget.value="";if(!this.searchRemoteValue){this.listTarget.innerHTML=this.allItems;this.selectedValue.forEach((e=>{this.checkItem(e.value)}))}}}searchUrlValueChanged(){this.searchUrlValue&&(this.searchRemoteValue=true)}itemsValueChanged(){this.hasListTarget&&(this.itemsValue.length?this.listTarget.innerHTML=this.items(this.itemsValue):this.listTarget.innerHTML=this.noResultsTemplate)}selectedValueChanged(){if(this.hasPreviewTarget){while(this.hiddenTarget.options.length)this.hiddenTarget.remove(0);if(this.selectedValue.length>0){this.previewTarget.innerHTML=this.pills;this.searchTarget.style.paddingTop="0.5rem";this.selectedValue.forEach((e=>{const t=document.createElement("option");t.text=e.text;t.value=e.value;t.setAttribute("selected",true);this.hiddenTarget.add(t)}));this.searchRemoteValue||this.selectedValue.forEach((e=>{this.checkItem(e.value)}))}else{this.searchTarget.style.paddingTop="0";this.inputContainerTarget.style.display="";this.previewTarget.innerHTML=""}this.element.dispatchEvent(new Event("multiselect-change"))}}removeItem(e){e.stopPropagation();const t=e.currentTarget.parentNode;this.selectedValue=this.selectedValue.filter((e=>e.value.toString()!==t.dataset.value));this.uncheckItem(t.dataset.value);this.element.dispatchEvent(new CustomEvent("multiselect-removed",{detail:{id:t.dataset.value}}))}uncheckItem(e){const t=this.listTarget.querySelector(`input[data-value="${e}"]`);t&&(t.checked=false)}checkItem(e){const t=this.listTarget.querySelector(`input[data-value="${e}"]`);t&&(t.checked=true)}toggleItem(e){const t={text:e.dataset.text,value:e.dataset.value};let s=this.selectedValue;if(e.checked){s.push(t);if(this.focusedItem){this.focusedItem.closest("li").classList.remove("multiselect__focused");this.focusedItem.removeAttribute("aria-selected")}e.setAttribute("aria-selected","true");e.closest("li").classList.add("multiselect__focused");this.element.dispatchEvent(new CustomEvent("multiselect-added",{detail:{item:t}}))}else{s=s.filter((e=>e.value.toString()!==t.value));this.element.dispatchEvent(new CustomEvent("multiselect-removed",{detail:{id:t.value}}))}this.selectedValue=s}onKeyDown(e){const t=this[`on${e.key}Keydown`];t&&t(e)}onArrowDownKeydown=e=>{const t=this.sibling(true);t&&this.navigate(t);e.preventDefault()};onArrowUpKeydown=e=>{const t=this.sibling(false);t&&this.navigate(t);e.preventDefault()};onBackspaceKeydown=()=>{if(""!==this.searchTarget.value)return;if(!this.selectedValue.length)return;const e=this.selectedValue;const t=e.pop().value;this.uncheckItem(t);this.selectedValue=e;this.element.dispatchEvent(new CustomEvent("multiselect-removed",{detail:{id:t}}))};onEnterKeydown=e=>{this.focusedItem&&this.focusedItem.click()};onEscapeKeydown=()=>{if(""!==this.searchTarget.value){this.searchTarget.value="";return this.search()}this.toggleDropdown()};sibling(e){const t=this.itemTargets;const s=this.focusedItem;const a=t.indexOf(s);const l=e?t[a+1]:t[a-1];const i=e?t[0]:t[t.length-1];return l||i}async addable(e){e.preventDefault();const t=this.searchTarget.value;if(""===t||this.itemsValue.some((e=>e.text===t)))return;const s=await fetch(this.addableUrlValue,{method:"POST",body:JSON.stringify({addable:t})});if(s.ok){const e=await s.json();this.addAddableItem(e)}}addAddableItem(e){this.itemsValue=this.itemsValue.concat(e);this.selectedValue=this.selectedValue.concat(e);this.searchTarget.value="";this.element.dispatchEvent(new CustomEvent("multiselect-added",{detail:{item:e}}))}navigate(e){const t=this.focusedItem;if(t){t.removeAttribute("aria-selected");t.closest("li").classList.remove("multiselect__focused")}e.setAttribute("aria-selected","true");e.closest("li").classList.add("multiselect__focused");e.scrollIntoView({behavior:"smooth",block:"nearest"})}get focusedItem(){return this.listTarget.querySelector(t)}focusSearch(){this.inputContainerTarget.style.display="";this.searchTarget.focus()}addableEvent(){document.dispatchEvent(new CustomEvent("multiselect-addable"))}get template(){return`\n      <div class="multiselect__container" data-multiselect-target="container" data-action="click->multiselect#toggleDropdown focus->multiselect#focusSearch" tabindex="0" data-turbo-cache="false">\n        <div class="multiselect__preview" data-multiselect-target="preview">\n        </div>\n        <div class="multiselect__input-container" data-multiselect-target="inputContainer">${this.inputTemplate}</div>\n      </div>\n      <div style="position: relative;" data-action="click@window->multiselect#closeOnClickOutside">\n        <div class="multiselect__dropdown" data-multiselect-target="dropdown">\n          <ul class="multiselect__list" data-multiselect-target="list">\n            ${this.allItems}\n          </ul>\n        </div>\n      </div>\n    `}get noResultsTemplate(){return this.addableUrlValue?`\n      <div class="multiselect__no-result">\n        <span class="multiselect__addable-button" data-action="click->multiselect#addableEvent">\n          ${this.element.dataset.addablePlaceholder}\n        </span>\n      </div>\n    `:`<div class="multiselect__no-result">${this.element.dataset.noResultsMessage}</div>`}get inputTemplate(){return`\n        <input type="text" class="multiselect__search" placeholder="${this.element.dataset.placeholder}"\n               data-multiselect-target="search" ${true===this.disabledValue?"disabled":""}\n               data-action="multiselect#search keydown->multiselect#onKeyDown">\n      `}items(e,t=false){const s=t?"checked":"";let a="";e.forEach((e=>a+=this.itemTemplate(e,s)));return a}get pills(){let e="";this.selectedValue.forEach((t=>e+=this.pillTemplate(t)));return e}get selectedItems(){return this.items(this.selectedValue,true)}get allItems(){return this.items(this.itemsValue)}itemTemplate(e,t=""){return`\n      <li>\n        <label>\n          <input type="checkbox" ${t} data-value="${e.value}" data-text="${e.text}"\n          data-action="multiselect#checkBoxChange" data-multiselect-target="item" tabindex="-1">\n          <span>${e.text}</span>\n        </label>\n      </li>\n    `}checkBoxChange(e){e.preventDefault();this.searchTarget.focus();this.toggleItem(e.currentTarget)}pillTemplate(e){return this.disabledValue?`<div class="multiselect__pill" data-value="${e.value}" title="${e.text}">\n        <span class="multiselect__pill-text">${e.text}</span>\n      </div>`:`<div class="multiselect__pill" data-value="${e.value}" title="${e.text}">\n        <span class="multiselect__pill-text">${e.text}</span>\n        <span class="multiselect__pill-delete" data-action="click->multiselect#removeItem">\n          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30" width="12px" height="12px">\n            <path d="M25.707,6.293c-0.195-0.195-1.805-1.805-2-2c-0.391-0.391-1.024-0.391-1.414,0c-0.195,0.195-17.805,17.805-18,18c-0.391,0.391-0.391,1.024,0,1.414c0.279,0.279,1.721,1.721,2,2c0.391,0.391,1.024,0.391,1.414,0c0.195-0.195,17.805-17.805,18-18C26.098,7.317,26.098,6.683,25.707,6.293z"/>\n            <path d="M23.707,25.707c0.195-0.195,1.805-1.805,2-2c0.391-0.391,0.391-1.024,0-1.414c-0.195-0.195-17.805-17.805-18-18c-0.391-0.391-1.024-0.391-1.414,0c-0.279,0.279-1.721,1.721-2,2c-0.391,0.391-0.391,1.024,0,1.414c0.195,0.195,17.805,17.805,18,18C22.683,26.098,23.317,26.098,23.707,25.707z"/>\n          </svg>\n        </span>\n      </div>`}}function debounce(e,t){let s=null;return(...a)=>{const callback=()=>e.apply(this,a);clearTimeout(s);s=setTimeout(callback,t)}}export{Multiselect,Multiselect as default};

