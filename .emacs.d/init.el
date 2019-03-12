;;; init.el --- GNU Emacs Configuration
;; Copyright (C) 2014 Terencio Agozzino

;; Author: Terencio Agozzino <terencio.agozzino@gmail.com>
;; Created: February 16, 2014
;; Homepage: https://github.com/rememberYou/.emacs.d
;; Keywords: abbrev, convenience, faces, maint, outlines, vc

;; This program is free software. You can redistribute it and/or modify it under
;; the terms of the Do What The Fuck You Want To Public License, version 2 as
;; published by Sam Hocevar.
;;
;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE.
;;
;; You should have received a copy of the Do What The Fuck You Want To Public
;; License along with this program. If not, see http://www.wtfpl.net/.

;;; Commentary:

;; Following lines build the configuration code out of the config.el file.

;;; Code:

;; Make startup faster by reducing the frequency of garbage
;; collection.
(setq gc-cons-threshold (* 50 1000 1000))

(require 'package)
(package-initialize)

(if (file-exists-p (expand-file-name "config.el" user-emacs-directory))
    (load-file (expand-file-name "config.el" user-emacs-directory))
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

;;; All behond this line should disappear on config.el
;;-------------------------------------;;
;;                CONFIG               ;;
;;-------------------------------------;;
;; describe all keybinding possible from current buffer
;; (require 'helm-descbinds)
;; (helm-descbinds-mode)
;; del arrow in front
;; (if (not (and (boundp 'window-system) window-system))
;;     (setq overlay-arrow-string nil))

;; compile key
(global-set-key "\C-cn" 'next-error)
(global-set-key "\C-cp" 'previous-error)

;;-------------------------------------;;
;;                FONCTION             ;;
;;-------------------------------------;;

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

;;-------------------------------------;;
;;               company               ;;
;;-------------------------------------;;
;; Make company aware of merlin
;; (with-eval-after-load 'company
;;   (add-to-list 'company-backends 'merlin-company-backend))
;; Enable company on merlin managed buffers
;; (add-hook 'merlin-mode-hook 'company-mode)
;; Or enable it globally:
;; (add-hook 'after-init-hook 'global-company-mode)

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

(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")

;;-------------------------------------;;
;;                ORG                  ;;
;;-------------------------------------;;
(setq org-agenda-files '("~/org/"))
;; Global key for quick orgmod access
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

;; ;; orgmod automatic closed option in TODO note
;; (setq org-log-done 'time)

;; org-gcal
;; (setq package-check-signature nil)
;; (require 'org-gcal)
;; (setq org-gcal-client-id "617324877547-rilbu0tbmqbr4imaeq43vloq14cs2n8a.apps.googleusercontent.com"
;;       org-gcal-client-secret "GrT12sPB9vOoAzmUqYmn8DRU"
;;       org-gcal-file-alist '(("sylvain.ribstein@gmail.com" .  "~/org/gcal.org")))

;; (add-hook 'org-agenda-mode-hook
;;           (lambda () (org-gcal-sync) ))
;; (add-hook 'org-capture-after-finalize-hook
;;           (lambda () (org-wgcal-sync)))


;; CALFW
;; better calendar view
;; (require 'calfw-org)
;; (global-set-key "\C-cm" 'cfw:open-org-calendar)
;; (setq cfw:org-overwrite-default-keybinding t)
;; (setq calendar-week-start-day 1) ; 0:Sunday, 1:Monday

;; (setq org-agenda-custom-commands
;;       '(("z" "Agenda and gobal TODOS"
;;          ((agenda "hidden")
;;           ;; (tags "hidden")
;;           ))))
;; ;(setq org-agenda-custom-commands
;;       '(("c" "Desk Work" tags-todo "hidden"
;;          ((org-agenda-files "~/org/agenda.org")
;;           (org-agenda-sorting-strategy
;;            '(priority-up effort-down))))
;;))
;; (setq org-agenda-custom-commands
;;       '( ("x" "simple agenda" tags ""
;;           ( (org-agenda-tag-filter-preset '(("-hidden" "-volim") ) ))
;;           ) ) )
;; '(org-agenda-custom-commands
;;   (quote
;;    (("x" "simple agenda" tags ""
;;      ((org-agenda-tag-filter-preset
;;        (quote
;;         ("-hidden" "-volim"))))))))

;; (setq org-agenda-custom-commands
;;
;;          ((org-agenda-tag-filter-preset
;;            ("-hidden" "-volim"))))))

(setq org-capture-templates
      '(
        ;; (c) Contact template
        ("c" "New contact" entry
         (file+headline "contact.org" "Contact")
         " * %^{First} %^{Last}%?
   :PROPERTIES:
   :First:    %\\1
   :Middle:
   :Last:     %\\2
   :Birthday: %^{Birth Date}u
   :Phone:    %^{Phone}
   :Email:    %^{Email}
   :Website:
   :Address:  %^{Address}
   :City:     %^{City}
   :Country:  %^{Country}
   :Zip:      %^{Zip}
   :Map:      [[google-maps:%\\5+%\\6+%\\7+%\\8][Google Maps]]
   :Company:
   :W-Group:
   :W-Title:
   :W-Phone:
   :W-Email:
   :W-Website:
   :W-Address:
   :W-Office:
   :W-City:
   :W-State:
   :W-Zip:
   :W-Map:
   :Facebook:
   :Github:
   :Linkedin:
   :YouTube:
   :Note:
   :END:
   :LOGBOOK:
   - State \"\"           from \"\"           %U
   :END:"
         )

        ("a" "Agenda")
        ("ab" "Basic entry" entry
         (file+headline "agenda.org" "Tosort")
         "* %^{} %^{Last}%?
   :PROPERTIES:
   :First:    %\\1
   :Middle:
   :Last:     %\\2
   :Birthday: %^{Birth Date}u
   :Phone:    %^{Phone}
   :Email:    %^{Email}
   :Website:
   :Address:  %^{Address}
   :City:     %^{City}
   :Country:  %^{Country}
   :Zip:      %^{Zip}
   :Map:      [[google-maps:%\\5+%\\6+%\\7+%\\8][Google Maps]]
   :Company:
   :W-Group:
   :W-Title:
   :W-Phone:
   :W-Email:
   :W-Website:
   :W-Address:
   :W-Office:
   :W-City:
   :W-State:
   :W-Zip:
   :W-Map:
   :Facebook:
   :Github:
   :Linkedin:
   :YouTube:
   :Note:
   :END:
   :LOGBOOK:
   - State \"\"           from \"\"           %U
   :END:"
         )
        )
      )
;; (setq org-capture-templates
;;       '(
;;         ;; Templates for the TASKS keyword sequence
;;         ("t" "Tasks")

;;         ;; TODO     (t) Todo template
;;         ("tt" "TODO      (t) Todo" entry (file "ref.org")
;;          "
;; * TODO %?
;;   :PROPERTIES:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"TODO\"       from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; WAITING  (w) Waiting template
;;         ("tw" "WAITING   (w) Waiting" entry (file "ref.org")
;;              "* WAITING %?
;;   :PROPERTIES:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"WAITING\"    from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; DELEGATED(e) Delegated template
;;         ("te" "DELEGATED (e) Delegated" entry (file "ref.org")
;;              "* DELEGATED %?
;;   :PROPERTIES:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"DELEGATED\"  from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; CANCELLED(x) Cancelled template
;;         ("tx" "CANCELLED (x) Cancelled" entry (file "ref.org")
;;              "* CANCELLED %
;;   CLOSED: %U
;;   :PROPERTIES:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"TODO\"       from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; DONE     (d) Done template
;;         ("td" "DONE      (d) Done" entry (file "ref.org")
;;              "* DONE %?
;;   CLOSED: %U
;;   :PROPERTIES:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"DONE\"       from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; Templates for the POSSESSIONS keyword sequence
;;         ("p" "Possessions")

;;         ;; PURCHASE (p) Purchase template
;;         ("pp" "PURCHASE  (p) Purchase" entry (file "ref.org")
;;              "* PURCHASE %?
;;   :PROPERTIES:
;;   :Cost:
;;   :Paid:
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;         Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;         Card}][%\\1]]
;;   :Merchant: [[peo:%^{Merchant}][%\\2]]
;;   :Link:
;;   :Quantity:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"PURCHASE\"   from \"\"           %U
;;   :END:")

;;         ;; PURCHASED(j) Purchased template
;;         ("pj" "PURCHASED (j) Purchased" entry (file "ref.org")
;;              "* PURCHASED %?
;;   :PROPERTIES:
;;   :Cost:
;;   :Paid:
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;         Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;         Card}][%\\1]]
;;   :Merchant: [[peo:%^{Merchant}][%\\2]]
;;   :Link:
;;   :Quantity:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"PURCHASED\"  from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; TRANSIT  (u) Transit template
;;         ("pu" "TRANSIT   (u) Transit" entry (file "ref.org")
;;              "* TRANSIT %?
;;   :PROPERTIES:
;;   :Cost:
;;   :Paid:
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;         Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;         Card}][%\\1]]
;;   :Merchant: [[peo:%^{Merchant}][%\\2]]
;;   :Link:
;;   :Quantity:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"TRANSIT\"    from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; GIFT     (h) Gift    template
;;         ("ph" "GIFT      (h) Gift" entry (file "ref.org")
;;              "* GIFT %?
;;   :PROPERTIES:
;;   :Cost:
;;   :Paid:
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;         Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;         Card}][%\\1]]
;;   :Merchant: [[peo:%^{Merchant}][%\\2]]
;;   :Link:
;;   :Quantity:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"GIFT\"       from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; SELL     (k) Sell template
;;         ("pk" "SELL      (k) Sell" entry (file "ref.org")
;;              "* SELL %?
;;   :PROPERTIES:
;;   :Cost:
;;   :Paid:
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;         Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;         Card}][%\\1]]
;;   :Merchant: [[peo:%^{Merchant}][%\\2]]
;;   :Link:
;;   :Quantity:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"SELL\"       from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; LOANED   (n) Loaned template
;;         ("pj" "LOANED    (n) Loaned" entry (file "ref.org")
;;              "* LOANED %?
;;   :PROPERTIES:
;;   :Cost:
;;   :Paid:
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;         Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;         Card}][%\\1]]
;;   :Merchant: [[peo:%^{Merchant}][%\\2]]
;;   :Link:
;;   :Quantity:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"LOANED\"     from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; UNWANTED (j) Unwanted template
;;         ("pa" "UNWANTED  (a) Unwanted" entry (file "ref.org")
;;              "* UNWANTED %?
;;   CLOSED: %U
;;   :PROPERTIES:
;;   :Cost:
;;   :Paid:
;;     :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;         Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;         Card}][%\\1]]
;;   :Merchant: [[peo:%^{Merchant}][%\\2]]
;;   :Link:
;;   :Quantity:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"UNWANTED\"   from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; OWN      (o) Own template
;;         ("po" "OWN       (o) Own" entry (file "ref.org")
;;              "* OWN %?
;;   CLOSED: %U
;;   :PROPERTIES:
;;   :Cost:
;;   :Paid:
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;         Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;         Card}][%\\1]]
;;   :Merchant: [[peo:%^{Merchant}][%\\2]]
;;   :Link:
;;   :Quantity:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"OWN\"        from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; GIFTED   (g) Gifted template
;;         ("pg" "GIFTED    (g) Gifted" entry (file "ref.org")
;;              "* GIFTED %?
;;   CLOSED: %U
;;   :PROPERTIES:
;;   :Cost:
;;   :Paid:
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;         Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;         Card}][%\\1]]
;;   :Merchant: [[peo:%^{Merchant}][%\\2]]
;;   :Link:
;;   :Quantity:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"GIFTED\"     from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; SOLD     (k) Sold template
;;         ("pc" "SOLD      (c) Sold" entry (file "ref.org")
;;              "* SOLD %?
;;   CLOSED: %U
;;   :PROPERTIES:
;;   :Cost:
;;   :Paid:
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;         Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;         Card}][%\\1]]
;;   :Merchant: [[peo:%^{Merchant}][%\\2]]
;;   :Merchant:
;;   :Link:
;;   :Quantity:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"SOLD\"       from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; DISCARDED(q) Purchased template
;;         ("pq" "DISCARDED (q) Purchased" entry (file "ref.org")
;;              "* DISCARDED %?
;;   CLOSED: %U
;;   :PROPERTIES:
;;   :Cost:
;;   :Paid:
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;         Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;         Card}][%\\1]]
;;   :Merchant: [[peo:%^{Merchant}][%\\2]]
;;   :Link:
;;   :Quantity:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"DISCARDED\"  from \"\"           %U
;;   :END:" :empty-lines 1)

