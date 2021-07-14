;;; package --- Summary
;;; Commentary:
;;; Syntax checking with flycheck
;;; Code:

;; syntax checking with flycheck
(use-package flycheck
  :defer t
  :ensure t
  :bind (:map flycheck-mode-map
              ("C-c e j" . flycheck-next-error)
              ("C-c e k" . flycheck-previous-error)
              ("C-c e l" . flycheck-list-errors)))

(provide 'init-flycheck)
;;; init-flycheck.el ends here
