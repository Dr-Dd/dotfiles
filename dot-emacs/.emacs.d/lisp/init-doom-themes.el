;;; package --- Summary
;;; Commentary:
;;; Themes with a better support for melpa package interactions
;;; than the default ones
;;; Code:

(use-package doom-themes
  :defer t
  :ensure t
  :config
  (load-theme 'doom-one t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(provide 'init-doom-themes)
;;; init-doom-themes.el ends here
