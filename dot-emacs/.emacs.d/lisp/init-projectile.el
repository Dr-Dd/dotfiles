(use-package projectile
  :ensure t
  :config
  (diminish 'projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :bind (:map projectile-mode-map))
(use-package helm-projectile :ensure t
  :config (helm-projectile-on))

(provide 'init-projectile)
