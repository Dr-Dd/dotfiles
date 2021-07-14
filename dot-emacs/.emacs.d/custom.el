;;; package --- Summary
;;; Commentary:
;;; Custom "custom.el" file
;;; Code:

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:family "xos4 Terminus" :height 0.7 :box nil :weight bold))))
 '(mode-line-inactive ((t (:family "xos4 Terminus" :height 0.7 :box nil :weight bold))))
 '(org-level-1 ((t (:inherit default :foreground "#cb4b16" :height unspecified))))
 '(org-level-2 ((t (:inherit default :foreground "#859900" :height unspecified))))
 '(org-level-3 ((t (:inherit default :foreground "#268bd2" :height unspecified))))
 '(org-level-4 ((t (:inherit default :foreground "#b58900" :height unspecified)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "~/.saves/" t)))
 '(aw-display-mode-overlay nil)
 '(backup-by-copying t)
 '(backup-directory-alist '((".*" . "~/.saves/")))
 '(beacon-color "chartreuse")
 '(beacon-mode t)
 '(before-save-hook '(delete-trailing-whitespace))
 '(blink-cursor-mode t)
 '(column-number-mode t)
 '(company-backends
   '(company-c-headers company-bbdb company-semantic company-cmake company-capf company-clang company-files
                       (company-dabbrev-code company-gtags company-etags company-keywords)
                       company-oddmuse company-dabbrev))
 '(company-frontends
   '(company-pseudo-tooltip-unless-just-one-frontend company-echo-metadata-frontend company-preview-if-just-one-frontend))
 '(company-idle-delay nil)
 '(dashboard-banner-logo-title
   (shell-command-to-string "fortune -as -n 110 | tr -s '
' ' ' | tr -s '	' ' '"))
 '(dashboard-buffer-last-width 80)
 '(dashboard-footer "Who the hell uses VIM anyway? Go Evil!")
 '(dashboard-init-info t)
 '(dashboard-items '((recents . 9)))
 '(dashboard-navigator-buttons
   '(((#("💰" 0 1
         (rear-nonsticky t display
                         (raise 0.0)
                         font-lock-face
                         (:family "github-octicons" :height 0.96)
                         face
                         (:family "github-octicons" :height 0.96)))
       "ledger-cli" "Open your ledger folder"
       (lambda
         (&rest _)
         (dired
          (concat my/user-home "Sync" my/path-separator "ledger.git"))))
      (#("" 0 1
         (rear-nonsticky t display
                         (raise 0.0)
                         font-lock-face
                         (:family "file-icons" :height 0.96 :foreground "#6146A1")
                         face
                         (:family "file-icons" :height 0.96 :foreground "#6146A1")))
       "init.el" "Open init.el config file"
       (lambda
         (&rest _)
         (find-file
          (concat user-emacs-directory "init.el"))))
      (#("📔" 0 1
         (rear-nonsticky t display
                         (raise 0.0)
                         font-lock-face
                         (:family "github-octicons" :height 0.96)
                         face
                         (:family "github-octicons" :height 0.96)))
       "agenda" "Open your agenda"
       (lambda
         (&rest _)
         (org-agenda 0 "d")))
      (#("📫" 0 1
         (rear-nonsticky t display
                         (raise 0.0)
                         font-lock-face
                         (:family "github-octicons" :height 0.96)
                         face
                         (:family "github-octicons" :height 0.96)))
       "notmuch" "Read your inbox"
       (lambda
         (&rest _)
         (notmuch)))
      (#("📡" 0 1
         (rear-nonsticky t display
                         (raise 0.0)
                         font-lock-face
                         (:family "all-the-icons" :height 0.96)
                         face
                         (:family "all-the-icons" :height 0.96)))
       "elfeed" "Read the news"
       (lambda
         (&rest _)
         (elfeed)))
      (#("🖥" 0 1
         (rear-nonsticky t display
                         (raise 0.0)
                         font-lock-face
                         (:family "github-octicons" :height 0.96)
                         face
                         (:family "github-octicons" :height 0.96)))
       "ERC" "Connect to your irc network"
       (lambda
         (&rest _)
         (my/erc-start-default))))))
 '(dashboard-set-file-icons t)
 '(dashboard-set-footer nil)
 '(dashboard-set-init-info nil)
 '(dashboard-set-navigator t)
 '(default-frame-alist '((fullscreen . maximized) (font . "Hack-18")))
 '(delete-old-versions t)
 '(display-line-numbers-type 'relative)
 '(doom-modeline-height 21)
 '(doom-modeline-icon t)
 '(doom-modeline-mode t)
 '(electric-indent-mode t)
 '(electric-pair-mode t)
 '(elfeed-feeds
   '(("https://www.rfc-editor.org/rfcrss.xml" rfc cs)
     ("https://www.kernel.org/feeds/all.atom.xml" linux cs)
     ("https://www.kernel.org/feeds/kdist.xml" linux cs)
     ("https://www.reddit.com/r/linux/rising/.rss" cs reddit)
     ("https://www.reddit.com/r/emacs/rising/.rss" cs reddit)
     ("https://lwn.net/headlines/rss" cs blog linux)
     ("https://www.phoronix.com/rss.php" cs blog)
     ("https://hackaday.com/blog/feed/" cs blog)
     ("https://www.darkreading.com/rss_simple.asp" cs blog)
     ("https://feeds.feedburner.com/TheHackersNews" cs blog)
     ("https://lobste.rs/rss" cs aggregator)
     ("https://hnrss.org/frontpage" cs aggregator)
     ("https://gizmodo.com/rss" tech)
     ("http://rss.slashdot.org/Slashdot/slashdotMain" tech)
     ("https://www.engadget.com/rss.xml" tech)
     ("https://feeds.feedburner.com/GamasutraNews/" games blog)
     ("https://www.wired.com/feed/rss" tech)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=TheEconomist&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=nytimes&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=AJWasahi&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=BBCBreaking&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=guardian&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=AJENews&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=washingtonpost&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=nytimes&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=Reuters&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=fattoquotidiano&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news italy twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=sole24ore&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news italy twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=Agenzia_Ansa&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news italy twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=Agenzia_Italia&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news italy twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=Corriere&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom" news italy twitter)
     ("https://boards.4channel.org/g/index.rss" 4chan)
     ("http://superbestfriendcast.libsyn.com/rss" podcast)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCKJtYrlWaF3G0LIneEKoPew" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCKTehwyGCKF-b2wo0RKwrcg" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC0M0rxSz3IF0CsSour1iWmw" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC21uZkfXpT8rPY-gPgMiCwA" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2Qw1dzXDBAZPwS7zm37g8g" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC9-y-6csu5WGm29I7JiwpnA" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCYZtp0YIxYOipX15v_h_jnA" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCsD9nSAjE6uq1EPYlCORS9w" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCL6JmiMXKoXS6bpP1D3bk8g" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCNSMdQtn1SuFzCZjfK2C7dQ" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCbWcXB0PoqOsAvAdfzWMf0w" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCR1D15p_vdP3HkrH8wgjQRw" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCyhnYIvIKK_--PiJXCMKxQQ" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UClcE-kVhqyiHCcjYwcpfj9w" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UClOGLGPOqlAiLmOvXW5lKbw" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCiP_FwGyJQ_6P8k5ON5mncQ" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCb_sF2m3-2azOqeNEdMwQPw" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCSdma21fnJzgmPodhC9SJ3g" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC4eYXhJI4-7wSWc8UNRwD4A" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCo1pShh6dtg-T_ZZkgi_JDQ" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCD6VugMZKRhSyzWEWA9W2fg" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCWqr2tH3dPshNhPjV5h1xRw" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCtGoikgbxP4F3rgI9PldI9g" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCt7fwAhXDy3oNFTAzF2o8Pw" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCBa659QWEk1AI4Tg--mrJ2A" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCllm3HivMERwu2x2Sjz5EIg" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCsvn_Po0SmunchJYOWpOxMg" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCzORJV8l3FWY4cFO8ot-F2w" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCIPsK5xspHC3-ZFNPTx2X_w" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCdJdEguB1F1CiYe7OEi3SBg" youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCWqr2tH3dPshNhPjV5h1xRw" youtube)))
 '(elfeed-search-title-max-width 130)
 '(erc-fill-mode t)
 '(erc-fill-prefix "    ")
 '(erc-hide-list '("JOIN" "PART" "QUIT"))
 '(erc-rename-buffers t)
 '(eshell-scroll-to-bottom-on-input 'all)
 '(evil-commentary-mode t)
 '(evil-emacs-state-modes
   '(erc-mode help-mode xref--xref-buffer-mode inferior-python-mode tuareg-interactive-mode shell-mode haskell-interactive-mode dashboard-mode 5x5-mode archive-mode bbdb-mode biblio-selection-mode blackbox-mode bookmark-bmenu-mode bookmark-edit-annotation-mode browse-kill-ring-mode bs-mode bubbles-mode bzr-annotate-mode calc-mode cfw:calendar-mode completion-list-mode Custom-mode custom-theme-choose-mode debugger-mode delicious-search-mode desktop-menu-blist-mode desktop-menu-mode doc-view-mode dun-mode dvc-bookmarks-mode dvc-diff-mode dvc-info-buffer-mode dvc-log-buffer-mode dvc-revlist-mode dvc-revlog-mode dvc-status-mode dvc-tips-mode ediff-mode ediff-meta-mode efs-mode Electric-buffer-menu-mode emms-browser-mode emms-mark-mode emms-metaplaylist-mode emms-playlist-mode ess-help-mode etags-select-mode fj-mode gc-issues-mode gdb-breakpoints-mode gdb-disassembly-mode gdb-frames-mode gdb-locals-mode gdb-memory-mode gdb-registers-mode gdb-threads-mode gist-list-mode git-rebase-mode gnus-article-mode gnus-browse-mode gnus-group-mode gnus-server-mode gnus-summary-mode gomoku-mode google-maps-static-mode ibuffer-mode jde-javadoc-checker-report-mode magit-cherry-mode magit-diff-mode magit-log-mode magit-log-select-mode magit-popup-mode magit-popup-sequence-mode magit-process-mode magit-reflog-mode magit-refs-mode magit-revision-mode magit-stash-mode magit-stashes-mode magit-status-mode mh-folder-mode monky-mode mpuz-mode mu4e-main-mode mu4e-headers-mode mu4e-view-mode notmuch-hello-mode notmuch-search-mode notmuch-show-mode notmuch-tree-mode occur-mode org-agenda-mode package-menu-mode pdf-outline-buffer-mode pdf-view-mode proced-mode rcirc-mode rebase-mode recentf-dialog-mode reftex-select-bib-mode reftex-select-label-mode reftex-toc-mode sldb-mode slime-inspector-mode slime-thread-control-mode slime-xref-mode snake-mode solitaire-mode sr-buttons-mode sr-mode sr-tree-mode sr-virtual-mode tar-mode tetris-mode tla-annotate-mode tla-archive-list-mode tla-bconfig-mode tla-bookmarks-mode tla-branch-list-mode tla-browse-mode tla-category-list-mode tla-changelog-mode tla-follow-symlinks-mode tla-inventory-file-mode tla-inventory-mode tla-lint-mode tla-logs-mode tla-revision-list-mode tla-revlog-mode tla-tree-lint-mode tla-version-list-mode twittering-mode urlview-mode vc-annotate-mode vc-dir-mode vc-git-log-view-mode vc-hg-log-view-mode vc-svn-log-view-mode vm-mode vm-summary-mode w3m-mode wab-compilation-mode xgit-annotate-mode xgit-changelog-mode xgit-diff-mode xgit-revlog-mode xhg-annotate-mode xhg-log-mode xhg-mode xhg-mq-mode xhg-mq-sub-mode xhg-status-extra-mode inferior-emacs-lisp-mode timer-list-mode flycheck-error-list-mode special-mode elfeed-search-mode elfeed-show-mode))
 '(evil-ex-search-case 'insensitive)
 '(evil-mode t)
 '(evil-undo-system 'undo-tree)
 '(eyebrowse-mode t)
 '(flycheck-emacs-lisp-load-path 'inherit)
 '(gc-cons-threshold 100000000)
 '(global-aggressive-indent-mode t)
 '(global-company-mode t)
 '(global-evil-surround-mode t)
 '(global-flycheck-mode t)
 '(global-hl-line-mode t)
 '(global-undo-tree-mode t)
 '(helm-boring-buffer-regexp-list
   '("\\` " "\\`\\*helm" "\\`\\*Echo Area" "\\`\\*Minibuf" "\\`\\#.*" "\\`\\*status" "\\`\\Libera.Chat"))
 '(helm-mode t)
 '(history-delete-duplicates t)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice '(lambda nil (get-buffer-create "*dashboard*")))
 '(initial-scratch-message nil)
 '(kept-new-versions 6)
 '(load-prefer-newer t)
 '(lsp-completion-provider :capf)
 '(lsp-managed-mode-hook '(lsp-diagnostics-modeline-mode))
 '(lsp-mode-hook '(lsp-enable-which-key-integration))
 '(magit-refresh-status-buffer nil)
 '(mail-envelope-from 'header)
 '(mail-specify-envelope-from t)
 '(menu-bar-mode nil)
 '(message-kill-buffer-on-exit t)
 '(message-sendmail-envelope-from 'header)
 '(midnight-mode t)
 '(notmuch-saved-searches
   '((:name "new mail" :query "tag:inbox and tag:unread" :key "n" :sort-order newest-first)
     (:name "inbox" :query "tag:inbox" :key "i" :sort-order newest-first)
     (:name "unread" :query "tag:unread" :key "u")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "d")
     (:name "all mail" :query "*" :key "a")))
 '(notmuch-search-oldest-first nil)
 '(org-agenda-custom-commands
   '(("d" "Weekly agenda about urgencies"
      ((tags "@urgent"
             ((org-agenda-sorting-strategy
               '(timestamp-up))
              (org-agenda-overriding-header "Urgenze da portare a termine")))
       (tags "+@event+TIMESTAMP<=\"<+6m>\""
             ((org-agenda-sorting-strategy
               '(timestamp-up))
              (org-agenda-overriding-header "Eventi futuri")))
       (agenda ""
               ((org-agenda-start-on-weekday nil)
                (org-agenda-show-all-dates nil)))
       (tags "@birthday+TIMESTAMP>=\"<today>\""
             ((org-agenda-sorting-strategy
               '(timestamp-up))
              (org-agenda-overriding-header "Compleanni futuri")
              (org-agenda-max-entries 6))))
      ((org-agenda-compact-blocks t)))))
 '(org-agenda-dim-blocked-tasks 'invisible)
 '(org-agenda-files '("~/Sync/org-files/"))
 '(org-agenda-finalize-hook
   '((lambda nil
       (progn
         (highlight-regexp "<[A-z]* [0-9]*>" 'org-date)
         (highlight-regexp "Urgenze\\|Eventi\\|Compleanni" 'org-warning)))))
 '(org-agenda-prefix-format
   '((tags . " %-9(let ((timestamp (my/org-get-entry-time (point)))) (if timestamp (format-time-string \"<%b %d>\" timestamp) \"\"))")))
 '(org-agenda-show-future-repeats 'next)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-window-setup 'current-window)
 '(org-capture-templates
   '(("r" "Routine di varia natura (TODO + repeating SCHEDULE/DEADLINE/Timestamp)" entry
      (file+headline "~/Sync/org-files/scheduled.org" "Routine")
      "* TODO %? :@routine:
 %^{Timestamp, SCHEDULED or DEADLINE?||SCHEDULED:|DEADLINE:} %^t
")
     ("e" "Eventi di varia importanza (Unset/[#A/B/C] + Timestamp)" entry
      (file+headline "~/Sync/org-files/scheduled.org" "Calendar")
      "* FUTURE %^{_ or [#A/B/C]?||[#A]|[#B]|[#C]} %? :@event:
 %^t
")
     ("p" "Progetti da iniziare a ragionare" entry
      (file "~/Sync/org-files/projects.org")
      "* TODO %? %^{@urgent or @utility?|:@urgent:|:@utility:}
")
     ("s" "Lista della spesa per cibo mancante" entry
      (file "~/Sync/org-files/lista-spesa.org")
      "* TOBUY %?
")
     ("f" "Film da vedere" entry
      (file "~/Sync/org-files/movies.org")
      "* TOWATCH %?
")
     ("l" "Libri da leggere" entry
      (file "~/Sync/org-files/books.org")
      "* TOBUY %?
")
     ("i" "Progetti informatici personali (TODO)" entry
      (file "~/Sync/org-files/compsci.org")
      "* TODO %?
")
     ("m" "Album Musicali da ascoltare" entry
      (file+headline "~/Sync/org-files/music.org" "Albums")
      "* TOBUY %? :@album:
")
     ("M" "Bei pezzi da ricordare" entry
      (file+headline "~/Sync/org-files/music.org" "Mix")
      "* %? :@mix:
")
     ("h" "Passatempo di varia natura" entry
      (file "~/Sync/org-files/hobbies.org")
      "* TODO %? :_editme:
")
     ("c" "File da riordinare/riorganizzare" entry
      (file "~/Sync/org-files/to-capture.org")
      "* TOCAPTURE %?
")
     ("b" "Aggiungi la data di compleanno di qualcuno che ti è caro" entry
      (file+headline "~/Sync/org-files/scheduled.org" "Birthdays")
      "* TOWISH Compleanno %? :@birthday:
 %^t
")
     ("q" "Un nuovo progetto per la tua Bucket List" entry
      (file "~/Sync/org-files/bucket.org")
      "* TODO %?
")))
 '(org-deadline-warning-days 7)
 '(org-edit-src-content-indentation 0)
 '(org-edna-mode t)
 '(org-enforce-todo-dependencies t)
 '(org-habit-graph-column 68)
 '(org-habit-show-habits-only-for-today nil)
 '(org-latex-classes
   '(("beamer" "\\documentclass[presentation]{beamer}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("article" "\\documentclass[11pt]{article}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("report" "\\documentclass[11pt]{report}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("book" "\\documentclass[11pt]{book}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
 '(org-log-done 'time)
 '(org-mode-hook '((lambda nil (org-superstar-mode 1)) turn-on-auto-fill))
 '(org-tags-column 0)
 '(org-todo-keyword-faces
   '(("CANCELED" . "black")
     ("TOLISTEN" . "gold2")
     ("TOREAD" . "gold2")
     ("TOMIX" . "gold2")))
 '(org-todo-keywords '((sequence "TODO" "|" "DONE") (sequence "|" "CANCELED")))
 '(package-selected-packages
   '(erc-hl-nicks znc magit ledger-mode aggressive-indent aggressive-indent-mode benchmark-init eyebrowse initsplit elfeed beacon bic helm-projectile org-ref which-key use-package undo-tree origami org-superstar org-edna lsp-java htmlize highligh t-indentation helm-lsp flycheck evil-surround evil-commentary doom-themes doom-modeline diminish dashboard company-quickhelp company-c-headers))
 '(prog-mode-hook
   '(display-line-numbers-mode highlight-indentation-current-column-mode))
 '(projectile-mode t nil (projectile))
 '(projectile-tags-command "gtags")
 '(recentf-exclude
   '("/home/drd/.emacs.d/.cache/treemacs-persist-at-last-error" "/home/drd/.emacs.d/.cache/treemacs-persist" "/usr/share/emacs" "/home/drd/.elfeed"))
 '(require-final-newline t)
 '(save-place-mode t)
 '(savehist-mode t)
 '(scroll-bar-mode nil)
 '(send-mail-function 'sendmail-send-it)
 '(server-after-make-frame-hook
   '((lambda nil
       (select-frame-set-input-focus
        (selected-frame)))
     doom-modeline-refresh-font-width-cache) t)
 '(show-paren-mode t)
 '(split-height-threshold 33)
 '(split-width-threshold 62)
 '(text-mode-hook '(flyspell-mode text-mode-hook-identify))
 '(tool-bar-mode nil)
 '(vc-follow-symlinks t)
 '(version-control t)
 '(warning-suppress-types '((lsp-mode) (comp) (:warning)))
 '(which-key-mode t)
 '(x-gtk-use-system-tooltips nil)
 '(xref-prompt-for-identifier
   '(not xref-find-definitions xref-find-definitions-other-window xref-find-definitions-other-frame xref-find-references)))

;;; custom.el ends here
