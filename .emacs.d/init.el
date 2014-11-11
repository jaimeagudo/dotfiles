(require 'package) ;; You might already have this line
(setq package-archives 
      '( 
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("elpa" . "http://tromey.com/elpa/")
        ("melpa" . "http://melpa.milkbox.net/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ))

(package-initialize) ;; init elpa packages


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Key modifiers for Mac OS X Emacs.app in spanish MBP keyboard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-1") "|")
(global-set-key (kbd "M-2") "@")
(global-set-key (kbd "M-3") "#")
(global-set-key (kbd "M-4") "$")
(global-set-key (kbd "M-ñ") "~")
(global-set-key (kbd "M-º") "\\")
(global-set-key (kbd "M-ç") "}")
(global-set-key (kbd "M-+") "]")


;(add-to-list 'package-archives
 ;            '("melpa" . "http://melpa.org/packages/") t)
;(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
 ; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;(package-initialize) 


;; Clojure

(require 'clojure-mode)
(setq auto-mode-alist (cons '("\\.cljs$" . clojure-mode) auto-mode-alist))
(setq inferior-lisp-program "lein repl")

;; clj-refactor
(require 'clj-refactor)
(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-o")))

;; align-cljlet
(require 'align-cljlet)
(global-set-key (kbd "C-c C-a") 'align-cljlet)

;; paredit
(require 'paredit)
(add-hook 'clojure-mode-hook 'paredit-mode)

;; projectile
(require 'projectile)
(add-hook 'clojure-mode-hook 'projectile-mode)

;; company-mode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-etags)
(add-to-list 'company-etags-modes 'clojure-mode)

;; yasnippet
(require 'yasnippet)
(require 'clojure-snippets)
(yas-global-mode 1)
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
(yas-load-directory "~/.emacs.d/snippets")

;; Some handly key bindings

(global-set-key (kbd "C-c C-s") 'clojure-toggle-keyword-string)

(add-hook 'clojure-mode-hook
          '(lambda ()
             (define-key clojure-mode-map
               "\C-c\C-k"
               '(lambda ()
                  (interactive)
                  (let ((current-point (point)))
                    (goto-char (point-min))
                    (let ((ns-idx (re-search-forward clojure-namespace-name-regex nil t)))
                      (when ns-idx
                        (goto-char ns-idx)
                        (let ((sym (symbol-at-point)))
                          (message (format "Loading %s ..." sym))
sy                          (lisp-eval-string (format "(require '%s :reload)" sym))
                          (lisp-eval-string (format "(in-ns '%s)" sym)))))
                    (goto-char current-point))))
             (define-key clojure-mode-map
               "\M-."
               '(lambda (next-p)
                  (interactive "P")
                  (find-tag (first (last (split-string (symbol-name (symbol-at-point)) "/")))
                     next-p)))))
                                                       
(add-hook 'inferior-lisp-mode-hook
          '(lambda ()
             (define-key inferior-lisp-mode-map
               "\C-cl"
               '(lambda ()
                  (interactive)
                  (erase-buffer)
                  (lisp-eval-string "")))))




;(load-theme 'monokai)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("0e7da2c7c64fb5d4764250ffa4b8b33c0946577108d1d6444f1020d0dabba784" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
