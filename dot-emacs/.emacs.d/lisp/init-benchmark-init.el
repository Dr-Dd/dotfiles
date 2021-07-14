;;; package --- Summary
;;; Commentary:
;;; Benchmark Emacs' startup
;;; Code:

(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(provide 'init-benchmark-init)
;;; init-benchmark-init.el ends here
