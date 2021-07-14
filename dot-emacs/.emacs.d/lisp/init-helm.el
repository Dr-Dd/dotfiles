;;; package --- Summary
;;; Commentary:
;;; Helm for _minibuffer_ completion (not in-buffer like)
;;; company-mode
;;; Code:

(use-package helm :ensure t
  :defer t
  :preface (require 'helm-config)
  :demand
  :bind (:map global-map
              ([remap find-file] . helm-find-files)
              ([remap occur] . helm-occur)
              ([remap list-buffers] . helm-buffers-list)
              ([remap dabbrev-expand] . helm-dabbrev)
              ([remap execute-extended-command] . helm-M-x)
              ([remap apropos-command] . helm-apropos)
              ([remap switch-to-buffer] . helm-mini)
              :map lisp-interaction-mode-map
              ([remap completion-at-point] . helm-lisp-completion-at-point)
              :map emacs-lisp-mode-map
              ([remap completion-at-point] . helm-lisp-completion-at-point))
  :config
  (diminish 'helm-mode))

(provide 'init-helm)
;;; init-helm.el ends here
