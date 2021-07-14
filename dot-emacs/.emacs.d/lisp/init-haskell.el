;;; package --- Summary
;;; Commentary:
;;; Haskell environment
;;; Code:

(use-package haskell-mode
  :ensure t
  :defer t
  :config
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode))

(provide 'init-haskell)
;;; init-haskell.el ends here
