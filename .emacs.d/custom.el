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
 '(auto-revert-verbose nil t)
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backup"))))
 '(cfw:org-overwrite-default-keybinding t t)
 '(company-begin-commands (quote (self-insert-command)))
 '(company-idle-delay 0.2)
 '(company-minimum-prefix-length 2)
 '(company-show-numbers t)
 '(company-tooltip-align-annotations t)
 '(csv-separators (quote (";" ",")) t)
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c2104aacc11ed1617955f16ae9a737b870f846105b6854744f3dd3bfb03d8a18" "86704574d397606ee1433af037c46611fb0a2787e8b6fd1d6c96361575be72d2" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(dashboard-startup-banner (quote logo) t)
 '(delete-old-versions -1)
 '(dired-auto-revert-buffer t)
 '(dired-dwim-target t)
 '(dired-hide-details-hide-symlink-targets nil)
 '(dired-listing-switches "-alh")
 '(dired-ls-F-marks-symlinks nil)
 '(dired-omit-files "^\\...+$")
 '(dired-omit-mode t t)
 '(dired-recursive-copies (quote always))
 '(global-company-mode t)
 '(gnus-fetch-old-headers t)
 '(history-delete-duplicates t)
 '(history-length t)
 '(ibuffer-saved-filter-groups
   (quote
    (("default"
      ("dired"
       (mode . dired-mode))
      ("org"
       (name . "^.*org$"))
      ("magit"
       (or
        (mode . magit-mode)
        (name . "^magit.*$")))
      ("IRC"
       (or
        (mode . circe-channel-mode)
        (mode . circe-server-mode)))
      ("web"
       (or
        (mode . web-mode)
        (mode . js2-mode)))
      ("shell"
       (or
        (mode . eshell-mode)
        (mode . shell-mode)))
      ("gnus"
       (or
        (mode . message-mode)
        (mode . bbdb-mode)
        (mode . mail-mode)
        (mode . gnus-group-mode)
        (mode . gnus-summary-mode)
        (mode . gnus-article-mode)
        (name . "^\\.bbdb$")
        (name . "^\\.newsrc-dribble")))
      ("programming"
       (or
        (mode . java-mode)
        (mode . groovy-mode)
        (mode . conf-space-mode)))
      ("emacs"
       (or
        (name . "^\\*scratch\\*$")
        (name . "^\\*Messages\\*$")))
      ("Ediff"
       (name . "^\\*Ediff.*\\*$"))))) t)
 '(ivy-count-format "(%d/%d) ")
 '(ivy-extra-directories nil)
 '(ivy-use-virtual-buffers t)
 '(nil nil t)
 '(org-agenda-custom-commands
   (quote
    (("b" "Experimental"
      ((agenda ""
               ((org-agenda-span
                 (quote 1))
                (org-super-agenda-groups
                 (quote
                  ((:name "Agenda" :and
                          (:time-grid t :todo t))
                   (:name "Scheduled" :scheduled t)
                   (:name "Deadline" :deadline t)
                   (:name "Information" :and
                          (:time-grid t :todo nil)))))))
       (alltodo ""
                ((org-super-agenda-groups
                  (quote
                   ((:name "Current Work" :and
                           (:tag "work" :todo "INPROGRESS"))
                    (:name "recurrent Work" :and
                           (:tag "work" :tag "recurrent"))
                    (:name "Next work" :and
                           (:tag "work" :todo "TODO"))
                    (:name "on pause Work" :todo "WAITING")
                    (:name "recurrent" :tag "recurrent")
                    (:name "Current" :todo "INPROGRESS")
                    (:name "Book ASAP" :todo "BOOK")
                    (:name "Next " :todo "TODO")
                    (:name "Daily" :and
                           (:todo
                            ("TOBUY" "FETCH")
                            :tag "daily"))
                    (:name "FETCH ASAP" :todo
                           ("TOBUY" "FETCH"))
                    (:name "One day" :todo "SOMEDAY")
                    (:name "on pause" :todo "WAITING")
                    (:discard
                     (:todo
                      ("TOGO" "GO" "TOUSE" "USE" "IDEA")))))))))))))
 '(org-agenda-dim-blocked-tasks t)
 '(org-agenda-files (quote ("~/org/")))
 '(org-agenda-inhibit-startup t)
 '(org-agenda-show-log t t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled))
 '(org-agenda-skip-scheduled-if-deadline-is-shown t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-skip-timestamp-if-deadline-is-shown t)
 '(org-agenda-skip-timestamp-if-done t)
 '(org-agenda-span 2)
 '(org-agenda-sticky nil)
 '(org-agenda-tags-column -100)
 '(org-agenda-time-grid (quote ((daily today require-timed))))
 '(org-agenda-todo-ignore-deadline (quote far) t)
 '(org-agenda-todo-ignore-scheduled (quote future))
 '(org-agenda-todo-ignore-timestamp (quote future))
 '(org-agenda-use-tag-inheritance t)
 '(org-bullets-bullet-list (quote ("●" "▲" "■" "✶" "◉" "○" "○")))
 '(org-capture-templates
   (quote
    (("e" "Event")
     ("es" "Show")
     ("esr" "To book" entry
      (file+headline "~/org/master.org" "Show")
      "* BOOK %^{Name} [[google-maps:%\\2][@dress]] %^g
  :PROPERTIES:
  :Created:     %U
  :Name:   %\\1
  :Type:   %^{Type}p
  :Place:  %^{Place}
  :With:   %^{With}
  :GMap:   [[google-maps:%\\2][@dress]]
  :END:
  %^{When}T
")
     ("esg" "To go" entry
      (file+headline "~/org/master.org" "Show")
      "* GO %^{Name} [[:%\\2][@dress]] %^g
  :PROPERTIES:
  :Created:     %U
  :Name:   %\\1
  :Type:   %^{Type}p
  :Place:  %^{Place}
  :With:   %^{With}
  :GMap:   [[google-maps:%\\2][@dress]]
  :END:
  %^{When}T
")
     ("er" "To book" entry
      (file+headline "~/org/master.org" "Agenda")
      "* BOOK %^{Name} [[google-maps:%\\2][@dress]] %^g
  :PROPERTIES:
  :Created:     %U
  :Name:   %\\1
  :Type:   %^{Type}p
  :Place:  %^{Place}
  :With:   %^{With}
  :GMap:   [[google-maps:%\\2][@dress]]
  :END:
  %^{When}T
")
     ("eg" "To go" entry
      (file+headline "~/org/master.org" "Agenda")
      "* GO %^{Name} [[:%\\2][@dress]] %^g
  :PROPERTIES:
  :Created:     %U
  :Name:   %\\1
  :Type:   %^{Type}p
  :Place:  %^{Place}
  :With:   %^{With}
  :GMap:   [[google-maps:%\\2][@dress]]
  :END:
  %^{When}T
")
     ("et" "Trip")
     ("ets" "Single trip" entry
      (file+headline "~/org/master.org" "Trip")
      "* GO %\\1 -%\\3-> %\\2
  :PROPERTIES:
  :Created: %U
  :From:    %^{From|Lyon Part-dieu|Lyon Perrache|Lyon Georges|Paris GdL|Montpellier St-Roch}
  :To:    %^{To|Lyon Part-dieu|Lyon Perrache|Lyon Georges|Paris GdL|Montpellier St-Roch}
  :Type:    %^{Type}p
  :With:    %^{With}
  :END:
  %^{When}T
")
     ("etr" "Round trip" entry
      (file+headline "~/org/master.org" "Trip")
      "* GO %\\1 -%\\3-> %\\2
  :PROPERTIES:
  :Created: %U
  :From:    %^{From|Lyon Part-dieu|Lyon Perrache|Lyon Georges|Paris GdL|Montpellier St-Roch}
  :To:    %^{to|Lyon Part-dieu|Lyon Perrache|Lyon Georges|Paris GdL|Montpellier St-Roch}
  :Type:    %^{Type}p
  :With:    %^{With}
  :END:
  %^{When}T
* GO %\\2 -> %\\1
  :PROPERTIES:
  :Created: %U
  :From:      %\\2
  :To:       %\\1
  :Type:    %^{Type}p
  :With:    %^{With}
  :END:
  %^{When}T
")
     ("t" "TO-DO")
     ("tt" "todo" entry
      (file+headline "~/org/master.org" "TO-DO")
      "* TODO %^{What} %^g
  :PROPERTIES:
  :Created:     %U
  :END:
")
     ("to" "oneday" entry
      (file+headline "~/org/master.org" "TO-DO")
      "* SOMEDAY %^{What} %^g
  :PROPERTIES:
  :Created:     %U
  :END:
")
     ("tw" "work" entry
      (file+headline "~/org/master.org" "Work")
      "* TODO %^{What} %^g
  :PROPERTIES:
  :Created:     %U
  :mission:     %^{mission}p
  :CATEGORY:    %\\2
  :END:
")
     ("v" "voucher" entry
      (file+headline "~/org/master.org" "Voucher")
      "* USE %^{Valor}
   DEADLINE:%^{Before}t
  :PROPERTIES:
  :Reduction:     %^{Reduction}
  :At:     %^{At|oui.sncf|ouibus|ouigo...}
  :END:
  %^{Cuando}t
")
     ("s" "stuff")
     ("sb" "buy" entry
      (file+headline "~/org/master.org" "objet")
      "* FETCH %^{What}
  :PROPERTIES:
  :Created:     %U
  :END:
")
     ("sg" "gift" entry
      (file+headline "~/org/master.org" "objet")
      "* IDEA %^{What}
  :PROPERTIES:
  :Created:     %U
  :For: %^{For}
  :When: %^{When}t
  :END:
")
     ("sa" "Flat" entry
      (file+headline "~/org/master.org" "Flat")
      "* BUY %^{What}
  :PROPERTIES:
  :Created:     %U
  :Room: %^{Room}p
  :CATEGORY: %\\2
  :END:
"))))
 '(org-catch-invisible-edits (quote show-and-error))
 '(org-contacts-files (quote ("~/org/contacts.org")))
 '(org-cycle-separator-lines 0)
 '(org-directory "~/org")
 '(org-enforce-todo-dependencies t)
 '(org-habit-graph-column 80 t)
 '(org-habit-show-habits-only-for-today nil t)
 '(org-journal-dir "~/org/journal/")
 '(org-journal-enable-agenda-integration t)
 '(org-journal-file-format "%Y%m%d")
 '(org-link-abbrev-alist
   (quote
    (("google-maps" . "http://maps.google.com/maps?q=%s")
     ("open-street-map" . "http://nominatim.openstreetmap.org/search?q=%s&polygon=1"))))
 '(org-todo-keyword-faces
   (quote
    (("BOOK" :foreground "red" :weight bold)
     ("GO" :foreground "orange" :weight bold)
     ("WENT" :foreground "green" :weight bold)
     ("CANCELED" :foreground "grey")
     ("SOMEDAY" :foreground "blue")
     ("TODO" :foreground "red" :weight bold)
     ("INPROGRESS" :foreground "orange" :weight bold)
     ("WAITING" :foreground "yellow" :weight bold)
     ("DONE" :foreground "green")
     ("ABORDED" :foreground "grey")
     ("IDEA" :foreground "blue" :weight bold)
     ("FETCH" :foreground "red" :weight bold)
     ("GIVE" :foreground "orange" :weight bold)
     ("FETCHED" :foreground "green" :weight bold)
     ("GIVEN" :foreground "green" :weight bold)
     ("USE" :foreground "red" :weight bold)
     ("CONSUMED" :foreground "green" :weight bold)
     ("LOST" :foreground "grey"))))
 '(org-track-ordered-property-with-tag t)
 '(org-use-extra-keys t)
 '(package-selected-packages
   (quote
    (smart-mode-line-powerline-theme posframe statusbar preview latex files dune ivy-smex swiper-helm dired-x dired org-capture forge helm-projectile helm-company projectile helm-smex helm-swoop helm-gitlab helm gitlab twittering-mode find-file-in-project xresources-theme all-the-icons-dired all-the-icons typing-practice typing jdee org-super-agenda org-super-agenda-mode org-journal soothe-theme org-caldav dired-du calfw-cal async company pdf-view auto-package-update erc-join auctex typescript-mode vdirel bbdb-vcard pass hungry-delete emacs-delphi-mode gradle-mode gitignore-mode git-modes yaml-mode erc-image erc-hl-nicks org-bullets org-plus-contrib company-box bbdb git-timemachine git-gutter flycheck-ledger ledger-mode toc-org wiki-summary which-key w3m utop use-package-ensure-system-package undo-tree tuareg switch-window switch-buffer-functions smex smartparens smart-mode-line ranger rainbow-mode rainbow-delimiters pdf-tools paradox org-gcal ocp-indent nord-theme move-text merlin markdown-mode major-mode-hydra magit-popup magit ivy-rich ivy-pass iedit helm-descbinds groovy-mode flyspell-correct-ivy flymd flycheck expand-region engine-mode eclim delight dashboard csv-mode counsel company-math company-auctex cobol-mode calfw-org calfw auto-complete async-await ascii-art-to-unicode alert-termux aggressive-indent ace-window)))
 '(paradox-column-width-package 27)
 '(paradox-column-width-version 13)
 '(paradox-execute-asynchronously t)
 '(paradox-hide-wiki-packages t)
 '(rainbow-r-colors t)
 '(rainbow-x-colors t)
 '(recentf-exclude
   (quote
    ("COMMIT_EDITMSG" "~$" "/scp:" "/ssh:" "/sudo:" "/tmp/" "recentf" ".newsrc-dribble")))
 '(recentf-max-menu-items 15)
 '(recentf-max-saved-items 200)
 '(recentf-save-file "~/.emacs.d/recentf")
 '(savehist-additional-variables (quote (kill-ring search-ring regexp-search-ring)))
 '(savehist-file "~/.emacs.d/history")
 '(savehist-save-minibuffer-history 1)
 '(set-mark-command-repeat-pop t)
 '(setq (quote respectful) t)
 '(sml/theme (quote powerline))
 '(vc-make-backup-files t)
 '(version-control t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
