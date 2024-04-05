import Uppy from '@uppy/core';
import Dashboard from '@uppy/dashboard';
import XHRUpload from '@uppy/xhr-upload';
import Arabic from '@uppy/locales/lib/ar_SA';

class Gallery extends HTMLElement {
  itemsEndpoint = '';
  uploadEndpoint = '';
  submitEndpoint = '';
  csrfToken = '';
  isUppyShown = false;
  /** @type {Uppy} */
  uppy = null;
  originalFiles = [];
  files = [];

  i18n = Gallery.l10n.en;

  static l10n = {
    en: {
      academyGallery: 'Academy Gallery',
      uploadFiles: 'Upload Files',
      submit: 'Save',
      reset: 'Reset',
      close: 'Close',
      cancel: 'Cancel',
      remove: 'Remove',
      video: 'Video',
      noItems: 'No media is uploaded',
      message: {
        updateSuccess: 'Successfully updated academy gallery.',
        updateError: 'Error updating academy gallery.',
        noChange: 'No Change',
        errorFetching: 'Error getting academy gallery.',
      },
    },
    ar: {
      academyGallery: 'معرض الأكاديمية',
      uploadFiles: 'رفع الملفات',
      submit: 'حفظ',
      reset: 'إعادة',
      close: 'إغلاق',
      cancel: 'إلغاء',
      remove: 'إزالة',
      video: 'فيديو',
      noItems: 'لا توجد وسائط مرفوعة',
      message: {
        updateSuccess: 'تم تحديث معرض الوسائط بنجاح.',
        updateError: 'لم يتم تحديث المعرض.',
        noChange: 'لا تغيير',
        errorFetching: 'Error getting academy gallery.',
      },
    },
  };

