;;; package --- Summary
;;; Commentary:
;;; C and C++ environment
;;; Code:

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(with-eval-after-load 'lsp-mode
  (require 'dap-cpptools))

(provide 'init-c-cpp)
;;; init-c-cpp.el ends here
