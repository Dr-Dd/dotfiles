;;; package --- Summary
;;; Commentary:
;;; LSP client for emacs, just like eglot but with more people
;;; behind it. Has all belts and whistles included (auto-completion
;;; backends, indexing, project detection, etc etc). Everything that
;;; is installed code management wise should be interfaced with it in
;;; some way or another.
;;; Code:

(use-package lsp-mode
  :defer t
  :ensure t
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-peek-enable nil)
  (with-eval-after-load 'lsp-mode
    ;; :project/:workspace/:file
    (setq lsp-modeline-diagnostics-scope :project))
  :bind (:map lsp-mode-map
              ;; ("C-c j" . lsp-find-definition)
              ;; ("C-c r" . lsp-find-references)
              ("C-c n" . lsp-rename)
              ("C-c d" . lsp-describe-thing-at-point)
              ("M-RET" . lsp-execute-code-action)))

;; optionally
;; (use-package lsp-ui :ensure t
;;   :after (lsp-mode)
;;   :commands lsp-ui-mode
;;   :custom-face
;;   (lsp-ui-sideline-code-action ((t (:foreground "goldenrod1"))))
;;   :bind
;;   (:map lsp-ui-mode-map
;;         ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
;;         ([remap xref-find-references] . lsp-ui-peek-find-references))
;;   :config
;;   (setq lsp-ui-doc-enable nil)
;;   (setq lsp-ui-sideline-enable nil)
;;   (setq lsp-ui-peek-enable nil))

;; (with-eval-after-load 'lsp-ui
;;   (setq lsp-ui-doc-enable nil)
;;   (setq lsp-ui-sideline-enable nil))

;;if you are helm user
(use-package helm-lsp :ensure t :commands helm-lsp-workspace-symbol
  :after (helm lsp-mode)
  :bind (:map lsp-mode-map
              ([remap xref-find-apropos] . helm-lsp-workspace-symbol)))

;; optionally if you want to use debugger
;; (use-package dap-mode :ensure t)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
;; (use-package dap-java
;;   :after (dap-mode))

;; C-lang language server (ensure that ccls is installed in your system)
;; (use-package ccls
;;   :ensure t
;;   :hook ((cuda-mode . (lambda () (require 'ccls) (lsp)))))

;; (use-package lsp-java :ensure t )
;;(use-package lsp-java-boot)

;; optional if you want which-key integration
(use-package which-key
  :ensure t
  :config
  (diminish 'which-key-mode))

;; Debugging
;; (setq lsp-print-performance t)


(provide 'init-lsp)
;;; init-lsp.el ends here