;;         ;; Templates for the MULTIMEDIA keyword sequence
;;         ("m" "Multimedia")

;;         ;; CONSUME  (r) Consume template
;;            ("mr" "CONSUME   (r) Consume org-protocol" entry (file
;;                                                              "ref.org")
;;                 "* CONSUME [[%:link][%:description]]
;;   :PROPERTIES:
;;   :Creator:  %:creator
;;   :Created:  %:description
;;   :Source:   %:source
;;   :Via:      %:via
;;   :Link:     %:link
;;   :Date:     %:date
;;   :Note:     %:note
;;   :END:
;;   :LOGBOOK:
;;   - State \"CONSUME\"    from \"\"           %U
;;   :END:

;;   %:initial" :empty-lines 1)

;;            ;; SUBSCRIBE(r) Subscribe template
;;               ("mb" "SUBSCRIBE (b) Subscribe org-protocol" entry (file
;;                                                                   "ref.org")
;;                    "* SUBSCRIBE [[%:link][%:description
;;   :PROPERTIES:
;;   :Creator:  %:creator
;;   :Created:  %:description
;;   :Source:   %:source
;;   :Via:      %:via
;;   :Link:     %:link
;;   :Date:     %:date
;;   :Note:     %:note
;;   :END:
;;   :LOGBOOK:
;;   - State \"SUBSCRIBE\"  from \"\"           %U
;;   :END:

;;   %:initial" :empty-lines 1)

;;               ;; CONSUMING(l) Consuming template
;;                  ("ml" "CONSUMING (l) Consuming org-protocol" entry
;;                   (file "ref.org")
;;                       "* CONSUMING [[%:link][%:description]]
;;   :PROPERTIES:
;;   :Creator:  %:creator
;;   :Created:  %:description
;;   :Source:   %:source
;;   :Via:      %:via
;;   :Link:     %:link
;;   :Date:     %:date
;;   :Note:     %:note
;;   :END:
;;   :LOGBOOK:
;;   - State \"CONSUMING\"  from \"\"           %U
;;   :END:

;;   %:initial" :empty-lines 1)

;;                  ;; SHARE    (s) Share template
;;                     ("ms" "SHARE     (s) Share org-protocol" entry
;;                      (file "ref.org")
;;                          "* SHARE [[%:link][%:description
;;   :PROPERTIES:
;;   :Creator:  %:creator
;;   :Created:  %:description
;;   :Source:   %:source
;;   :Via:      %:via
;;   :Link:     %:link
;;   :Date:     %:date
;;   :Note:     %:note
;;   :END:
;;   :LOGBOOK:
;;   - State \"SHARE\"      from \"\"           %U
;;   :END:

;;   %:initial" :empty-lines 1)

;;                     ;; IGNORED  (r) Ignored template
;;                        ("mi" "IGNORED   (i) Ignored org-protocol"
;;                         entry (file "ref.org")
;;                             "* IGNORED [[%:link][%:description]]
;;   CLOSED: %U
;;   :PROPERTIES:
;;   :Creator:  %:creator
;;   :Created:  %:description
;;   :Source:   %:source
;;   :Via:      %:via
;;   :Link:     %:link
;;   :Date:     %:date
;;   :Note:     %:note
;;   :END:
;;   :LOGBOOK:
;;   - State \"IGNORED\"    from \"\"           %U
;;   :END:

;;   %:initial" :empty-lines 1)

;;                        ;; REFERENCE(f) Reference template
;;                           ("mf" "REFERENCE (f) Reference org-protocol"
;;                            entry (file "ref.org")
;;                                "* REFERENCE [[%:link][%:description]]
;;   CLOSED: %U
;;   :PROPERTIES:
;;   :Creator:  %:creator
;;   :Created:  %:description
;;   :Source:   %:source
;;   :Via:      %:via
;;   :Link:     %:link
;;   :Date:     %:date
;;   :Note:     %:note
;;   :END:
;;   :LOGBOOK:
;;   - State \"REFERENCE\"  from \"\"           %U
;;   :END:

;;   %:initial" :empty-lines 1)

;;                              ;; These templates are used with the
;;                           ;; EVENTS TODO sequence
;;                           ("e" "Events")

;;                           ;; VISIT    (v) Visit template
;;                              ("ev" "VISIT     (v) Visit" entry (file
;;                                                                 "ref.org")
;;                                   "* VISIT %?
;;   :PROPERTIES:
;;   :Attend:   [[peo:Dominic Surano][Dominic Surano]]
;;   :Location:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"VISIT\"      from \"\"           %U
;;   :END:
;;   %^t--%^t" :empty-lines 1)

;;                              ;; DIDNOTGO (z) Didnotgo template
;;                                 ("ez" "DIDNOTGO  (z) Didnotgo" entry
;;                                  (file "ref.org")
;;                                      "* DIDNOTGO %?
;;   CLOSED: %U
;;   :PROPERTIES:
;;   :Attend:   [[peo:Dominic Surano][Dominic Surano]]
;;   :Location:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"DIDNOTGO\"   from \"\"           %U
;;   :END:
;;   %^t--%^t" :empty-lines 1)

;;                                 ;; MEETING  (m) Meeting template
;;                                    ("em" "MEETING   (m) Meeting" entry
;;                                     (file "ref.org")
;;                                         "* MEETING %?
;;   CLOSED: %^U
;;   :PROPERTIES:
;;   :Attend:   [[peo:Dominic Surano][Dominic Surano]]
;;   :Location:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"MEETING\"    from \"\"           %U
;;   :END:
;;   %^T" :empty-lines 1)

;;                                    ;; VISITED  (y) Visited template
;;                                       ("ey" "VISITED   (y) Visited"
;;                                        entry (file "ref.org")
;;                                            "* VISITED %?
;;   CLOSED: %U
;;   :PROPERTIES:
;;   :Attend:   [[peo:Dominic Surano][Dominic Surano]]
;;   :Location:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"VISITED\"    from \"\"           %U
;;   :END:
;;   %^t--%^t" :empty-lines 1)

;;                                       ("n" "Non-TODO States")
;;                                       ;;          (a) Account
;;                                       ;;          template
;;                                       ("na" "          (a) Account"
;;                                        entry (file+headline "org.org"
;;                                                             "Accounts")
;;                                           "* %?
;;   :PROPERTIES:
;;   :Website:
;;   :Username:
;;   :Email:
;;   :Password: %(my/generate-openssl-password)
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"\"           from \"\"           %U
;;   :END:" :empty-lines 1)

;;                                         ;;          (b) Business
;;                                         ;;          template
;;                                         ("nb" "          (b)
;; Business" entry (file+headline "peo.org" "Businesses")
;;     "* %^{Company} %?
;;   :PROPERTIES:
;;   :Company:  %\\1
;;   :Phone:    %^{Phone}
;;   :Email:    %^{Email}
;;   :Website:  %^{Website}
;;   :Address:  %^{Address}
;;   :City:     %^{City}
;;   :State:    %^{State}
;;   :Zip:      %^{Zip}
;;   :Map:      [[google-maps:%\\5+%\\6+%\\7+%\\8][Google Maps]]
;;   :Wifi:
;;   :Pass:
;;   :Hours:
;;   :Yelp:     [[yelp-business:%^{Yelp}][%\\9]]
;;   :Facebook:
;;   :G_Plus:
;;   :Instagram:
;;   :Linkedin:
;;   :Twitter:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"\"           from \"\"           %U
;;   :END:" :empty-lines 1)

;;                                            ;;          (c) Contact
;;                                            ;;          template
;;                                            ("nc" "          (c)
;; Contact" entry (file+headline "peo.org" "People")
;;     "* %^{First} %^{Last}%?
;;   :PROPERTIES:
;;   :First:    %\\1
;;   :Middle:
;;   :Last:     %\\2
;;   :Birthday: %^{Birth Date}u
;;   :Phone:    %^{Phone}
;;   :Email:    %^{Email}
;;   :Website:
;;   :Address:  %^{Address}
;;   :City:     %^{City}
;;   :State:    %^{State}
;;   :Zip:      %^{Zip}
;;   :Map:      [[google-maps:%\\5+%\\6+%\\7+%\\8][Google Maps]]
;;   :Company:
;;   :W-Group:
;;   :W-Title:
;;   :W-Phone:
;;   :W-Email:
;;   :W-Website:
;;   :W-Address:
;;   :W-Office:
;;   :W-City:
;;   :W-State:
;;   :W-Zip:
;;   :W-Map:
;;   :Facebook:
;;   :G:
;;   :G-Plus:
;;   :G-Scho:
;;   :Github:
;;   :Instagram:
;;   :Linkedin:
;;   :OkCupid:
;;   :Reddit:
;;   :Twitter:
;;   :Yelp:
;;   :YouTube:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"\"           from \"\"           %U
;;   :END:

;; ** Wish List
;;    :LOGBOOK:
;;    - State \"TODO\"       from \"\"           %U
;;    :END:

;; ** Tasks
;;    :LOGBOOK:
;;    - State \"TODO\"       from \"\"           %U
;;    :END:

;; *** TODO Wish %\\1 %\\2 a Happy Birthday
;;     DEADLINE: %^{Birthday}t
;;     :PROPERTIES:
;;     :Via:
;;     :Note:
;;     :END:
;;     :LOGBOOK:
;;     - State \"TODO\"       from \"\"           %U
;;     :END:

;; **** TODO Buy %\\1 %\\2 a Birthday Gift
;;      SCHEDULED: %^{Buy Gift By}t DEADLINE: %^{Birthday}t
;;      :PROPERTIES:
;;      :Via:
;;      :Note:
;;      :END:
;;      :LOGBOOK:
;;      - State \"TODO\"       from \"\"           %U
;;      :END:

;; *** TODO Buy %\\1 %\\2 a Christmas Gift
;;     SCHEDULED: <2016-12-01 Tue +1y> DEADLINE: <2016-12-25 Fri +1y>
;;     :PROPERTIES:
;;     :Via:
;;     :Note:
;;     :END:
;;     :LOGBOOK:
;;     - State \"TODO\"       from \"\"           %U
;;     :END:" :empty-lines 1)

;;                                                  ;;          (e)
;;                                                  ;;          Payment
;;                                               ;;          template
;;                                                  ("ne" "          (e)
;; Payment" entry (file "ref.org")
;;     "* Paid %? :fin:
;;   :PROPERTIES:
;;   :Cost:     %^{Cost}
;;   :Paid:     %^{Paid}
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;; Checking Account|Wells Fargo Debit Account|GE Capital Credit
;; Card}][%\\3]]
;;   :Merchant: [[peo:%^{Merchant}][%\\4]]
;;   :Link:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"\"           from \"\"           %U
;;   :END:
;;   %T" :empty-lines 1)

;;                                                     ;;          (f)
;;                                                     ;;          Fuel
;;                                                  ;;          template
;;                                                     ("nf" "
;; (f) Fuel" entry (file+headline "fin.org" "Fuel Up")
;;     "* Fuel Up at %^{Merchant|Costco Poway|Costco Mission Valley San
;; Diego} :fin:
;;   :PROPERTIES:
;;   :Cost:     %^{Cost}
;;   :Paid:     %\\2
;;   :Method:   [[fin:%^{Method|Wells Fargo Debit Account|Wells Fargo
;;                                    Credit Account}][%\\3]]
;;   :Per_Gal:  %^{Per Gallon}
;;   :Gallons:  %^{Gallons}
;;   :Beg_Mil:  %?
;;   :End_Mil:  %^{End Miles}
;;   :Tot_Mil:
;;   :MPG:
;;   :PPM:
;;   :Merchant: [[peo:%\\1][%\\1]]
;;   :Link:     [[val:fin/Receipts/%<%Y-%m-%d> %^{Merchant Short
;;                                             Name}.pdf][%<%Y-%m-%d>
;;                                                        %\\7.pdf]]
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"\"           from \"\"           %U
;;   :END:
;; %T" :empty-lines 1)

;;    ;;          (n) Note template
;;    ("nn" "          (n) Note" entry (file "ref.org")
;;     "* %? :note:
;;   :PROPERTIES:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"\"           from \"\"           %U
;; :END:" :empty-lines 1)

;;    ;;          (h) Heading template
;;    ("nh" "          (h) Heading" entry (file "ref.org")
;;     "* %?
;;   :PROPERTIES:
;;   :END:
;;   :LOGBOOK:
;;   - State \"\"           from \"\"           %U
;; :END:" :empty-lines 1)

;;    ;;          (j) Journal template
;;    ("nj" "          (j) Journal" entry (file+headline "org.org"
;;    "Journal")
;;     "* Journal :org:
;;   :PROPERTIES:
;;   :Via:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"\"           from \"\"           %U
;;   :END:
;; %T\n\n  %?" :empty-lines 1)

;;    ;;          (p) Paycheck template
;;    ("np" "          (p) Paycheck" entry (file+headline "fin.org"
;;    "Paycheck")
;;     "* Paycheck :fin:
;;   :PROPERTIES:
;;   :Cost:     -%^{Amount}
;;   :Paid:     -%\\1
;;   :Method:   [[fin:Wells Fargo Debit Account][Wells Fargo Debit
;;    Account]]
;;   :Merchant: [[peo:General Atomics Aeronautical Systems Inc.][General
;;    Atomics Aeronautical Systems Inc.]]
;;   :Link:     [[val:fin/Banking/Work/General Atomics Aeronautical
;;    Systems Inc./Paycheck/%<%Y-%m-%d>.pdf][%<%Y-%m-%d>.pdf]]
;;   :Note:     %?
;;   :END:
;;   :LOGBOOK:
;;   - State \"\"           from \"\"           %U
;;   :END:
;; %T" :empty-lines 1)

;;    ;;          (s) Shopping template
;;    ("ns" "          (s) Shopping" entry (file "ref.org")
;;     "* %^{Action|Paid|Shopped at|Ate at|Drank at} %^{Merchant|Sprouts
;;    Hillcrest San Diego|Trader Joe's Hillcrest San Diego|Trader Joe's
;;    Mira Mesa San Diego|Farmer's Market Hillcrest San Diego|Costco
;;    Poway|Costco Mission Valley San Diego|Target Mission Valley San
;;    Diego|Poncho Villa North Park San Diego|VONS Poway|Ralphs Hillcrest
;;    San Diego|Whole Foods Hillcrest San Diego} :fin:
;;   :PROPERTIES:
;;   :Cost:     %^{Cost}
;;   :Paid:     %^{Paid}
;;   :Method:   [[fin:%^{Method|Wells Fargo Credit Account|Wells Fargo
;;    Checking Account|Wells Fargo Debit Account|GE Capital Credit
;;    Card}][%\\5]]
;;   :Merchant: [[peo:%\\2][%\\2]]
;;   :Link:     %?
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"\"           from \"\"           %U
;;   :END:
;;   %T

;;   | Item                           | Price ($) | Amount    | Total ($)
;;     |
;;   |                                | <9>       | <9>       | <9>
;;     ||
;;   |--------------------------------+-----------+-----------+-----------|
;;   |                                |           |           |
;;     ||
;;   |                                |           |           |
;;     ||
;;   |--------------------------------+-----------+-----------+-----------|
;;   | Tax                            |           | 1         |
;;     ||
;;   | Total                          |           |           |
;;     ||
;;   #+TBLFM: $4=$2*$3;%.2f::@>$4=vsum(@3..@-1);%.2f
;; " :empty-lines 1)

;;    ;;          (t) Transfer template
;;    ("nt" "          (t) Transfer" entry (file "ref.org")
;;     "* Transferred %? :fin:
;;   :PROPERTIES:
;;   :Cost:     %^{Cost}
;;   :Paid:     0.00
;;   :Method:   [[fin:%^{Method|Wells Fargo Debit Account|Wells Fargo
;;    Savings Account|Wells Fargo Credit Account|Wells Fargo Checking
;;    Account|GE Capital Credit Card}][%\\2]]
;;   :Merchant: [[fin:%^{Merchant|Wells Fargo Checking Account|Wells
;;    Fargo Savings Account|Wells Fargo Credit Account|Wells Fargo Debit
;;    Account|GE Capital Credit Card}][%\\3]]
;;   :Link:
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"\"           from \"\"           %U
;;   :END:
;; %T" :empty-lines 1)

;;    ("o" "Org-Protocol")
;;    ;; TODO     (t) Org-protocol todo template
;;    ;; Alternatively use [[%:link][%:description]] for :Via:
;;    ("ot" "TODO      (t) Org-Protocol Todo" entry (file "ref.org")
;;     "* TODO %?
;;   :PROPERTIES:
;;   :Via:      %:annotation
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"TODO\"       from \"\"           %U
;; :END:" :empty-lines 1)

;;    ;; MEETING  (m) Meeting template
;;    ("om" "MEETING   (m) Org-Protocol Meeting" entry (file "ref.org")
;;     "* MEETING %:description
;;   CLOSED: %^U
;;   :PROPERTIES:
;;   :Attend:   [[peo:Dominic Surano][Dominic Surano]]
;;   :Location: %?
;;   :Via:      %:annotation
;;   :Note:
;;   :END:
;;   :LOGBOOK:
;;   - State \"MEETING\"    from \"\"           %U
;;   :END:
;; %^T" :empty-lines 1)
;;    ))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
