;; MELPA
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
;; == end of MELPA == 

;; BAD REQUEST BUG FIX
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;; == end of BUG FIX ==

;; use-package first install
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))
;; == end of use-package ==

;; Magit git front-end
(use-package magit
  :ensure t)
(setq magit-refresh-status-buffer nil)
;; == end of Magit ==

  
;; EVIL MODE!
(use-package evil
	     :ensure t
	     :config (evil-mode 1))
;; == end of evil mode ==

;; doom modeline (+ all-the-icons dependency)
(use-package all-the-icons
	     :ensure t) ; REMEMBER to RUN "all-the-icons-install-fonts" after installation 
(use-package doom-modeline
             :ensure t
             :hook (after-init . doom-modeline-mode)
             :config (setq doom-modeline-height 25))
;; == end of doom modeline ==

;; company-mode autocompletion
(use-package company
             :ensure t
             :config (add-hook 'after-init-hook  'global-company-mode))
;; == end of autocompletion ==

;; haskell development
(use-package haskell-mode
             :ensure t)
(use-package haskell-interactive-mode)
(use-package haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'flyspell-prog-mode)
;; == end of haskell coding ==

;; markdown mode
(use-package markdown-mode
             :ensure t
             :commands (markdown-mode gfm-mode)
             :mode (("README\\.md\\'" . gfm-mode)
                   ("\\.md\\'" . markdown-mode)
                   ("\\.markdown\\'" . markdown-mode))
             :init (setq markdown-command "markdown"))
;; == end of markdown mode == 

;; enable show paren mode
(add-hook 'after-init-hook 'show-paren-mode)
;; == end of show paren mode ==

;; remove unwanted ui elements
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
;; == end of unwanted ui ==

;; set default theme
(load-theme 'adwaita)
;; == end of default theme ==

;; set default font
(add-to-list 'default-frame-alist
	     '(font . "Inconsolata-20:bold"))
(let ((faces '(mode-line
               mode-line-buffer-id
               mode-line-emphasis
               mode-line-highlight
               mode-line-inactive)))
     (mapc
      (lambda (face) (set-face-attribute face nil :font "xos4 Terminus-14:bold"))
      faces))
;; == end of default font ==

;; set default empty line fringe
(setq-default indicate-empty-lines t)
(progn
  (define-fringe-bitmap 'tilde [0 0 0 113 219 142 0 0] nil nil 'center)
  (setcdr (assq 'empty-line fringe-indicator-alist) 'tilde))
(set-fringe-bitmap-face 'tilde 'font-lock-function-name-face)
;; == end of default empty line ==

;; default window splitting preferences
(setq split-height-threshold nil)
(setq split-width-threshold 1)
;; == end of default window splitting ==

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit markdown-mode company haskell-mode evil use-package doom-modeline))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
