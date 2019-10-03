;;; init.el --- GNU Emacs Configuration
;; Copyright (C) 2014 Terencio Agozzino

;; Author: Terencio Agozzino <terencio.agozzino@gmail.com>
;; Created: 2018
;; Homepage: https://github.com/sribst/dotfiles
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

;; (defun load-directory (directory)
;;   "Load recursively all `.el' files in DIRECTORY. hidden in org file  "
;;   (dolist (element (directory-files-and-attributes directory nil nil nil))
;;     (let* ((path (car element))
;;            (fullpath (concat directory "/" path))
;; 	   (isdir (car (cdr element)))
;;            (ignore-dir (or (string= path ".") (string= path ".."))))
;;       (cond
;;        ((and (eq isdir t) (not ignore-dir)) (load-directory fullpath))
;;        ((and (eq isdir nil) (string= (substring path -3) ".el"))
;; 	(load (file-name-sans-extension fullpath)))
;;        ((and (eq isdir nil) (string= (substring path -3) ".org"))
;; 	(org-babel-load-file fullpath))))))
;; (load-directory "config")

(setq config-file (expand-file-name "config.el" user-emacs-directory))
(if (file-exists-p config-file) (load-file config-file)
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
(put 'dired-find-alternate-file 'disabled nil)