  constructor() {
    super();
    this.itemsEndpoint = this.dataset.itemsEndpoint;
    if (!this.itemsEndpoint) throw new Error("This element is missing the attribute data-items-endpoint");
    this.uploadEndpoint = this.dataset.uploadEndpoint;
    if (!this.uploadEndpoint) throw new Error("This element is missing the attribute data-upload-endpoint");
    this.submitEndpoint = this.dataset.submitEndpoint;
    if (!this.submitEndpoint) throw new Error("This element is missing the attribute data-submit-endpoint");
    this.csrfToken = this.dataset.csrfToken;
    if (!this.csrfToken) throw new Error("This element is missing the attribute data-csrf-token");

    const locale = document.querySelector('html').lang;
    this.i18n = Gallery.l10n[locale];

    this.innerHTML = `
    <link href="https://releases.transloadit.com/uppy/v3.24.0/uppy.min.css" rel="stylesheet">
    <style>
    .uppy-Dashboard-inner {
      width: 100% !important;
    }
    .galleryGrid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      grid-auto-rows: minmax(10em, auto);
      gap: 1rem;
    }
    .galleryItem.ghost {
      opacity: 0.5;
    }
    .galleryItem {
      position: relative;
      cursor: move;
    }
    .galleryItem>button {
        all: unset;
        user-select: auto;
        cursor: pointer;
        position: absolute;
        top: -0.5em;
        right: -0.5em;
        color: black;
        background: white;
        border-radius: 50%;
        width: 1.4em;
        height: 1.4em;
        text-align: center;
        font-size: 1.25em;
    }
    .new>img, .new>video {
      box-shadow: var(--bs-focus-ring-x,0) var(--bs-focus-ring-y,0) var(--bs-focus-ring-blur,0) var(--bs-focus-ring-width) rgba(var(--bs-success-rgb), 0.5);
    }
    i.fileType::before {
      vertical-align: -0.25em;
    }
    i.fileType {
      position: relative;
      bottom: 1.5em;
      inset-inline-end: calc(1em - 100%);
      background: white;
      display: block;
      width: 28px;
      height: 28px;
      text-align: center;
      border-radius: 50%;
    }
    .card>.card-body {
      min-height: 550px;
    }
    [dir="rtl"] .uppy-Dashboard-AddFiles-title {
      direction: ltr;
    }
    .lightboxClose {
      display: flex;
    }
    .lightboxClose>button {
      all: unset;
      pointer-events: auto;
      margin-inline: auto;
      color: #fff;
      font-size: 3em;
      margin-top: 1em;
    }
    #lightbox .modal-media {
      pointer-events: auto;
    }
    </style>
    <div class="card">
      <div class="card-header d-flex align-items-center">
        <span>${this.i18n.academyGallery}</span>
        <button id="galleryToggle" class="btn btn-sm btn-secondary ms-auto" style="width: 8rem;">
          <i class="bi bi-upload me-1"></i>
          ${this.i18n.uploadFiles}
        </button>
      </div>
      <div class="card-body">
        <div id="galleryView" class="${this.isUppyShown ? 'd-none' : ''}"></div>
        <div id="uppy" class="${this.isUppyShown ? '' : 'd-none'}"></div>
      </div>
      <div class="card-footer">
        <button id="submitBtn" class="btn btn-success">${this.i18n.submit}</button>
        <button id="resetBtn" class="btn btn-secondary">${this.i18n.reset}</button>
      </div>
    </div>
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
      <div class="toast"></div>
    </div>
    <div id="lightbox" class="modal modal-xl fade" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-media"></div>
        <div class="lightboxClose">
          <button type="button" data-bs-dismiss="modal" aria-label="Close">
            <i class="bi bi-x-circle-fill"></i>
          </button>
        </div>
      </div>
    </div>
    `;

    this.querySelector('#submitBtn').addEventListener('click', () => {
      console.log(this.diff());
      const request = new XMLHttpRequest();
      request.open('POST', this.submitEndpoint, true);
      request.onloadend = () => {
        const toast = this.querySelector('.toast');
        if (request.status == 200) {
          const status = JSON.parse(request.response).status;
          toast.outerHTML = `
            <div class="toast bg-success-subtle text-success-emphasis border-success align-items-center" role="alert" aria-live="assertive" aria-atomic="true">
              <div class="d-flex align-items-center">
                <i class="bi bi-check2 ms-3 fs-5"></i>
                <div class="toast-body">
                  <span>
                    ${status == 'no change' ? this.i18n.message.noChange : this.i18n.message.updateSuccess}
                  </span>
                </div>
                <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="${this.i18n.close}"></button>
              </div>
          </div>`;
          this.originalFiles = this.files.map(i => { return { ...i, inserted: true } });
          this.updateGalleryView(this.originalFiles);
        } else {
          toast.outerHTML = `
            <div class="toast bg-danger-subtle text-danger-emphasis border-danger align-items-center" role="alert" aria-live="assertive" aria-atomic="true">
              <div class="d-flex align-items-center">
                <i class="bi bi-exclamation-lg ms-3 fs-5"></i>
                <div class="toast-body">
                  <span>${this.i18n.message.updateError}</span>
                </div>
                <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="${this.i18n.close}"></button>
              </div>
          </div>`;
        }
        new bootstrap.Toast(this.querySelector('.toast')).show();
      };
      request.setRequestHeader('X-CSRF-TOKEN', this.csrfToken);
      request.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
      request.setRequestHeader('Content-Type', 'application/json');
      request.send(JSON.stringify(this.diff()));
    });
    this.querySelector('#resetBtn').addEventListener('click', () => {
      this.files = this.originalFiles.map(i => i);
      this.updateGalleryView(this.files);
    });

    // get gallery items
    {
      const request = new XMLHttpRequest();
      request.open('GET', this.itemsEndpoint, true);
      request.onloadend = () => {
        if (request.status == 200) {
          const json = JSON.parse(request.response);
          this.originalFiles = json.gallery.map(i => i);
          this.files = this.originalFiles.map(i => i);
          this.updateGalleryView(json.gallery);
        } else {
          const galleryView = this.querySelector('#galleryView');
          galleryView.innerHTML = `<div class="d-flex w-100 h-100 align-items-center">
            <h2 class="text-muted">${this.i18n.message.errorFetching}</h2>
          </div>`;
        }
      };
      request.send();
    }


    // initialize uppy uploader
    {
      this.uppy = new Uppy({
        restrictions: {
          allowedFileTypes: ['image/png', 'image/jpeg', 'image/webp', 'video/mp4', 'video/webm'],
          maxFileSize: 200 * 1024 * 1024,
        },
        locale: locale == 'ar' ? Arabic : undefined,
      });
      this.uppy.use(Dashboard, {
        target: '#uppy',
        inline: true,
        proudlyDisplayPoweredByUppy: false,
        theme: document.querySelector('html').dataset.bsTheme ?? 'light',
      });
      this.uppy.use(XHRUpload, {
        endpoint: this.uploadEndpoint,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-TOKEN': this.csrfToken,
        }
      });
      this.uppy.on('upload-success', (_file, response) => {
        const json = response.body;
        this.files.push(json);
        this.originalFiles.push({ ...json, inserted: false }); // also push in original files to detect deletion
        this.appendToGalleryView({ ...json, inserted: false });
      });
      this.uppy.on('complete', (result) => {
        if (result.failed.length > 0) { return; }
        this.toggleUppy();
      });
    }

    // add event listeners
    this.querySelector('#galleryToggle').addEventListener('click', (_) => { this.toggleUppy() })

    // put media on lightbox open
    this.querySelector('#lightbox').addEventListener('show.bs.modal', event => {
      const media = event.relatedTarget.firstElementChild;
      const modalBody = this.querySelector('#lightbox .modal-media');
      const clone = media.cloneNode(true);
      if (media.tagName == 'VIDEO') clone.controls = true; // show video controls
      modalBody.replaceChildren(clone);
    });

