
;; Magit git front-end
(use-package magit
  :defer t
  :ensure t
  :bind(("C-c g" . magit-status)))

(provide 'init-magit)
