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
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
;; == end of MELPA ==

;; use-package first install
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))
;; == end of use-package ==

;; benchmark init
(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))
;; == end of benchmark init ==

;; external libs dir
(add-to-list 'load-path "~/.emacs.d/extlib")
;; == end of external libs ==

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

;; symlink default behaviour
(setq vc-follow-symlinks t)
;; == end of symlink ==

;; erc setup
(setq erc-server "irc.freenode.net")
(setq erc-port 6667)
(setq erc-nick "drdee")
(setq erc-autojoin-channels-alist
      '(("freenode.net"
         "#emacs"
         "#archlinux"
         "#archlinux-proaudio")))
;; == end of erc setup ==

;; Magit git front-end
(use-package magit
  :ensure t
  :config
  (setq magit-refresh-status-buffer nil))
;; == end of Magit ==

;; org-mode
;; org-modules
(require 'org-habit)
(setq org-habit-graph-column 68)
;; custom workflow keywords
(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE")
        (sequence "|" "CANCELED")))
(setq org-todo-keyword-faces
      '(("CANCELED" . "black")
        ("TOLISTEN" . "gold2")
        ("TOMIX" . "gold2")))
;; org-mode agenda files
(setq org-agenda-files '("~/Sync/org-files"))
;; custom agenda view
(setq org-agenda-custom-commands '(
                                   ;; 1° Command
                                   ("d" "Weekly agenda about urgencies" (
                                                                         (tags "@urgent")
                                                                         (agenda "")
                                                                         (tags "@event")
                                                                         ))))
;; org-capture templates
(setq org-capture-templates
      '(
        ;; 1° Entry
        ("r" "Routine di varia natura (TODO + repeating SCHEDULE/DEADLINE/Timestamp)" entry
         (file+headline "~/Sync/org-files/scheduled.org" "Routine")
         "* TODO %? :@routine:\n %^{Timestamp, SCHEDULE or DEADLINE?||SCHEDULE:|DEADLINE:} %^t\n")
        ;; 2° Entry
        ("e" "Eventi di varia importanza (Unset/[#A/B/C] + Timestamp)" entry
         (file+headline "~/Sync/org-files/scheduled.org" "Calendar")
         "* FUTURE %^{_ or [#A/B/C]?||[#A]|[#B]|[#C]} %? :@event:\n %^t\n")
        ;; 3° Entry
        ("p" "Progetti da iniziare a ragionare" entry
         (file "~/Sync/org-files/projects.org")
         "* TODO %? %^{@urgent or @utility?|:@urgent:|:@utility:}\n")
        ;; 5° Entry
        ("s" "Lista della spesa per cibo mancante" entry
         (file "~/Sync/org-files/lista-spesa.org")
         "* TOBUY %?\n")
        ;; 6° Entry
        ("f" "Film da vedere" entry
         (file "~/Sync/org-files/movies.org")
         "* TOWATCH %?\n")
        ;; 7° Entry
        ("l" "Libri da leggere" entry
         (file "~/Sync/org-files/books.org")
         "* TOREAD %?\n")
        ;; 9° Entry
        ("i" "Progetti informatici personali (TODO)" entry
         (file "~/Sync/org-files/compsci.org")
         "* TODO %?\n")
        ;; 10° Entry
        ("m" "Album Musicali da ascoltare" entry
         (file+headline "~/Sync/org-files/music.org" "Albums")
         "* TOBUY %? :@album:\n")
        ;; 11° Entry
        ("M" "Bei pezzi da ricordare" entry
         (file+headline "~/Sync/org-files/music.org" "Mix")
         "* %? :@mix:\n")
        ;; 13° Entry
        ("h" "Passatempo di varia natura" entry
         (file "~/Sync/org-files/hobbies.org")
         "* TODO %? :_editme:\n")
        ;; 14° Entry
        ("c" "File da riordinare/riorganizzare" entry
         (file "~/Sync/org-files/to-capture.org")
         "* TOCAPTURE %?\n")
        ))
;; set org-mode to memorize done time
(setq org-log-done 'time)
(setq org-tags-column 0)
;; use-package for org's appearance
(use-package org-superstar
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))
;; == end of org-mode ==

;; lsp-mode
;; TODO
;; == end of lsp ==

