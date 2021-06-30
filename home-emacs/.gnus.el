;; IMAP
(setq gnus-select-method '(nnnil ""))
(setq gnus-secondary-select-methods
      '((nnimap "idone.leonardo@gmail.com"
                (nnimap-address "imap.gmail.com")
                (nnimap-server-port "imaps")
                (nnimap-stream ssl)
                (nnir-search-engine imap))
        (nnimap "abubu55@gmail.com"
                (nnimap-address "imap.gmail.com")
                (nnimap-server-port "imaps")
                (nnimap-stream ssl)
                (nnir-search-engine imap))
        (nnimap "leo.idone@stud.uniroma3.it"
                (nnimap-address "outlook.office365.com")
                (nnimap-server-port "imaps")
                (nnimap-stream ssl)
                (nnir-search-engine imap))))

;; SMTP
(setq gnus-posting-styles
      '((".*"
         (address "Leonardo Idone <idone.leonardo@gmail.com>")
         ("X-Message-SMTP-Method" "smtp smtp.gmail.com 587 idone.leonardo@gmail.com"))
        ("idone.leonardo@gmail.com"
         (address "Leonardo Idone <idone.leonardo@gmail.com>")
         ("X-Message-SMTP-Method" "smtp smtp.gmail.com 587 idone.leonardo@gmail.com"))
        ("abubu55@gmail.com"
         (address "abubu55 <abubu55@gmail.com>")
         ("X-Message-SMTP-Method" "smtp smtp.gmail.com 587 abubu55@gmail.com"))
        ("leo.idone@stud.uniroma3.it"
         (address "Leonardo Idone <leo.idone@stud.uniroma3.it>")
         ("X-Message-SMTP-Method" "smtp smtp.office365.com 587 leo.idone@stud.uniroma3.it"))
        ))

;; GUI
(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  (setq gnus-sum-thread-tree-root "") ;; "● ")
  (setq gnus-sum-thread-tree-false-root "") ;; "◯ ")
  (setq gnus-sum-thread-tree-single-indent "") ;; "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))
(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"
       "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"               ;; name
       "  "
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))
(setq gnus-summary-display-arrow t)

(setq gnus-use-cache t)

(setq gnus-thread-sort-functions '(gnus-thread-sort-by-most-recent-date))

;; (defun my/gnus-scan-important-mail () (gnus-group-get-new-news 1 nil))
;; (gnus-demon-init)
;; (gnus-demon-add-handler 'my/gnus-scan-important-mail 1 nil)
