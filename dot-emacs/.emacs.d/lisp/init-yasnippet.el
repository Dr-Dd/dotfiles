;;; package --- Summary
;;; Commentary:
;;; snippets expansion via yasnippet
;;; Code:

(use-package yasnippet
  :defer t
  :ensure t
  :diminish yas-minor-mode
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(use-package yasnippet-snippets
  :defer t
  :ensure t
  :after (yasnippet)
  :config
  (yas-reload-all)
  (diminish 'yas-minor-mode)
  :bind (:map yas-minor-mode-map
              ([tab] . nil)
              ("M-p" . yas-expand)
              ("M-i" . yas-insert-snippet)))

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
