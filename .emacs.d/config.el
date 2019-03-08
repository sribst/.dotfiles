(setq package-archives '(
     ("melpa" . "http://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("org" . "http://orgmode.org/elpa/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(use-package use-package-ensure-system-package :ensure t)

(use-package delight :ensure t)

(setq auth-sources '("~/.gnupg/shared/authinfo.gpg"
                       "~/.authinfo.gpg"
;;                       "~/.authinfo"
;;                       "~/.netrc"
  ))

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
  tab-width 4                                      ; Set width for tabs
  use-package-always-ensure t                      ; Avoid the :ensure keyword for each package
  user-full-name "Sylvain Ribstein"                ; Set the full name of the current user
  user-mail-address "sylvain.ribstein@gmail.com"   ; Set the email address of the current user
  vc-follow-symlinks t                             ; Always follow the symlinks
  view-read-only t)                                ; Always open read-only buffers in view-mode
 (cd "~/")                                        ; Move to the user directory
 (column-number-mode 1)                           ; Show the column number
 (display-time-mode 1)                            ; Enable time in the mode-line
 (fset 'yes-or-no-p 'y-or-n-p)                    ; Replace yes/no prompts with y/n
 (global-hl-line-mode)                            ; Hightlight current line
 (set-default-coding-systems 'utf-8)              ; Default to utf-8 encoding
 (show-paren-mode 1)                              ; Show the parenthesis

(setq-default custom-file (expand-file-name "~/.emacs.d/custom.el"))
(when (file-exists-p custom-file)
  (load custom-file t))

(when window-system
  (menu-bar-mode -1)                              ; Disable the menu bar
  (scroll-bar-mode -1)                            ; Disable the scroll bar
  (tool-bar-mode -1)                              ; Disable the tool bar
  (tooltip-mode -1))                              ; Disable the tooltips

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
  :bind ("M-o" . ace-window)
  :init (setq aw-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l)))
  (use-package ibuffer
    :defer 0.2
    :bind ("C-x C-b" . ibuffer))
;;  (use-package ibuffer-projectile
;;   :after ibuffer
;;   :preface
;;   (defun my/ibuffer-projectile ()
;;     (ibuffer-projectile-set-filter-groups)
;;    (unless (eq ibuffer-sorting-mode 'alphabetic)
;;        (ibuffer-do-sort-by-alphabetic)))
;;    :hook (ibuffer . my/ibuffer-projectile))

(use-package dashboard
  :preface
  :init
  (add-hook 'after-init-hook 'dashboard-refresh-buffer)
  (add-hook 'dashboard-mode-hook 'my/dashboard-banner)
  :custom (dashboard-startup-banner 'logo)
  :config (dashboard-setup-startup-hook))

(use-package abbrev
  :defer 1
  :ensure nil
  :delight
  :hook (text-mode . abbrev-mode)
  :custom (abbrev-file-name "~/.emacs.d/abbrev_defs")
  :config
  (if (file-exists-p abbrev-file-name)
      (quietly-read-abbrev-file)))

(use-package flyspell
  :defer 1
  :delight
  :custom
  (flyspell-abbrev-p t)
  (flyspell-issue-message-flag nil)
  (flyspell-issue-welcome-flag nil)
  (flyspell-mode 1))

(use-package flyspell-correct-ivy
  :after flyspell
  :bind (:map flyspell-mode-map
              ("C-;" . flyspell-correct-word-generic))
  :custom (flyspell-correct-interface 'flyspell-correct-ivy))

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

(use-package rainbow-mode
  :defer 2
  :delight
  :hook (prog-mode))

(use-package undo-tree
  :delight
  :bind ("C--" . undo-tree-redo)
  :init (global-undo-tree-mode)
  :custom
  (undo-tree-visualizer-timestamps t)
  (undo-tree-visualizer-diff t))

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
  :bind ("C-c r" . recentf-open-files)
  :init (recentf-mode)
  :custom
  (recentf-exclude (list "COMMIT_EDITMSG"
                         "~$"
                         "/scp:"
                         "/ssh:"
                         "/sudo:"
                         "/tmp/"))
  (recentf-max-menu-items 15)
  (recentf-max-saved-items 200)
  (recentf-save-file "~/.emacs.d/recentf" )
  :config (run-at-time nil (* 5 60) 'recentf-save-list))

(use-package whitespace
  :defer 1
  :hook (before-save . delete-trailing-whitespace))

(global-set-key [remap kill-buffer] #'kill-this-buffer)

(use-package switch-window
  :defer 0.2
  :bind (("C-x o" . switch-window)
         ("C-x w" . switch-window-then-swap-buffer)))

(use-package simple
  :ensure nil
  :delight (auto-fill-function)
  :bind ("C-x p" . pop-to-mark-command)
  :hook ((prog-mode . turn-on-auto-fill)
         (text-mode . turn-on-auto-fill))
  :custom (set-mark-command-repeat-pop t))

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
  :hook (bibtex-mode . my/bibtex-fill-column)
  :preface
  (defun my/bibtex-fill-column ()
    "Ensures that each entry does not exceed 120 characters."
    (setq fill-column 120)))

(use-package company-auctex
  :after (auctex company)
  :config (company-auctex-init))

(use-package company-math :after (auctex company))

(setq-default TeX-engine 'xetex)

(use-package reftex :after auctex)

(use-package ledger-mode
  :ensure-system-package (ledger . "trizen -S --noconfirm ledger")
  :mode ("\\.dat\\'"
         "\\.ledger\\'")
  :bind (:map ledger-mode-map
              ("C-x C-s" . my/ledger-save))
  :hook (ledger-mode . ledger-flymake-enable)
  :preface
  (defun my/ledger-save ()
    "Automatically clean the ledger buffer at each save."
    (interactive)
    (ledger-mode-clean-buffer)
    (save-buffer))
  :custom
  (ledger-clear-whole-transactions t)
  (ledger-reconcile-default-commodity "EUR")
  (ledger-reports
   '(("account statement" "%(binary) reg --real [[ledger-mode-flags]] -f %(ledger-file) ^%(account)")
     ("balance sheet" "%(binary) --real [[ledger-mode-flags]] -f %(ledger-file) bal ^assets ^liabilities ^equity")
     ("budget" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:budget")
     ("budget goals" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget goals'")
     ("budget obligations" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget obligations'")
     ("budget debts" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget debts'")
     ("cleared" "%(binary) cleared [[ledger-mode-flags]] -f %(ledger-file)")
     ("equity" "%(binary) --real [[ledger-mode-flags]] -f %(ledger-file) equity")
     ("income statement" "%(binary) --invert --real -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^income ^expenses -p \"this month\""))
   (ledger-report-use-header-line nil)))

   (use-package flycheck-ledger :after ledger-mode)

(use-package toc-org
  :after org
  :hook (org-mode . toc-org-enable))

(use-package org-indent :after org :ensure nil :delight)

(use-package gnus
  :bind ("C-x e" . gnus)
  :custom
  (gnus-fetch-old-headers t))
;;(use-package nnir
;;  :after gnus
;;  :config
;;  (gnus-save-newsrc-file 'nil)

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
  (dired-listing-switches "-alh")
  (dired-ls-F-marks-symlinks nil)
  (dired-recursive-copies 'always))

(use-package dired-x
  :ensure nil
  :preface
  (defun my/dired-revert-after-cmd (command &optional output error)
    (revert-buffer))
  :config (advice-add 'dired-smart-shell-command :after #'my/dired-revert-after-cmd))
