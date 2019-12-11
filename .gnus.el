;;Byte Compile .gnus.el if it has changed since the last time visited
(defun GnusWait! ()
  "If ~/.gnus.el exists and is newer than ~/.gnus, recompile it
to ~/.gnus.elc and move the compiled version to ~/.gnus."
  (cond
   ((file-newer-than-file-p "~/.gnus.el" "~/.gnus")
    (let ((mode-line-format
           "*** PLEASE STANDBY: RECOMPILING .gnus.el **"))
      (sit-for 0)
      (byte-compile-file "~/.gnus.el")
      (message ".gnus recompiled --- reloading ...")
      (rename-file "~/.gnus.elc" "~/.gnus" t))
    (load "~/.gnus" t t t)
    (message "")
    )))

(GnusWait!)

;;ask encryption passw once
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

(setq gnus-select-method '(nnnil))

;; personnal google account
(setq gnus-secondary-select-methods
      '((nnimap "imap.gmail.com"
		(nnimap-address "imap.gmail.com")
		(nnimap-server-port "imaps")
		(nnimap-stream ssl)
		(nnir-search-engine imap)
		(nnmail-expiry-target "nnimap+imap.gmail.com:[Gmail]/Trash")
		(nnmail-expiry-wait immediate))
	(nnimap "outlook"
		(nnimap-address "outlook.office365.com")
		(nnimap-server-port 993)
		(nnimap-stream ssl)
		(nnir-search-engine imap)
		(nnmail-expiry-target "nnimap+outlook:Junk")
		(nnmail-expiry-wait immediate))
	;; (nnimap "cryptium"
	;; 	(nnimap-address "imap.gmail.com")
	;; 	(nnimap-server-port "imaps")
	;; 	(nnimap-stream ssl)
	;; 	(nnir-search-engine imap)
	;; 	(nnmail-expiry-target "[Gmail]/Bin")
	;; 	(nnmail-expiry-wait immediate))
	))

(defun setGmail ()
  "Setting personal gmail smtp details"
  (interactive)
  (message "From sylvain.ribstein@gmail.com")
  (setq user-mail-address "sylvain.ribstein@gmail.com")
  (setq message-send-mail-function 'smtpmail-send-it
	nsmtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
	smtpmail-auth-credentials
	'(("smtp.gmail.com" 587 "sylvain.ribstein@gmail.com" nil))
	smtpmail-default-smtp-server "smtp.gmail.com"
	smtpmail-smtp-server "smtp.gmail.com"
	smtpmail-smtp-service 587
	smtpmail-local-domain "smtp.gmail.com" ))

;;To set gmail smtp details
;; (defun setCryptium ()
;;   (interactive)
;;   (message "from cryptium")
;;   (setq user-mail-address "sylvain@cryptium.ch")
;;   (setq message-send-mail-function 'smtpmail-send-it
;; 	smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;; 	smtpmail-auth-credentials
;; 	'(("smtp.gmail.com" 587 "sylvain@cryptium.ch" nil))
;; 	smtpmail-default-smtp-server "smtp.gmail.com"
;; 	smtpmail-smtp-server "smtp.gmail.com"
;; 	smtpmail-smtp-service 587
;; 	smtpmail-local-domain "smtp.gmail.com"))

;;To set the yahoo smtp details
;; (defun setOutlook ()
;;   (interactive)
;;   (message "from outlook")
;;   (setq user-mail-address "sribst_baroud@outlook.com")
;;   (setq message-send-mail-function 'smtpmail-send-it
;; 	smtpmail-auth-credentials
;; 	'(("smtp.office365.com" 587 "sribst_baroud@outlook.om" nil))
;; 	smtpmail-default-smtp-server "smtp.office365.com"
;; 	smtpmail-smtp-server "smtp.office365.com"
;; 	smtpmail-smtp-service 587
;; 	smtpmail-local-domain "outlook.com" ))

;;Select automatically while replying
;;(add-hook 'message-mode-hook 'showMsg)
(add-hook
 'message-mode-hook
 '(lambda ()
    (cond
     ;; ((string-match "outlook" gnus-newsgroup-name) (setOutlook))
     ;; ((string-match "gmail" gnus-newsgroup-name) (setGmail))
     (t (setGmail))
     )))

(setq gnus-thread-sort-functions
      '(gnus-thread-sort-by-most-recent-date
        (not gnus-thread-sort-by-number)))

;; NO 'passive
(setq gnus-use-cache t)

;; Fetch only part of the article if we can.
(setq gnus-read-active-file 'some)

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; Threads email!
(setq gnus-summary-thread-gathering-function
      'gnus-gather-threads-by-subject)

;; Also, I prefer to see only the top level message.  If a message has
;; several replies or is part of a thread, only show the first
;; message.
;; `gnus-thread-ignore-subject' will ignore the subject and
;; look at 'In-Reply-To:' and 'References:' headers.
;; (setq gnus-thread-hide-subtree t)
(setq gnus-thread-ignore-subject t)

(setq mm-text-html-renderer 'w3m) ; OPTIONAL

(setq gnus-use-correct-string-widths nil)

;; (setq gnus-summary-line-format "%U%R%z %4i %([%4L: %-25,25f]%) %I%s\n")
;; (setq gnus-summary-same-subject "-||-")

;; (setq gnus-message-archive-group
;;       '((format-time-string " sent.%Y")))

;; (setq gnus-server-alist
;;       '(("Archivo" nnfolder "archive"
;; 	 (nnfolder-directory "~/Mail/archive")
;; 	 (nnfolder-active-file "~/Mail/archive/active")
;; 	 (nnfolder-get-new-mail nil)
;; 	 (nnfolder-inhibit-expiry t))))
;; ;; "Gnus" is the root folder, and there are three mail accounts,
;; ;; "misc", "hotmail", "gmail"
;; (setq gnus-topic-topology
;;       '(("Mail" visible)
;; 	(("Gmail" visible)
;; 	 (("New" visible))
;; 	 (("Perso" visible))
;; 	 (("Admin" visible))
;; 	 (("Pro" visible ))
;; 	 (("Other" invisible ))
;; 	 (("Misc" invisible ))
;; 	 (("Junk" invisible))
;; 	 )
;; 	;; (("Cryptium" visible))
;; 	;; (("Outlook" invisible))
;; 	))
;; ;; each topic corresponds to a public imap folder

;; (setq gnus-topic-alist
;;       '(
;; 	("New"
;; 	 "INBOX"
;; 	 )
;; 	("Perso"
;; 	 "Personal"
;; 	 "Volim"
;; 	 "Activity"
;; 	 "Activity/Desarconnee"
;; 	 "Activity/AtelierSoude"
;; 	 "Activity/MonteeCoinche"
;; 	 )
;; 	("Admin"
;; 	 "Administrative"
;; 	 "Administrative/Caf"
;; 	 "Administrative/Contract/"
;; 	 "Administrative/Bank/"
;; 	 "Administrative/Bank/AirLiquide/"
;; 	 "Administrative/Tax/"
;; 	 "Fetch"
;; 	 "Fetch/Google play"
;; 	 "House"
;; 	 "Transport"
;; 	 "Health"
;; 	 )
;; 	("Pro"
;; 	 "Profesionnal"
;; 	 "University"
;; 	 )
;; 	("Other"
;; 	 "Other"
;; 	 )
;; 	("Misc"; the key of topic
;; 	 "sent.2019"
;; 	 "nndraft:drafts"
;; 	 )))
