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

;; external libs dir
(add-to-list 'load-path "~/.emacs.d/extlib")
;; == end of external libs ==

;; BAD REQUEST BUG FIX (fixed in later versions)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;; == end of BUG FIX ==

;; == IN CASE OF A PACKAGE NOT INSTALLING, TRY TO RUN <M-x>`package-refresh-contents`<RET> BEFORE DOING ANYTHING STUPID ==
;; == USEFUL EMACS KEYBINDINGS: ==
;;    * <C-h> i       : read the emacs manuals
;;    * <C-h> k <COM> : gives COMPLETE info about inputted command
;;    * <C-h> c <COM> : gives short info about inputted command
;;    * <C-h> ?       : display help menu
;;    * <C-h> m       : gives info about current major mode
;;    * <C-x> 2       : spawns a window below
;;    * <C-M-v>       : scrolls down the other window
;;    * <C-M-S-v>     : scrolls up the other window
;; == end of emacs keybindings ==

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
  :config
  (evil-set-initial-state 'dashboard-mode 'emacs)
  (evil-set-initial-state 'haskell-interactive-mode 'emacs)
  (evil-set-initial-state 'shell-mode 'emacs)
  (evil-mode 1))
;; == end of evil mode ==

;; company-mode autocompletion
(use-package company
  :ensure t
  :config (add-hook 'after-init-hook  'global-company-mode))
;; == end of autocompletion ==

;; snippets expansion via yasnippet
(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))
(use-package yasnippet-snippets
  :ensure t)
;; == end of yasnippet ==

;; doom modeline (+ all-the-icons dependency)
(use-package all-the-icons
  :ensure t
  :config
  (unless (file-exists-p "~/.local/share/fonts/all-the-icons.ttf")
    (all-the-icons-install-fonts)))
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config (setq doom-modeline-height 25))
;; == end of doom modeline ==

;; haskell development
(use-package haskell-mode
  :ensure t)
(use-package haskell-interactive-mode)
(use-package haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'flyspell-prog-mode)
;; == end of haskell coding ==

;; OCaml development
(use-package tuareg
  :ensure t)
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
;; == end of OCaml coding ==

;; markdown mode
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "markdown"))
;; == end of markdown mode ==

;; custom splash screen with emacs-dashboard
(use-package page-break-lines
  :ensure t)
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
;; customization
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-items '((recents  . 9)))
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-navigator t)
(setq dashboard-navigator-buttons
      `(;; line1
        (("" "init.el" "Open init.el config file" (lambda (&rest _) (find-file "~/.emacs.d/init.el"))))))
;; enable for emacs --daemon
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
;; == end of custom splash screen ==

;; sensible window switching and moving with ace-window
(use-package ace-window
  :ensure t)
;; == end of ace-window ==

;; highlight indentation
(use-package highlight-indentation
  :ensure t
  :config
  (set-face-background 'highlight-indentation-face "#CCCCCC")
  (set-face-background 'highlight-indentation-current-column-face "#999999")
  (add-hook 'prog-mode-hook 'highlight-indentation-current-column-mode))
;; == end of ace-window ==

;; enable show paren mode
(add-hook 'after-init-hook 'show-paren-mode)
;; == end of show paren mode ==

;; automatically close brackets
(electric-pair-mode 1)
;; == end of auto closing brackets ==

;; remove unwanted ui elements
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
;; == end of unwanted ui ==

;; delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; == end of trailing whitespace ==

;; set default theme
(load-theme 'adwaita)
;; == end of default theme ==

;; highlight line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#ccdae9")
(set-face-foreground 'highlight nil)
;; == end of highlight ==

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
;; fallback unicode font
(set-fontset-font "fontset-default" 'unicode "DejaVu Sans Mono-20:bold")
;; == end of default font ==

;; set default empty line fringe
(setq-default indicate-empty-lines t)
(progn
  (define-fringe-bitmap 'tilde [0 0 0 113 219 142 0 0] nil nil 'center)
  (setcdr (assq 'empty-line fringe-indicator-alist) 'tilde))
(set-fringe-bitmap-face 'tilde 'font-lock-function-name-face)
;; == end of default empty line ==

;; default window splitting preferences (max size on my screen is 62*33)
(setq split-height-threshold 33)
(setq split-width-threshold 62)
;; == end of default window splitting ==

;; Emacs 26.2 line-numbers
(setq display-line-numbers-type 'relative)
;; enable only for programming major modes
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
;; enable globally
;;(global-display-line-numbers-mode)
;; == end of line numbers ==

;; replace tabs with spaces
(setq-default indent-tabs-mode nil)
;; == end of no-tabs ==

;; custom keybindings
;; company-mode
(global-set-key (kbd "C-<SPC>" ) 'company-complete)
(global-set-key (kbd "S-<SPC>" ) 'company-yasnippet)
;; ace-window (to move windows around, just use `<M-o> M`)
(global-set-key (kbd "M-o") 'ace-window)
;; yasnippet
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)
;; window management
(global-set-key (kbd "C-S-h") 'shrink-window-horizontally)
(global-set-key (kbd "C-S-j") 'shrink-window)
(global-set-key (kbd "C-S-k") 'enlarge-window)
(global-set-key (kbd "C-S-l") 'enlarge-window-horizontally)
;; == end of custom key-bindings ==

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (tuareg highlight-indentation yasnippet-snippets yasnippet ace-window dashboard page-break-lines magit markdown-mode company haskell-mode evil use-package doom-modeline))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
