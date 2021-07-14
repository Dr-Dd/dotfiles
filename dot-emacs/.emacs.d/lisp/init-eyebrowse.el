;;; package --- Summary
;;; Commentary:
;;; Eyebrowse for Emacs workspaces
;;; Code:

(use-package eyebrowse :ensure t
  :defer t
  :bind (:map evil-motion-state-map
              ("g c" . nil))
  :config
  (eyebrowse-setup-opinionated-keys))

(provide 'init-eyebrowse)
;;; init-eyebrowse.el ends here
