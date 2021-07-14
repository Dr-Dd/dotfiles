;;; package --- Summary
;;; Commentary:
;;; eshell functions
;;; Code:

(evil-set-initial-state 'eshell-mode 'emacs)

(defun my/beginning-of-line-point ()
  "Return the beginning of line point of the current line."
  (save-excursion
    (let* ((bol-point
            (progn (beginning-of-line)
                   (point))))
      bol-point)))

(defun my/end-of-line-point ()
  "Return the end of line point of the current line."
  (save-excursion
    (let* ((eol-point
            (progn (end-of-line)
                   (point))))
      eol-point)))

(defun my/eshell-buffer-working-dir ()
  "Switch the directory of the buffer named *eshell* to the current working dir
and open eshell in new window."
  (interactive)
  (let ((def-dir default-directory))
    (if (not (eq (get-buffer "*eshell*") nil))
        (progn (switch-to-buffer-other-window "*eshell*")
               (eshell-interrupt-process)
               (insert (concat "cd " def-dir))
               (eshell-send-input)
               (eshell/clear))
      (split-window-below)
      (other-window 1)
      (eshell))))

(define-key global-map (kbd "C-c x") 'eshell-command)
(define-key global-map (kbd "C-c C-x") 'my/eshell-buffer-working-dir)

(provide 'init-eshell)
;;; init-eshell.el ends here
