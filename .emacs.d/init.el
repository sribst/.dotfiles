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
(setq config-file (expand-file-name "config.el" user-emacs-directory))
(if (file-exists-p config-file) (load-file config-file)
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

;; ## added by OPAM user-setup for emacs / base ##
;; ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(setq opam-file (expand-file-name "opam-user-setup.el" user-emacs-directory))
(when (file-exists-p opam-file)
  (require 'opam-user-setup opam-file))
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
