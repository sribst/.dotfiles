(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t t)
 '(TeX-auto-save t t)
 '(TeX-byte-compile t t)
 '(TeX-clean-confirm nil t)
 '(TeX-master (quote dwim) t)
 '(TeX-parse-self t t)
 '(TeX-source-correlate-mode t t)
 '(TeX-view-program-selection (quote ((output-pdf "Evince") (output-html "xdg-open"))) t)
 '(abbrev-file-name "~/.emacs.d/abbrev_defs")
 '(aggressive-indent-comments-too nil)
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backup"))))
 '(blink-cursor-mode nil)
 '(company-begin-commands (quote (self-insert-command)))
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 2)
 '(company-show-numbers t)
 '(company-tooltip-align-annotations t)
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(dashboard-startup-banner (quote logo) t)
 '(delete-old-versions -1)
 '(dired-auto-revert-buffer t)
 '(dired-dwim-target t)
 '(dired-hide-details-hide-symlink-targets nil)
 '(dired-listing-switches "-alh")
 '(dired-ls-F-marks-symlinks nil)
 '(dired-recursive-copies (quote always))
 '(flyspell-abbrev-p t)
 '(flyspell-correct-interface (quote flyspell-correct-ivy) t)
 '(flyspell-issue-message-flag nil)
 '(flyspell-issue-welcome-flag nil)
 '(flyspell-mode 1 t)
 '(git-commit-summary-max-length 50)
 '(global-company-mode t)
 '(gnus-fetch-old-headers t)
 '(history-delete-duplicates t)
 '(history-length t)
 '(ispell-silently-savep t)
 '(ivy-count-format "(%d/%d) ")
 '(ivy-use-virtual-buffers t)
 '(org-agenda-custom-commands
   (quote
    (("z" "Clean agenda" agenda ""
      ((org-agenda-tag-filter-preset
        (quote
         ("-volim" "-hidden"))))))))
 '(org-agenda-files (quote ("~/org/")))
 '(org-bullets-bullet-list (quote ("●" "▲" "■" "✶" "◉" "○" "○")))
 '(org-contacts-files (quote ("~/org/contacts.org")))
 '(org-todo-keyword-faces
   (quote
    (("DONE" :foreground "cyan" :weight bold)
     ("SOMEDAY" :foreground "gray" :weight bold)
     ("TODO" :foreground "green" :weight bold)
     ("WAITING" :foreground "red" :weight bold))))
 '(package-selected-packages
   (quote
    (org-bullets org-plus-contrib company-box bbdb git-timemachine git-gutter flycheck-ledger ledger-mode toc-org wiki-summary which-key w3m utop use-package-ensure-system-package undo-tree tuareg switch-window switch-buffer-functions smex smartparens smart-mode-line ranger rainbow-mode rainbow-delimiters pdf-tools paradox org-gcal ocp-indent nord-theme move-text merlin markdown-mode major-mode-hydra magit-popup magit ivy-rich ivy-pass iedit helm-descbinds groovy-mode flyspell-correct-ivy flymd flycheck expand-region engine-mode eclim delight dashboard csv-mode counsel company-math company-auctex cobol-mode calfw-org calfw auto-complete async-await ascii-art-to-unicode alert-termux aggressive-indent ace-window)))
 '(paradox-column-width-package 27)
 '(paradox-column-width-version 13)
 '(paradox-execute-asynchronously t)
 '(paradox-hide-wiki-packages t)
 '(recentf-exclude
   (quote
    ("COMMIT_EDITMSG" "~$" "/scp:" "/ssh:" "/sudo:" "/tmp/")))
 '(recentf-max-menu-items 15)
 '(recentf-max-saved-items 200)
 '(recentf-save-file "~/.emacs.d/recentf")
 '(savehist-additional-variables (quote (kill-ring search-ring regexp-search-ring)))
 '(savehist-file "~/.emacs.d/history")
 '(savehist-save-minibuffer-history 1)
 '(set-mark-command-repeat-pop t)
 '(undo-tree-visualizer-diff t)
 '(undo-tree-visualizer-timestamps t)
 '(vc-make-backup-files t)
 '(version-control t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
