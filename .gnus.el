;;ask encryption password once
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

(setq
 gnus-select-method
 '(nnimap "gmail"
          (nnimap-address "imap.gmail.com")
          (nnimap-server-port "imaps")
          (nnimap-stream ssl)
          (nnir-search-engine imap)
          (nnmail-expiry-target "[Gmail]/Papelera")
          (nnmail-expiry-wait immediate)))

(setq
 gnus-secondary-select-methods
 '((nnimap "outlook"
           (nnimap-address "outlook.office365.com")
           (nnimap-server-port 993)
           (nnimap-stream ssl)
           (nnir-search-engine imap)
           (nnmail-expiry-target "nnimap+outlook:Junk")
           (nnmail-expiry-wait immediate))))

;; gnus+davmail bug, so I have to use pop3 for DavMail
;; http://permalink.gmane.org/gmane.emacs.gnus.general/83301
;; but delete all the mails on server is scary
(setq pop3-leave-mail-on-server t)


(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]"
      smtpmail-local-domain "homepc")

(setq gnus-thread-sort-functions
      '(gnus-thread-sort-by-most-recent-date
        (not gnus-thread-sort-by-number)))


;; NO 'passive
(setq gnus-use-cache t)

;; Fetch only part of the article if we can.
;; I saw this in someone's .gnus
(setq gnus-read-active-file 'some)

;; Tree view for groups.
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; Threads!  I hate reading un-threaded email -- especially mailing
;; lists.  This helps a ton!
(setq gnus-summary-thread-gathering-function
      'gnus-gather-threads-by-subject)

;; Also, I prefer to see only the top level message.  If a message has
;; several replies or is part of a thread, only show the first
;; message.
;; `gnus-thread-ignore-subject' will ignore the subject and
;; look at 'In-Reply-To:' and 'References:' headers.
(setq gnus-thread-hide-subtree t)
(setq gnus-thread-ignore-subject t)


(setq user-mail-address "sylvain.ribstein@gmail.com"
      user-full-name "Sylvain Ribstein")

(setq mm-text-html-renderer 'w3m) ; OPTIONAL


(setq gnus-use-correct-string-widths nil)


(setq gnus-summary-line-format "%U%R%z %4i %([%4L: %-25,25f]%) %I%s\n")
(setq gnus-summary-same-subject "-||-")

(eval-after-load 'gnus-topic
  '(progn
     (setq gnus-message-archive-group
           '((format-time-string "sent.%Y")))
     (setq gnus-server-alist
           '(("Archivo" nnfolder "archive"
              (nnfolder-directory "~/Mail/archive")
              (nnfolder-active-file "~/Mail/archive/active")
              (nnfolder-get-new-mail nil)
              (nnfolder-inhibit-expiry t))))

     ;; "Gnus" is the root folder, and there are three mail accounts,
     ;; "misc", "hotmail", "gmail"
     (setq gnus-topic-topology
           '(("Mail" visible)
             (("Gmail" visible)
              (("New" visible))
              (("Perso" visible))
              (("Admin" visible))
              (("Pro" visible ))
              (("Other" invisible ))
              (("Misc" invisible ))
              (("Junk" invisible))
              )
             (("Outlook" invisible))
             ))

     ;; each topic corresponds to a public imap folder
     (setq gnus-topic-alist
           '(
             ("New"
              "INBOX"
              )
             ("Perso"
              "Personal"
              "Volim"
              "Activitad"
              "Activitad/Desarconnee"
              "Activitad/AtelierSoude"
              "Activitad/MonteeCoinche"
              )
             ("Admin"
              "Administrativo"
              "Administrativo/Caf"
              "Administrativo/Contrato/"
              "Administrativo/AirLiquide/"
              "Administrativo/Banco/"
              "Compra"
              "Compra/Google play"
              "Apartamento"
              "Transporte"
              "Salud"
              )
             ("Pro"
              "Trabajo"
              "Universidad"
              )
             ("Other"
              "Miscelaneo"
              )
             ("Misc"; the key of topic
              "nnset.2019"
              "nndraft:drafts"
              "[Gmail]"
              "[Gmail]/Enviados"
              "[Gmail]/Borradores"
              "nnfolder+archive:sent.2019"
              )
             ("Junk"; the key of topic
              "[Gmail]/Spam"
              "[Gmail]/Papelera"
              )
             ("Outlook"
              "nnimap+outlook:Inbox"
              "nnimap+outlook:proxGroup"
              "nnimap+outlook:POP"
              "nnimap+outlook:bordel a trier/bobcanard@hotmail.fr"
              "nnimap+outlook:Drafts"
              "nnimap+outlook:Sent"
              "nnimap+outlook:Archivo"
              "nnimap+outlook:Archivo/bobcanard@hotmail.fr"
              "nnimap+outlook:Deleted/bordel a trier"
              "nnimap+outlook:eglise"
              "nnimap+outlook:Archive"
              "nnimap+outlook:Envoyes"
              "nnimap+outlook:bordel a trier"
              "nnimap+outlook:famillia"
              "nnimap+outlook:eclais"
              "nnimap+outlook:Notes"
              "nnimap+outlook:Outbox"
              "nnimap+outlook:famille"
              "nnimap+outlook:Junk"
              "nnimap+outlook:Corbeille"
              "nnimap+outlook:Deleted"
              )))))
