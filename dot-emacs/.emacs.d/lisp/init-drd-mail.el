;;; package --- Summary
;;; Commentary:
;;; Notmuch client for reading mail downloaded with isync (mbsync)
;;; and imported into the notmuch db
;;; Code:

;; https://sourceforge.net/projects/isync/files/latest/download

(use-package notmuch :ensure t
  :defer t
  :config
  ;; Image display
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))
  (define-key notmuch-search-mode-map (kbd "C-+") 'my/notmuch-search-add-address-to-smartfilter))

;; (defvar my/notmuch-smartfilter-folder
;;   (concat my/user-home
;;           ".git-repos"
;;           my/path-separator
;;           "notmuch-smartfilter"
;;           my/path-separator))

;; (defun my/notmuch-smartfilter--append-address-to-tag-file (address file)
;;   (let* ((clean-address
;;           (with-temp-buffer
;;             (insert address)
;;             (goto-char (point-min))
;;             (re-search-forward "^\\(.*<\\)")
;;             (replace-match "")
;;             (goto-char (point-min))
;;             (re-search-forward "\\(>.*\\)$")
;;             (replace-match "")
;;             (buffer-string))))
;;     (with-temp-buffer
;;       (insert-file-contents (concat my/notmuch-smartfilter-folder file))
;;       (goto-char (point-min))
;;       (re-search-forward "\\(addresses=\\)")
;;       (right-char 1)
;;       (insert (concat "\n" clean-address " "))
;;       (write-file (concat my/notmuch-smartfilter-folder file)))
;;     ))

;; (defun my/notmuch-smartfilter-create-new-tag-file (filename tags)
;;   (interactive "sFilename: \nsTags: ")
;;   (with-temp-buffer
;;     (insert (concat "tags=\"" tags "\"\n"))
;;     (insert (concat "addresses=\"\""))
;;     (append-to-file
;;      (point-min) (point-max)
;;      (concat my/notmuch-smartfilter-folder filename))))

;; (defun my/notmuch-search-add-address-to-smartfilter (file)
;;   (interactive
;;    (list (completing-read
;;           "Add to smartfilter tag file: "
;;           (seq-filter (lambda (v) (numberp (string-match-p "\\(\.sft\\)$" v)))
;;                       (directory-files my/notmuch-smartfilter-folder))
;;           nil t "")))
;;   (let* ((thread-id (notmuch-search-find-thread-id))
;;          (address
;;           (with-temp-buffer
;;             (if thread-id
;;                 (progn (notmuch-show thread-id)
;;                        (notmuch-show-get-from))
;;               (message "End of search results.")))))
;;     (kill-buffer (concat "*notmuch-" thread-id "*"))
;;     (my/notmuch-smartfilter--append-address-to-tag-file
;;      address file)))

;; (defun my/notmuch-run-smartfilter ()
;;   (interactive)
;;   (shell-command (concat my/git-repos-directory
;;                          "notmuch-smartfilter"
;;                          my/path-separator
;;                          "notmuch-smartfilter.sh")))

;; (defun my/notmuch-run-smartfilter-full ()
;;   (interactive)
;;   (shell-command (concat my/git-repos-directory
;;                          "notmuch-smartfilter"
;;                          my/path-separator
;;                          "notmuch-smartfilter.sh -f")))


(provide 'init-drd-mail)
;;; init-drd-mail.el ends here