;; EVIL MODE!
(use-package evil
  :ensure t
  :config
  (evil-set-initial-state 'dashboard-mode 'emacs)
  (evil-set-initial-state 'haskell-interactive-mode 'emacs)
  (evil-set-initial-state 'shell-mode 'emacs)
  (evil-set-initial-state 'tuareg-interactive-mode 'emacs)
  (evil-set-initial-state 'inferior-python-mode 'emacs)
  (evil-set-initial-state 'erc-mode 'emacs)
  ;;(evil-set-initial-state 'org-mode 'emacs)
  (evil-mode 1))
;; evil-surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))
;; == end of evil mode ==

;; company-mode autocompletion
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook  'global-company-mode))
;; == end of autocompletion ==

;; snippets expansion via yasnippet
(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))
(use-package yasnippet-snippets
  :ensure t)
;; == end of yasnippet ==

;; syntax checking with flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
;; == end of flycheck ==

;; doom modeline (+ all-the-icons dependency)
(use-package all-the-icons
  :ensure t
  :config
  (unless (file-exists-p "~/.local/share/fonts/all-the-icons.ttf")
    (all-the-icons-install-fonts)))
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 25)
  (column-number-mode 1))
(use-package all-the-icons-dired
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
;; == end of doom modeline ==

;; python mode
;;(use-package anaconda-mode
;;:ensure t)
;;(add-hook 'python-mode-hook 'anaconda-mode)
;;(use-package company-anaconda
;;:ensure t)
;;(eval-after-load "company"
;;'(add-to-list 'company-backends 'company-anaconda))
;; == end of python ==

;; haskell development
;;(use-package haskell-mode
  ;;;;:ensure t)
;;;;(use-package haskell-interactive-mode)
;;(use-package haskell-process)
;;(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;;(add-hook 'haskell-mode-hook 'flyspell-prog-mode)
;;(use-package flycheck-haskell
;;:ensure t
;;:config
;;(add-hook 'haskell-mode-hook #'flycheck-haskell-setup))
;; == end of haskell coding ==

;; OCaml development
;;(use-package tuareg
;;:ensure t)
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;;(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
;; == Note how this package usually takes around 30 or more secs to starts on a cold run as of 13 Mar 2020 ==
;; == end of OCaml coding ==

;; markdown mode
;;(use-package markdown-mode
;;:ensure t
;;:commands (markdown-mode gfm-mode)
;;:mode (("README\\.md\\'" . gfm-mode)
;;("\\.md\\'" . markdown-mode)
;;("\\.markdown\\'" . markdown-mode))
;;:init (setq markdown-command "markdown"))
;; == end of markdown mode ==
;; TODO == Substitute with lsp-mode variant if applicable ==

;; custom splash screen with emacs-dashboard
(use-package page-break-lines
  :ensure t)
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  ;; customization
  (setq dashboard-startup-banner 'official)
  (setq dashboard-center-content nil)
  (setq dashboard-items '((recents  . 9)))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  (setq dashboard-navigator-buttons
        `(;; line1
          ((,(all-the-icons-fileicon "emacs" :height 0.8 :v-adjust 0.0)
            "emacs-workspace"
            "Dired to your Emacs Workspace"
            (lambda (&rest _) (dired "~/emacs-workspace"))))
          ;; line2
          ((,(all-the-icons-alltheicon "git" :height 0.8 :v-adjust 0.0)
            "git-repos"
            "Dired to your Git Repos"
            (lambda (&rest _) (dired "~/.git-repos"))))
          ;; line3
          ((,(all-the-icons-octicon "file-symlink-file" :height 0.8 :v-adjust 0.0)
            "init.el"
            "Open init.el config file"
            (lambda (&rest _) (find-file "~/.emacs.d/init.el"))))
          ;; line4
          ((,(all-the-icons-octicon "book" :height 0.8 :v-adjust 0.0)
            "agenda"
            "Open your agenda"
            (lambda (&rest _) (find-file "~/Sync/org-files/to-capture.org"))))
          ;; line5
          ((,(all-the-icons-octicon "cloud-download" :height 0.8 :v-adjust 0.0)
            "mega"
            "Dired to your Mega Cloud"
            (lambda (&rest _) (dired "~/MEGA"))))
          ;; line6
          ((,(all-the-icons-octicon "home" :height 0.8 :v-adjust 0.0)
            "home"
            "Dired to your Home"
            (lambda (&rest _) (dired "~"))))
          ))
  ;; enable for emacs --daemon
  (setq inhibit-startup-screen t)
  (setq inhibit-splash-screen t)
  (setq inhibit-startup-message t)
  (setq initial-scratch-message "")
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  ;; as of 24 Mar 2020, the dashboard footer variable has no effect
  (setq dashboard-set-footer nil)
  (setq dashboard-banner-logo-title (shell-command-to-string "fortune -as -n 110 | tr -s '\n' ' ' | tr -s '\t' ' '"))
  ;;(setq dashboard-init-info (shell-command-to-string "fortune -as -n 110 | tr -s '\n' ' ' | tr -s '\t' ' '"))
  )
;; == end of custom splash screen ==

;; remove unwanted buffers
;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
;;(setq-default message-log-max nil)
;;(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)
;; == end of unwanted buffers ==

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
;; == end of highlight indent ==

;; electric indent
(electric-indent-mode 1)
;; == end of electric indent ==

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

;; set default font
(add-to-list 'default-frame-alist
             '(font . "Inconsolata-20"))
(defun refresh-mode-line-font ()
  (interactive)
  (let ((faces '(mode-line
                 mode-line-buffer-id
                 mode-line-emphasis
                 mode-line-highlight
                 mode-line-inactive)))
    (mapc
     (lambda (face) (set-face-attribute face nil :font "xos4 Terminus-14:bold"))
     faces)))
;; fallback unicode font
(set-fontset-font "fontset-default" 'unicode "DejaVu Sans Mono-20")
;; == end of default font ==

;; == COLORS AND THEME ==
;; install custom theme (if missing)
(package-install 'zenburn-theme)

;; enable hl line
(global-hl-line-mode 1)

;; == light theme function ==
(defun light-theme ()
  (interactive)
  ;; load new theme
  (disable-theme 'zenburn)
  (load-theme 'adwaita t)
  ;; selected line light color
  (set-face-background 'hl-line "#ccdae9")
  (set-face-foreground 'highlight nil)
  ;; highlight light color
  (set-face-attribute 'region nil :background "#4A90D9" :foreground "#FFFFFF")
  ;; refresh screen
  (refresh-mode-line-font)
  (redraw-display)
  )
;; == end of light theme function ==

;; == dark theme function ==
(defun dark-theme ()
  (interactive)
  ;; load dark theme
  (disable-theme 'adwaita)
  (load-theme 'zenburn t)
  ;; highlight light color
  (set-face-attribute 'region nil :background "#FFFFEF" :foreground "#383838")
  ;; refresh display
  (refresh-mode-line-font)
  (redraw-display)
  )
;; == end of dark theme function ==

;; switches from one theme to the other
(defun switch-theme ()
  (interactive)
  (if (equal (face-attribute 'default :background) "#EDEDED") (dark-theme)
    (light-theme)))

;; set theme as dark if hh >= 19
(if (or (>= (string-to-number (shell-command-to-string "date +%H")) 19)
        (< (string-to-number (shell-command-to-string "date +%H")) 7))
    (dark-theme)
  (light-theme))
;; == END OF COLORS AND THEME ==

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

;; preserve command history between sessions
(savehist-mode 1)
;; == end of command history ==

;; ido mode
(setq ido-separator "\n")
(setq ido-everywhere t)
(ido-mode 1)
;; == end of ido mode ==

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

;; backup files handling
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
;; == end of backups customization ==

;; Horizontal scrolling
(global-set-key (kbd "<mouse-6>") 'scroll-right)
(global-set-key (kbd "<mouse-7>") 'scroll-left)
;; == end of horizontal scrolling ==

;; custom keybindings
;; company-mode
(global-set-key (kbd "C-<SPC>" ) 'company-complete)
(global-set-key (kbd "M-<SPC>" ) 'company-yasnippet)
;; ace-window (to move windows around, just use `<M-o> M`)
(global-set-key (kbd "M-o") 'ace-window)
;; yasnippet
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)
;; window management
;; notice how `s` is the windows key, while `S` is Shift
(global-set-key (kbd "s-h") 'shrink-window-horizontally)
(global-set-key (kbd "s-j") 'shrink-window)
(global-set-key (kbd "s-k") 'enlarge-window)
(global-set-key (kbd "s-l") 'enlarge-window-horizontally)
;; evil-mode
(define-key evil-replace-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-command-window-mode-map (kbd "C-c") 'evil-normal-state)
;; switch theme
(global-set-key (kbd "s-t") 'switch-theme)
;; org-mode
(global-set-key (kbd "C-c c") 'org-capture)
;; == end of custom key-bindings ==
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(use-package zenburn-theme yasnippet-snippets tuareg org-superstar markdown-mode magit highlight-indentation flycheck-haskell evil-surround esup emojify doom-modeline dashboard company-anaconda bind-key benchmark-init all-the-icons-dired ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
