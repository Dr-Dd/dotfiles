;;; package --- Summary
;;; Commentary:
;;; Company mode for _in buffer_ completion (not minibuffer like helm)
;;; Code:

;; company-mode autocompletion
(use-package company
  :defer t
  :ensure t
  :init
  (diminish 'company-mode)
  :bind (("C-<SPC>" . company-complete)
         :map company-active-map
         ("C-h" . company-show-doc-buffer)
         ([tab] . company-select-next)
         ([backtab] . company-select-previous)))

(use-package company-c-headers
  :defer t
  :ensure t
  :after (company))

(provide 'init-company-mode)
;;; init-company-mode.el ends here
