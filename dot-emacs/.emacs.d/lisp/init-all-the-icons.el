;;; package --- Summary
;;; Commentary:
;;; all-the-icons package being a dependency for multiple other packages
;;; Code:

(use-package all-the-icons
  :defer t
  :ensure t
  :config
  (unless (file-exists-p (concat my/all-the-icons-folder "all-the-icons.ttf"))
    (all-the-icons-install-fonts)))

(provide 'init-all-the-icons)
;;; init-all-the-icons.el ends here