    // stop video on lightbox close
    this.querySelector('#lightbox').addEventListener('hide.bs.modal', _ => {
      const media = this.querySelector('#lightbox .modal-media').firstElementChild;
      if (media.tagName == 'VIDEO') {
        media.pause();
        media.currentTime = 0;
      }
    });
  }

  toggleUppy() {
    this.isUppyShown ^= true;
    this.querySelector('#galleryToggle').innerHTML = this.isUppyShown
      ? this.i18n.cancel
      : '<i class="bi bi-upload me-1"></i>' + this.i18n.uploadFiles;
    this.querySelector('#galleryView').classList.toggle('d-none', this.isUppyShown);
    this.querySelector('#uppy').classList.toggle('d-none', !this.isUppyShown);
    this.querySelector('.card-footer').classList.toggle('d-none', this.isUppyShown);
  }

  /** @param {{media_id: number, url: string, type: string}[]} gallery  */
  updateGalleryView(gallery) {
    const galleryView = this.querySelector('#galleryView');
    galleryView.innerHTML = `<div class="galleryGrid"></div>`;
    for (const item of gallery) {
      this.appendToGalleryView(item);
    }
    this.setupSortable();
  }

  /** @param {{media_id: number, url: string, type: string, inserted: bool}} item  */
  appendToGalleryView(item) {
    const { media_id, url, type, inserted } = item;
    const elem = document.createElement('div');
    elem.classList.add('galleryItem');
    if (inserted === false) elem.classList.add('new');
    elem.draggable = true;
    const mediaElem = type.startsWith('video')
      ? `<video class="img-fluid"><source src="${url}" type="${type}"></source></video><i class="fileType bi bi-film" title="Video"></i>`
      : `<img class="img-fluid rounded" src="${url}" alt="">`;
    elem.innerHTML = `
      <div data-bs-toggle="modal" data-bs-target="#lightbox" draggable="false">
        ${mediaElem}
      </div>
      <button title="${this.i18n.remove}"><i class="bi bi-x-circle-fill"></i></button>`;
    this.querySelector('.galleryGrid').append(elem);
    elem.querySelector('button').addEventListener('click', (event) => this.removeItem(event, item));
  }

  setupSortable() {
    let dragEl, dragIndex, nextEl;
    const galleryGrid = this.querySelector('.galleryGrid');

    const _onDragOver = (e) => {
      e.preventDefault();
      e.dataTransfer.dropEffect = 'move';

      const target = e.target.closest('.galleryItem');
      if (target && target !== dragEl && target.nodeName == 'DIV') {
        //getBoundinClientRect contains location-info about the element (relative to the viewport)
        var targetPos = target.getBoundingClientRect();
        //checking that dragEl is dragged over half the target y-axis or x-axis. (therefor the .5)
        var next = (e.clientY - targetPos.top) / (targetPos.bottom - targetPos.top) > .5 || (e.clientX - targetPos.left) / (targetPos.right - targetPos.left) > .5;
        galleryGrid.insertBefore(dragEl, next ? target.nextSibling : target);
      }
    }

    function move(input, from, to) {
      let numberOfDeletedElm = 1;
      const elm = input.splice(from, numberOfDeletedElm)[0];
      numberOfDeletedElm = 0;
      input.splice(to, numberOfDeletedElm, elm);
    }

    const _onDragEnd = (evt) => {
      evt.preventDefault();
      dragEl.classList.remove('ghost');
      galleryGrid.removeEventListener('dragover', _onDragOver, false);
      galleryGrid.removeEventListener('drop', _onDragEnd, false);
      dragEl.querySelector('button').style.opacity = 1;

      if (nextEl !== dragEl.nextSibling) {
        const toIndex = [...galleryGrid.querySelectorAll('.galleryItem')].indexOf(dragEl);
        move(this.files, dragIndex, toIndex);
      }
    }

    galleryGrid.addEventListener('dragstart', function(e) {
      dragEl = e.target.closest('.galleryItem');
      nextEl = dragEl.nextSibling;
      dragIndex = [...galleryGrid.querySelectorAll('.galleryItem')].indexOf(dragEl);

      dragEl.querySelector('button').style.opacity = 0;
      e.dataTransfer.effectAllowed = 'move';
      e.dataTransfer.setDragImage(dragEl.querySelector('.img-fluid'), -16, -16);

      galleryGrid.addEventListener('dragover', _onDragOver, false);
      galleryGrid.addEventListener('dragend', _onDragEnd, false);

      setTimeout(function() {
        dragEl.classList.add('ghost');
      }, 0);

    });
  }

  removeItem(event, item) {
    const index = this.files.indexOf(item);
    this.files.splice(index, 1);
    event.target.closest('.galleryItem').remove();
  }

  diff() {
    const deletions = this.originalFiles.filter((o) =>
      this.files.find((n) => o.media_id === n.media_id) == null
    ).map((i) => {
      return { media_id: i.media_id };
    });
    const upsertions = this.files
      .map((i, index) => {
        return {
          media_id: i.media_id,
          index: index,
        };
      })
      .filter((_, index) =>
        this.files[index].media_id != this.originalFiles[index].media_id || this.originalFiles[index].inserted === false
      );
    return { deletions, upsertions };
  }
}

customElements.define('custom-gallery', Gallery);
