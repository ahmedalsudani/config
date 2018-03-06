(package-initialize)
(require 'package)

;; loads caddr
(require 'cl)


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
(setq tramp-default-method "ssh")
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(set-face-attribute 'default nil :height 120)
(fset 'yes-or-no-p 'y-or-n-p)
(define-coding-system-alias 'UTF-8 'utf-8)


(global-set-key (kbd "C-x k") 'kill-this-buffer)
;; TODO find a good way to trigger completion
;(global-set-key "\t" 'company-complete)

; Store backups in their own directory instead of littering the
; whole filesystem with goddamn ~ files.
(setq
   backup-by-copying t ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs_backups")) ; don't litter my fs tree
   version-control t ; use versioned numbers for backup files
   kept-new-versions 6 ; number of newest versions to keep
   kept-old-versions 2 ; number of oldest versions to keep
   delete-old-versions t) ; delete excess backup versions silently

; Reconfigure whitespace-mode for day-to-day use
(require 'whitespace)
(setq whitespace-style '(face tabs space-before-tab tab-mark))
(global-whitespace-mode t)

;; Smex is ido
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)
;; Goddamn ido-find-file
(setq ido-auto-merge-work-directories-length -1)

(global-undo-tree-mode)

;; Start server if not running in terminal
;; from http://unix.stackexchange.com/a/9154/47432
(and window-system (server-start))

(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(autoload 'js2-mode "js2-mode" nil t)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook       #'enable-paredit-mode)
(add-hook 'python-mode-hook           #'electric-pair-mode)
(add-hook 'markdown-mode-hook         #'turn-on-auto-fill)
(add-hook 'racket-mode-hook
          '(lambda ()
             (define-key racket-mode-map (kbd "C-r") 'racket-run)
             (enable-paredit-mode)
             (auto-complete-mode)))
(add-hook 'c++-mode-hook
          '(lambda ()
             (set (make-local-variable 'company-backends)
                  '(company-clang company-gtags))))
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'weechat-mode-hook '(lambda ()
                                (evil-emacs-state)
                                (emojify-mode)))



(show-paren-mode t)
(setq column-number-mode t)
(setq-default indicate-empty-lines t)
(setq-default c-default-style "linux"
              c-basic-offset 4
              indent-tabs-mode nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-external-variable ((t (:foreground "orange red"))))
 '(js2-warning ((t nil))))

;; from http://stackoverflow.com/questions/19907939/how-can-one-quickly-browse-through-lots-of-files-in-emacs/19933337#19933337
;; little modification to dired-mode that lets you browse through lots of files
(add-hook 'dired-mode-hook
  (lambda()
    ;(define-key dired-mode-map (kbd "C-o") 'dired-find-file-other-window)     ; was dired-display-file
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

(setq python-shell-interpreter "ipython"
       python-shell-interpreter-args "--simple-prompt -i")

(define-derived-mode cheetah-mode html-mode "Cheetah"
  (make-face 'cheetah-variable-face)
  (font-lock-add-keywords
   nil
   '(
     ("\\(#\\(from\\|else\\|include\\|extends\\|set\\|def\\|import\\|for\\|if\\|end\\)+\\)\\>" 1 font-lock-type-face)
     ("\\(#\\(from\\|for\\|end\\)\\).*\\<\\(for\\|import\\|def\\|if\\|in\\)\\>" 3 font-lock-type-face)
     ("\\(##.*\\)\n" 1 font-lock-comment-face)
     ("\\(\\$\\(?:\\sw\\|}\\|{\\|\\s_\\)+\\)" 1 font-lock-variable-name-face))
   )
  (font-lock-mode 1)
  )

(setq auto-mode-alist (cons '( "\\.tmpl\\'" . cheetah-mode ) auto-mode-alist ))

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (merlin company-ghc tuareg typescript-mode haskell-mode racket-mode rust-mode go-mode web-mode neotree smartscan emojify weechat evil-surround elpy cider js2-mode lua-mode company evil markdown-mode use-package undo-tree smex paredit idle-highlight-mode helm-gtags ggtags diff-hl auto-complete auctex))))

(require 'evil)
(evil-mode 1)
(global-evil-surround-mode)

;; @see https://bitbucket.org/lyro/evil/issue/511/let-certain-minor-modes-key-bindings
(eval-after-load 'ggtags
  '(progn
     (evil-make-overriding-map ggtags-mode-map 'normal)
     ;; force update evil keymaps after ggtags-mode loaded
     (add-hook 'ggtags-mode-hook #'evil-normalize-keymaps)))

(eval-after-load 'elpy
  '(progn
     (evil-make-overriding-map elpy-mode-map 'normal)
     ;; force update evil keymaps after elpy-mode loaded
     (add-hook 'elpy-mode-hook #'evil-normalize-keymaps)))

(with-eval-after-load 'evil
  (add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode))

;; This automatically registers a python-mode hook
(elpy-enable)

(setq browse-url-browser-function 'browse-url-chromium)

(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-h") 'windmove-left)
(global-set-key (kbd "C-S-l") 'windmove-right)

;; disable (kbd C-x o)
(global-set-key (kbd "C-x o") (lambda (&optional arg)
                                (interactive "P")
                                (message "No.")))

(global-diff-hl-mode)

(global-smartscan-mode)
(global-set-key [f8] 'neotree-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(put 'scroll-left 'disabled nil)

(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")

(add-hook 'tuareg-abbrev-hook (lambda (x) (void)))
