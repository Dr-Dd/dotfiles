;;; package --- Summary
;;; Commentary:
;;;
;;; GNU GLOBAL tags frontend for indexing projects
;;; via GNU Global
;;;
;;; NOTE: GNU Global's selected backend has to be Universal
;;; Ctags, which on arch-linux defaults to the ctags command
;;; (Emacs' version is named ctags.emacs).  That's because it's
;;; a much more compatible version of GNU Global's indexing
;;; mechanisms.
;;;
;;; To set ctags as the backend for gtags, you have to set the
;;; environment variable GTAGSLABEL to the ctags command, i.e.
;;;
;;;     export GTAGSLABEL=ctags
;;;
;;; Also, if you want to use a configuration file, you can
;;; specify it via the GTAGSCONF environment variable:
;;;
;;;     export GTAGSCONF=<path-to-conf>
;;;
;;; or it will default to $HOME/.globalrc and /etc/gtags.conf
;;; in this order.
;;;
;;; Code:

(use-package ggtags :ensure t
  :defer t
  :hook ((emacs-lisp-mode . (lambda () (ggtags-mode 1))))
  :bind (:map ggtags-navigation-map
              ;; M-o is for ace-window
              ("M-o" . nil)))

(provide 'init-ggtags)
;;; init-ggtags.el ends here
