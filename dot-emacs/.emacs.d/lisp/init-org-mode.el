;;; package --- Summary
;;; Commentary:
;;; All settings related to org-mode
;;; Code:

(use-package org
  :defer t
  :config
  (defun my/org-get-entry-time (pom &optional inherit)
    "Get the time as a time tuple, if there is none
returns nil."
    (let
        ((time (or (org-entry-get pom "TIMESTAMP" inherit)
                   (org-entry-get pom "SCHEDULED" inherit)
                   (org-entry-get pom "DEADLINE" inherit))))
      (when time
        (org-time-string-to-time time)))))

(use-package org-habit
  :after (org)
  :defer t)

(use-package org-superstar
  :after (org)
  :ensure t
  :defer t)

;; active Babel languages
(use-package org-babel
  :defer t
  :after (org)
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((C . t)
     (ledger . t)
     (shell . t)
     (emacs-lisp . nil))))

(use-package htmlize
  :after (org)
  :defer t
  :ensure t)

(use-package org-capture
  :config (global-set-key (kbd "C-c c") 'org-capture))


(use-package org-edna :ensure t
  :defer t
  :after (org))

(use-package ox-latex
  :after (org)
  :defer t)

(use-package ox-beamer
  :after (org)
  :defer t)

(provide 'init-org-mode)
;;; init-org-mode.el ends here
