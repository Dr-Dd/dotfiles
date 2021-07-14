;;; package --- Summary
;;; Commentary:
;;; Diminish installation for default packages, needs refactoring
;;; Code:

(use-package diminish
  :defer t
  :ensure t
  :config
  ;; Only for default minor modes, melpa minor modes are to be
  ;; diminished in their use-package declaration
  (diminish 'auto-revert-mode)
  (diminish 'undo-tree-mode)
  (diminish 'eldoc-mode)
  (diminish 'overwrite-mode))

(provide 'init-diminish)
;;; init-diminish.el ends here
