;;; package --- Summary
;;; Commentary:
;;; Mantain aggressively indented source code
;;; Code:

(use-package aggressive-indent
  :defer t
  :ensure t
  :config
  (defun disable-aggressive-indent ()
    (interactive)
    (aggressive-indent-mode -1))
  (add-hook 'evil-insert-state-entry-hook 'aggressive-indent-mode)
  (add-hook 'evil-insert-state-exit-hook 'disable-aggressive-indent))

(provide 'init-aggressive-indent)
;;; init-aggressive-indent.el ends here
