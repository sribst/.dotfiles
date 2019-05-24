(setq package-archives '(
     ("melpa" . "http://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/") ;; is it still used ?
     ("org" . "http://orgmode.org/elpa/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(use-package use-package-ensure-system-package :ensure t)

(use-package delight :ensure t)

(setq auth-sources '( "~/.authinfo.gpg" ))

(setq-default
  ad-redefinition-action 'accept                   ; Silence warnings for redefinition
  cursor-in-non-selected-windows t                 ; Hide the cursor in inactive windows
  display-time-default-load-average nil            ; Don't display load average
  fill-column 80                                   ; Set width for automatic line breaks
  help-window-select t                             ; Focus new help windows when opened
  inhibit-startup-screen t                         ; Disable start-up screen
  initial-scratch-message ""                       ; Empty the initial *scratch* buffer
  kill-ring-max 128                                ; Maximum length of kill ring
  load-prefer-newer t                              ; Prefers the newest version of a file
  mark-ring-max 128                                ; Maximum length of mark ring
  scroll-conservatively most-positive-fixnum       ; Always scroll by one line
  select-enable-clipboard t                        ; Merge system's and Emacs' clipboard
  x-select-enable-clipboard t                      ; enable copy pas to classic clipboard
  tab-width 4                                      ; Set width for tabs
  use-package-always-ensure t                      ; Avoid the :ensure keyword for each package
  user-full-name "Sylvain Ribstein"                ; Set the full name of the current user
  user-mail-address "sylvain.ribstein@gmail.com"   ; Set the email address of the current user
  vc-follow-symlinks t                             ; Always follow the symlinks
  view-read-only t                                 ; Always open read-only buffers in view-mode
  blink-cursor-mode nil                            ; the cursor wont blink
  indent-tabs-mode nil)                            ; use space instead of tab to indent
 (delete-selection-mode t)                        ; when writing into marked region delete it
 (transient-mark-mode t)                          ; same mark mouse or keyboard
 (cd "~/")                                        ; Move to the user directory
 (column-number-mode 1)                           ; Show the column number
 (display-time-mode 1)                            ; Enable time in the mode-line
 (fset 'yes-or-no-p 'y-or-n-p)                    ; Replace yes/no prompts with y/n
 (global-hl-line-mode)                            ; Hightlight current line
 (set-default-coding-systems 'utf-8)              ; Default to utf-8 encoding
 (show-paren-mode 1)                              ; Show the parenthesis
 (put 'upcase-region 'disabled nil)               ; Allow C-x C-u
 (put 'downcase-region 'disabled nil)             ; Allow C-x C-l

(setq-default custom-file (expand-file-name "~/.emacs.d/custom.el"))
(when (file-exists-p custom-file)
  (load custom-file t))

(setq menu-bar-mode nil)                              ; Disable the menu bar
(setq scroll-bar-mode nil)                            ; Disable the scroll bar
(setq tool-bar-mode nil)                              ; Disable the tool bar
(setq tooltip-mode nil)                              ; Disable the tooltips

(use-package company
  :defer 0.5
  :delight
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package files
  :ensure nil
  :custom
  (backup-directory-alist `(("." . "~/.emacs.d/backup")))
  (delete-old-versions -1)
  (vc-make-backup-files t)
  (version-control t))

(setq browse-url-browser-function 'browse-url-firefox)

(use-package engine-mode
  :defer 3
  :config
  (defengine duckduckgo
    "https://duckduckgo.com/?q=%s"
    :keybinding "d"))

(use-package ace-window
    :bind
    (("C-x o" . ace-window)
    ("M-o" . ace-window))
    :init (setq aw-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l)))
    (use-package ibuffer
      :defer 0.2
      :bind ("C-x C-b" . ibuffer))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

  (global-set-key (kbd "C-x |") 'toggle-window-split)

(use-package dashboard
  :preface
  :init
  ;; (add-hook 'after-make-frame-functions 'dashboard-refresh-buffer)
  ;; (add-hook 'after-init-hook 'dashboard-refresh-buffer)
  :custom (dashboard-startup-banner 'logo)
  :config (dashboard-setup-startup-hook))

(use-package async)

(defvar *config-file* ".emacs.d/config.org" "The configuration file.")

(defvar *config-last-change* (nth 5 (file-attributes *config-file*))
  "Last modification time of the configuration file.")

(defvar *show-async-tangle-results* nil "Keeps *emacs* async buffers around for later inspection.")

(defun my/config-updated ()
  "Checks if the configuration file has been updated since the last time."
  (time-less-p *config-last-change*
               (nth 5 (file-attributes *config-file*))))

(defun my/config-tangle ()
  "Tangles the org file asynchronously."
  (when (my/config-updated)
    (setq *config-last-change*
          (nth 5 (file-attributes *config-file*)))
    (my/async-babel-tangle *config-file*)))

(defun my/async-babel-tangle (org-file)
  "Tangles the org file asynchronously."
  (let ((init-tangle-start-time (current-time))
        (file (buffer-file-name))
        (async-quiet-switch "-q"))
    (async-start
     `(lambda ()
        (require 'org)
        (org-babel-tangle-file ,org-file))
     (unless *show-async-tangle-results*
       `(lambda (result)
          (if result
              (message "SUCCESS: %s successfully tangled (%.2fs)."
                       ,org-file
                       (float-time (time-subtract (current-time)
                                                  ',init-tangle-start-time)))
            (message "ERROR: %s as tangle failed." ,org-file)))))))

(use-package flyspell
  :defer 1
  :delight
  :custom
  (flyspell-abbrev-p t)
  (flyspell-issue-message-flag nil)
  (flyspell-issue-welcome-flag nil)
  (flyspell-mode 1))

  (use-package flyspell-correct-ivy
    :bind ("C-M-;" . flyspell-correct-wrapper)
    :init
      (setq flyspell-correct-interface #'flyspell-correct-ivy))
(use-package ispell
  :custom
  (ispell-silently-savep t))

(use-package savehist
  :ensure nil
  :custom
  (history-delete-duplicates t)
  (history-length t)
  (savehist-additional-variables
   '(kill-ring
     search-ring
     regexp-search-ring))
  (savehist-file  "~/.emacs.d/history" )
  (savehist-save-minibuffer-history 1)
  :config (savehist-mode 1))

(use-package paradox
  :defer 1
  :custom
  (paradox-column-width-package 27)
  (paradox-column-width-version 13)
  (paradox-execute-asynchronously t)
  (paradox-hide-wiki-packages t)
  :config
  (paradox-enable)
  (remove-hook 'paradox-after-execute-functions #'paradox--report-buffer-print))

(use-package aggressive-indent
  :defer 2
  :hook ((css-mode . aggressive-indent-mode)
         (emacs-lisp-mode . aggressive-indent-mode)
         (js-mode . aggressive-indent-mode)
         (lisp-mode . aggressive-indent-mode))
  :custom (aggressive-indent-comments-too))

(use-package move-text
  :defer 2
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down))
  :config (move-text-default-bindings))

(use-package rainbow-mode
  :defer 2
  :delight
  :hook (prog-mode))

(use-package autorevert
  :ensure nil
  :delight auto-revert-mode
  :bind ("C-x R" . revert-buffer)
  :custom (auto-revert-verbose nil)
  :config (global-auto-revert-mode 1))

(use-package wiki-summary
  :defer 1
  :bind ("C-c W" . wiki-summary)
  :preface
  (defun my/format-summary-in-buffer (summary)
    "Given a summary, stick it in the *wiki-summary* buffer and display the buffer"
    (let ((buf (generate-new-buffer "*wiki-summary*")))
      (with-current-buffer buf
        (princ summary buf)
        (fill-paragraph)
        (goto-char (point-min))
        (text-mode)
        (view-mode))
      (pop-to-buffer buf))))

(advice-add 'wiki-summary/format-summary-in-buffer :override #'my/format-summary-in-buffer)

(use-package which-key
  :defer 0.2
  :delight
  :config (which-key-mode))

(use-package counsel
  :after ivy
  :delight
  :config (counsel-mode))

(use-package ivy
  :defer 0.1
  :delight
  :bind (("C-c C-r" . ivy-resume)
         ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode))

(use-package ivy-pass
  :after ivy
  :commands ivy-pass)

(use-package ivy-rich
  :after ivy
  :init (setq ivy-rich-parse-remote-file-path t)
  :config (ivy-rich-mode 1))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(defun my/smarter-move-beginning-of-line (arg)
  "Moves point back to indentation of beginning of line.

  Move point to the first non-whitespace character on this line.
  If point is already there, move to the beginning of the line.
  Effectively toggle between the first non-whitespace character and
  the beginning of the line.

  If ARG is not nil or 1, move forward ARG - 1 lines first.  If
  point reaches the beginning or end of the buffer, stop there."
    (interactive "^p")
    (setq arg (or arg 1))

    ;; Move lines first
    (when (/= arg 1)
      (let ((line-move-visual nil))
        (forward-line (1- arg))))

    (let ((orig-point (point)))
      (back-to-indentation)
      (when (= orig-point (point))
        (move-beginning-of-line 1))))

(global-set-key [remap org-beginning-of-line] #'my/smarter-move-beginning-of-line)
(global-set-key [remap move-beginning-of-line] #'my/smarter-move-beginning-of-line)

(use-package rainbow-delimiters
  :defer 1
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package pdf-tools
  :defer 1
  :init (pdf-tools-install :no-query))

(use-package pdf-view
  :ensure nil
  :after pdf-tools
  :bind (:map pdf-view-mode-map
              ("C-s" . isearch-forward)
              ("d" . pdf-annot-delete)
              ("h" . pdf-annot-add-highlight-markup-annotation)
              ("t" . pdf-annot-add-text-annotation))
  :custom
  (pdf-view-display-size 'fit-page)
  (pdf-view-resize-factor 1.1)
  (pdf-view-use-unicode-ligther nil))

(use-package expand-region
  :defer 2
  :bind (("C-+" . er/contract-region)
         ("C-=" . er/expand-region)))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(use-package recentf
  :defer 2
  :bind ("C-x r" . recentf-open-files)
  :init (recentf-mode)
  :custom
  (recentf-exclude (list "COMMIT_EDITMSG"
                         "~$"
                         "/scp:"
                         "/ssh:"
                         "/sudo:"
                         "/tmp/"
                         "recentf"
                         ".newsrc-dribble"
                         ))
  (recentf-max-menu-items 15)
  (recentf-max-saved-items 200)
  (recentf-save-file "~/.emacs.d/recentf" )
  :config (run-at-time nil (* 5 60) 'recentf-save-list))

(use-package whitespace
  :defer 1
  :hook (before-save . delete-trailing-whitespace))

(use-package hungry-delete
  :defer 0.7
  :delight
  :config (global-hungry-delete-mode))

(global-set-key [remap kill-buffer] #'kill-this-buffer)

(use-package winner
  :defer 2
  :config (winner-mode 1))

(use-package simple
  :ensure nil
  :delight (auto-fill-function)
  :bind ("C-x p" . pop-to-mark-command)
  :hook ((prog-mode . turn-on-auto-fill)
         (text-mode . turn-on-auto-fill))
  :custom (set-mark-command-repeat-pop t))

;; revert all open file buffer
(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files.") )

;; reload emacs config
(defun reload-dotemacs-file ()
  "reload your .emacs file without restarting Emacs"
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(use-package elisp-mode :ensure nil :delight "ξ ")

(use-package eldoc
  :delight
  :hook (emacs-lisp-mode . eldoc-mode))

(use-package markdown-mode
  :delight "μ "
  :mode ("INSTALL\\'"
         "CONTRIBUTORS\\'"
         "LICENSE\\'"
         "README\\'"
         "\\.markdown\\'"
         "\\.md\\'"))

(use-package tex
  :ensure auctex
  :hook (LaTeX-mode . reftex-mode)
  :custom
  (TeX-PDF-mode t)
  (TeX-auto-save t)
  (TeX-byte-compile t)
  (TeX-clean-confirm nil)
  (TeX-master 'dwim)
  (TeX-parse-self t)
  (TeX-source-correlate-mode t)
  (TeX-view-program-selection '((output-pdf "Evince")
                                (output-html "xdg-open"))))

(use-package bibtex
  :after auctex
  :hook (bibtex-mode . my/bibtex-fill-column))

;; (use-package company-auctex
;;   :after (auctex company)
;;   :config (company-auctex-init))

;; (use-package company-math
;;     :after (auctex company))

(setq-default TeX-engine 'xetex)

(use-package reftex :after auctex)

(use-package cobol-mode
 :mode ("\\.cbl\\'" "\\.cpy\\'" "\\.pco\\'"))

;; (eval-after-load 'proof-script
;;   '(progn
;;      ;; (define-key proof-mode-map "\M-e" 'move-end-of-line)
;;      ;; (define-key proof-mode-map "\M-a" 'move-beginning-of-line)
;;      ;; (define-key proof-mode-map "\M-n"
;;      ;;   'proof-assert-next-command-interactive)
;;      ;; (define-key proof-mode-map "\M-p"
;;      ;;   'proof-undo-last-successful-command)
;;      (define-key proof-mode-map (kbd "\C-p") 'coq-About)
;;      (define-key proof-mode-map (kbd "\C-c\C-k")
;;        'proof-goto-point)
;;      ))
;; ;; Better indent for ssreflect
;; (setq coq-one-command-per-line nil)
;; (setq coq-indent-proofstart 0)
;; (setq coq-indent-modulestart 0)
;; ;; ;; input math symbol
;; (add-hook 'proof-mode-hook (lambda () (set-input-method "TeX") ))
;; ;; Open .v files with Proof General's Coq mode
;; (require 'proof-site "~/.emacs.d/lisp/PG/generic/proof-site")

;; (setq utop-command "opam config exec -- utop -emacs")
;; (add-to-list 'load-path
;;              "/home/baroud/.opam/4.07.1+flambda/share/emacs/site-lisp")
;; (require 'ocp-indent)
   (setq utop-command "opam config exec -- utop -emacs")
   (add-to-list 'load-path
                "/home/baroud/.opam/4.07.1+flambda/share/emacs/site-lisp")
    ;; (use-package ocp-indent
   ;; after:)

(use-package antlr-mode
  :mode ("\\.g4\\'"))

(use-package groovy-mode
    :mode ("\\.groovy\\'" "\\.gvy\\'" "\\.gy\\'""\\.gsh\\'" )
    :hook gradle-mode)

(use-package gradle-mode
    :mode ("\\.gradle\\'")
    )

(use-package typescript-mode
   :mode ("\\.ts\\'"))

(use-package yaml-mode
    :mode ("\\.yml\\'"))

(use-package gitignore-mode)

(use-package ledger-mode
  :mode ("\\.dat\\'" "\\.ledger\\'")
  :bind (:map ledger-mode-map ("c-x c-s" . my/ledger-save))
  :hook (ledger-mode . ledger-flymake-enable)
  :preface
  (defun my/ledger-save ()
    "automatically clean the ledger buffer at each save."
    (interactive)
    (ledger-mode-clean-buffer)
    (save-buffer))
  :custom
  (ledger-clear-whole-transactions t)
  (ledger-reconcile-default-commodity "eur")
  (ledger-reports
   '(("account statement" "%(binary) reg --real [[ledger-mode-flags]] -f %(ledger-file) ^%(account)")
     ("balance sheet" "%(binary) --real [[ledger-mode-flags]] -f %(ledger-file) bal ^assets ^liabilities ^equity")
     ("budget" "%(binary) --empty -s -t [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:budget")
     ("budget goals" "%(binary) --empty -s -t [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget goals'")
     ("budget obligations" "%(binary) --empty -s -t [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget obligations'")
     ("budget debts" "%(binary) --empty -s -t [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget debts'")
     ("cleared" "%(binary) cleared [[ledger-mode-flags]] -f %(ledger-file)")
     ("equity" "%(binary) --real [[ledger-mode-flags]] -f %(ledger-file) equity")
     ("income statement" "%(binary) --invert --real -s -t [[ledger-mode-flags]] -f %(ledger-file) bal ^income ^expenses -p \"this month\""))
   (ledger-report-use-header-line nil)))

   (use-package flycheck-ledger :after ledger-mode)

(use-package org
  :ensure org-plus-contrib
  :delight "Θ "
  :bind
   ("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture)
  :custom
     (org-use-extra-keys t)
     (org-catch-invisible-edits 'show-and-error)
     (org-cycle-separator-lines 0))

(use-package toc-org
  :after org
  :hook (org-mode . toc-org-enable))

(use-package org-indent :after org :ensure nil :delight)

(use-package org-agenda
   :ensure nil
   :after org
   :custom
   (org-directory "~/org")
   (org-agenda-files '("~/org/")
   (org-agenda-dim-blocked-tasks t)
   (org-agenda-inhibit-startup t)
   (org-agenda-show-log t)
   (org-agenda-skip-deadline-if-done t)
   (org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
   (org-agenda-skip-scheduled-if-done t)
   (org-agenda-span 2)
   (org-agenda-sticky nil)
   (org-agenda-tags-column -100)
   (org-agenda-time-grid '((daily today require-timed)))
   (org-agenda-use-tag-inheritance t)
   (org-enforce-todo-dependencies t)
   (org-habit-graph-column 80)
   (org-habit-show-habits-only-for-today nil)
   (org-track-ordered-property-with-tag t))
   (org-agenda-custom-commands
     (quote
     (("z" "Clean agenda" agenda ""
     ((org-agenda-tag-filter-preset
       (quote  ("-volim" "-hidden")))))))))


(use-package calfw :after org-agenda)

(use-package calfw-org
   :after calfw
   :bind ("C-c z" . cfw:open-org-calendar)
   :custom
   cfw:org-overwrite-default-keybinding t)

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom (org-bullets-bullet-list '("●" "▲" "■" "✶" "◉" "○" "○")))

(use-package org-capture
  :ensure nil
  :after org
  :preface
  (defun org-capture-template-goto-link ()
       "Set point for capturing at what capture target file+headline with headline set to %l would do."
       (org-capture-put :target (list 'file+headline (nth 1 (org-capture-get :target))
                                                            (org-capture-get :annotation)))
       (org-capture-put-target-region-and-position)
       (widen)
       (let ((hd (nth 2 (org-capture-get :target))))
            (goto-char (point-min))
            (if (re-search-forward
                (format org-complex-heading-regexp-format (regexp-quote hd)) nil t)
            (goto-char (point-at-bol))
            (goto-char (point-max))
            (or (bolp) (insert "\n"))
            (insert "* " hd "\n")
            (beginning-of-line 0))))

  (defvar my/org-people-template "** %\\1 %\\2
:PROPERTIES:
:Nombre:        %^{Nombre}
:Apellido:      %^{Apellido}%?
:Compleanos:    %^{Fecha de nacimiento}u
:Telefono:      %^{Telefono}
:Correo:        %^{Correo}
:Direccion:     %^{Direccion}
:Ciudad:        %^{Ciudad}
:Pais:          %^{Pais}
:Codigo postal: %^{Codigo postal}
:Map:      [[google-maps:%\\5+%\\6+%\\7+%\\8][Google Maps]]
:Nota:
:END:"
)

(defvar my/org-adress-template "** %\\1
:PROPERTIES:
:Nombre:        %^{Nombre}
:Telefono:      %^{Telefono}
:Correo:        %^{Correo}
:Direccion:     %^{Direccion}
:Ciudad:        %^{Ciudad}
:Pais:          %^{Pais}
:Codigo postal: %^{Codigo postal}
:Map:      [[google-maps:%\\5+%\\6+%\\7+%\\8][Google Maps]]
:END: "
)

(defvar my/org-espectaculo-template "*** %\\1
:PROPERTIES:
:nombre:   %^{Nombre}
:tipo:     %^{tipo}p
:lugar:    %^{Lugar}
:con:      %^{Con}
:cuando:   %^{Cuando}t
:END: "
)

(defvar my/org-personal-template "*** %\\1
:PROPERTIES:
:nombre:   %^{Nombre}
:lugar:    %^{Lugar}
:con:      %^{Con}
:cuando:   %^{Cuando}t
:END: "
)

(defvar my/org-transporte-template "** %\\1 -> %\\2
:PROPERTIES:
:de:       %^{de}
:a:        %^{a}
:tipo:     %^{tipo}p
:con:      %^{Con}
:cuando:   %^{Cuando}t
:END: "
)

(defvar my/org-ida-vuelta-template "** %\\1 -> %\\2
:PROPERTIES:
:de:       %^{de}
:a:        %^{a}
:tipo:     %^{tipo}p
:con:      %^{Con}
:cuando:   %^{Cuando}t
:END:
** %\\2 -> %\\1
:PROPERTIES:
:de:       %\\2
:a:        %\\1
:tipo:     %^{tipo}p
:con:      %^{Con}
:cuando:   %^{Cuando}t
:END: "
)

(defvar my/org-administrativod-template "** TODO %^{Que}
DEADLINE:   %^{Fecha tope}t
")

(defvar my/org-administrativos-template "** TODO %^{Que}
SCHEDULED:   %^{Programado}t
")

(defvar my/org-administrativo-template  "** TODO %^{Que}
:PROPERTIES:
:cuando:   %^{Cuando}t
:END:")

:custom
(org-capture-templates `(
("c" "Contact")
   ("cg" "Gente" entry (file+headline "~/org/contacts.org" "People"),
        my/org-people-template :empty-lines 1)
   ("ca" "Lugar" entry (file+headline "~/org/contacts.org" "Adress"),
        my/org-people-template :empty-lines 1)
("e" "Evento")
   ("es" "Espectaculo" entry (file+headline "~/org/diario.org" "Espectaculo"),
        my/org-espectaculo-template :empty-lines 1)
   ("ep" "Personal" entry (file+headline "~/org/diario.org" "Personal"),
        my/org-personal-template :empty-lines 1)
("v" "Viaje")
   ("vi" "Viaje individual" entry (file+headline "~/org/diario.org" "Transporte"),
        my/org-transporte-template :empty-lines 1)
   ("vv" "Viaje ida y vulta" entry (file+headline "~/org/diario.org" "Transporte"),
        my/org-ida-vuelta-template :empty-lines 1)
("a" "Administrativo")
   ("am" "meeting" entry (file+headline "~/org/diario.org" "Administrativo"),
        my/org-administrativo-template :empty-lines 1)
   ("as" "scheduled" entry (file+headline "~/org/diario.org" "Administrativo"),
        my/org-administrativos-template :empty-lines 1)
   ("ad" "deadline" entry (file+headline "~/org/diario.org" "Administrativo"),
        my/org-administrativod-template :empty-lines 1))))

(use-package org-contacts
  :ensure nil
  :after org
  :custom (org-contacts-files '("~/org/contacts.org")))

(use-package org-faces
  :ensure nil
  :after org
  :custom
  (org-todo-keyword-faces
   '(("DONE" . (:foreground "cyan" :weight bold))
     ("SOMEDAY" . (:foreground "gray" :weight bold))
     ("TODO" . (:foreground "green" :weight bold))
     ("WAITING" . (:foreground "red" :weight bold)))))

(use-package ob-C :ensure nil :after org)
;; (use-package ob-css :ensure nil :after org)
;; (use-package ob-ditaa :ensure nil :after org)
;; (use-package ob-dot :ensure nil :after org)
(use-package ob-emacs-lisp :ensure nil :after org)
;; (use-package ob-gnuplot :ensure nil :after org)
(use-package ob-java :ensure nil :after org)
(use-package ob-js :ensure nil :after org)
(use-package ob-latex :ensure nil :after org)
(use-package ob-ledger :ensure nil :after org)
(use-package ob-makefile :ensure nil :after org)
(use-package ob-org :ensure nil :after org)

;; (use-package ob-plantuml
;;   :ensure nil
;;   :after org
;;   :custom (org-plantuml-jar-path (expand-file-name (format "%s/plantuml.jar" xdg-lib))))

;; (use-package ob-python :ensure nil :after org)
;; (use-package ob-ruby :ensure nil :after org)
(use-package ob-shell :ensure nil :after org)
(use-package ob-sql :ensure nil :after org)

(defun org-convert-csv-table (beg end)
(interactive (list (mark) (point)))
(org-table-convert-region beg end ";")
 )

(use-package gnus
  :bind (("C-x e" . gnus)
        :map gnus-group-mode-map
        ("C-c C-f" . gnus-summary-mail-forward))
  :custom
  (gnus-fetch-old-headers t))
(use-package w3m
  :after gnus)

(use-package bbdb
  :after gnus)
(use-package bbdb-vcard
  :after bbdb)
;; (use-package vdirel
;;   :custom
;;   (vdirel-repository ~/Contacts))

(use-package magit
   :defer 0.3
   :bind ("C-x g" . magit-status)
)
(use-package git-commit
  :after magit
  :hook (git-commit-mode . my/git-commit-auto-fill-everywhere)
  :custom (git-commit-summary-max-length 50)
  :preface
  (defun my/git-commit-auto-fill-everywhere ()
    "Ensures that the commit body does not exceed 72 characters."
    (setq fill-column 72)
    (setq-local comment-auto-fill-only-comments nil)))

(use-package git-gutter
  :defer 0.3
  :delight
  :init (global-git-gutter-mode +1))

(use-package git-timemachine :defer 1 :delight)

(use-package dired
  :ensure nil
  :delight "Dired "
  :custom
  (dired-auto-revert-buffer t)
  (dired-dwim-target t)
  (dired-hide-details-hide-symlink-targets nil)
  (dired-omit-files "^\\...+$")
  (dired-omit-mode t)
  (dired-listing-switches "-alh")
  (dired-ls-F-marks-symlinks nil)
  (dired-recursive-copies 'always))

(use-package dired-x
  :ensure nil )

(use-package pass
  :delight "Pass ")
