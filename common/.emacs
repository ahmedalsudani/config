(package-initialize)
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository

;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Smex is ido
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-undo-tree-mode)

;; Start server if not running in terminal
;; from http://unix.stackexchange.com/a/9154/47432
(and window-system (server-start))

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'racket-mode-hook
          '(lambda ()
             (define-key racket-mode-map (kbd "C-r") 'racket-run)
             (enable-paredit-mode)
             (auto-complete-mode)))
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(show-paren-mode t)
(setq-default indicate-empty-lines t)
(setq c-default-style "linux"
      c-basic-offset 8)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-basic-offset 2)
 '(package-selected-packages
   (quote
    (helm-gtags helm ggtags diff-hl idle-highlight-mode paredit ido-ubiquitous smex zencoding-mode undo-tree starter-kit seq rainbow-mode racket-mode pkg-info let-alist js2-mode haskell-mode flymake-jshint find-file-in-repository auto-complete auctex)))
 '(sh-indent-after-do (quote +)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-external-variable ((t (:foreground "orange red"))))
 '(js2-warning ((t nil))))

;; from http://stackoverflow.com/questions/19907939/how-can-one-quickly-browse-through-lots-of-files-in-emacs/19933337#19933337
;; little modification to dired-mode that let's you browse through lots of files
(add-hook 'dired-mode-hook
  (lambda()
    (define-key dired-mode-map (kbd "C-o") 'dired-view-current)     ; was dired-display-file
    (define-key dired-mode-map (kbd "n")   'dired-view-next)           ; was dired-next-line
    (define-key dired-mode-map (kbd "p")   'dired-view-previous))) ; was dired-previous-line

(defun dired-view-next ()
  "Move down one line and view the current file in another window."
  (interactive)
  (dired-next-line)
  (dired-view-current))

(defun dired-view-previous (&rest r)
  "Move up one line and view the current file in another window."
  (interactive)
  (dired-previous-line)
  (dired-view-current))

(defun dired-view-current ()
  "View the current file in another window (possibly newly created)."
  (interactive)
  (if (not (window-parent))
      (split-window))                                   ; create a new window if necessary
  (let ((file (dired-get-file-for-visit))
        (dbuffer (current-buffer)))
    (other-window 1)                                          ; switch to the other window
    (unless (equal dbuffer (current-buffer))                 ; don't kill the dired buffer
      (if (or view-mode (equal major-mode 'dired-mode))   ; only if in view- or dired-mode
          (kill-buffer)))                                                    ; ... kill it
    (let ((filebuffer (get-file-buffer file)))
      (if filebuffer                              ; does a buffer already look at the file
          (switch-to-buffer filebuffer)                                    ; simply switch
        (view-file file))                                                    ; ... view it
      (other-window -1))))                   ; give the attention back to the dired buffer

;; I copied this without looking at what it does

;; (setq
;;  helm-gtags-ignore-case t
;;  helm-gtags-auto-update t
;;  helm-gtags-use-input-at-cursor t
;;  helm-gtags-pulse-at-cursor t
;;  helm-gtags-prefix-key "\C-cg"
;;  helm-gtags-suggested-key-mapping t
;;  )

;; (require 'helm-gtags)
;; ;; Enable helm-gtags-mode
;; (add-hook 'dired-mode-hook 'helm-gtags-mode)
;; (add-hook 'eshell-mode-hook 'helm-gtags-mode)
;; (add-hook 'c-mode-hook 'helm-gtags-mode)
;; (add-hook 'c++-mode-hook 'helm-gtags-mode)
;; (add-hook 'asm-mode-hook 'helm-gtags-mode)

;; (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
;; (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
;; (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
;; (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
;; (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
;; (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))
