;;; package --- Summary
;;; Commentary:
;;; User defined variables and functions
;;; Code:

;; Variable definitions, resolves warnings about
;; "assignment to free variables"
(defvar my/user-home)
(defvar my/user-org-files-directory)
(defvar my/all-the-icons-folder)
(defvar my/emacs-workspace-directory)
(defvar my/git-repos-directory)
(defvar my/backup-directory )
(defvar my/path-separator )

(cond
 ;; GNU/Linux (someone liked to interject for a moment)
 ((string=  system-type "gnu/linux")
  (setq my/user-home "~/"
        my/user-org-files-directory "~/Sync/org-files/"
        my/all-the-icons-folder "~/.local/share/fonts/"
        my/emacs-workspace-directory "~/emacs-workspace/"
        my/git-repos-directory "~/.git-repos/"
        my/backup-directory "~/.saves/"
        my/path-separator "/"))
 ;; Windows 10
 ;; ((string=  system-type "windows-nt")
 ;;  (setq my/user-home ""
 ;;        my/backup-directory ""))
 ;; MacOS
 ;; ((string=  system-type "darwin")
 ;;  (setq my/user-home ""
 ;;        my/backup-directory ""))
)

(provide 'init-my-vars-and-funcs)
;;; init-my-vars-and-funcs.el ends here
