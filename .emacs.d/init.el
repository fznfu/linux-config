;.; .emacs.d/init.el
;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support
(require 'package)
(setq package-enable-at-startup nil)
;; fix issue with installing GNU packages
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;; Adds the Melpa, Marmalade and GNU archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;; Stable version of Melpa
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; Commenting out Marmalade (for now at least) at its certs are expired
;; (add-to-list 'package-archives
;; 	     '("marmalade" . "https://marmalade-repo.org/packages/") t)
;; (add-to-list 'package-archives
;;	     '("gnu" . "https://elpa.gnu.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)
;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Load most configuration from Org file
(org-babel-load-file (expand-file-name "~/.emacs.d/smash.org"))

;; File for custom variables
(setq-default custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
