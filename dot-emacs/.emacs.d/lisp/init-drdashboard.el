;;; package --- Summary
;;; Commentary:
;;; Nice introduction page to manage common Emacs usage
;;; Code:

;; custom splash screen with emacs-dashboard
(use-package page-break-lines
  :after (dashboard)
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(provide 'init-drdashboard)
;;; init-drdashboard.el ends here
