;;; init.el --- Handle Emacs config -*- lexical-binding: t -*-

;; Can extend in ~/.emacs.d/lisp
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;;; Variable definitions go at the top
;; Font
(defvar lukegrn/default-font "JetBrains Mono")
(defvar lukegrn/default-size 120)
(defvar lukegrn/scale-on-mac t)
(defvar lukegrn/default-font-weight 'normal)
;;;; End variable definitions

;; UI tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-default 'truncate-lines t)
(fset 'yes-or-no-p 'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)

;; Use ibuffer instead of list-buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Theme
(load-theme 'modus-vivendi-deuteranopia)

;; Line nums in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; On mac use command as control
(setq mac-command-modifier 'control)

;; Don't put custom values here
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Smooth Scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Paren settings
(show-paren-mode 1)
(setq show-paren-delay 0)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(show-paren-match ((t (:underline 'foreground-color)))))


(when (and lukegrn/scale-on-mac (equal system-type 'darwin))
  (setq lukegrn/default-size (+ lukegrn/default-size 40)))

(when (not (equal system-type 'darwin))
  (setq lukegrn/default-font-weight 'semibold))

(set-face-attribute 'default nil
		    :family lukegrn/default-font
		    :height lukegrn/default-size
		    :weight lukegrn/default-font-weight
		    :width 'normal)

;; Init package
(require 'package)
(package-initialize)
;; Add melpa to package archives
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; Don't litter directories with backup files
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups")))
      auto-save-default nil
      create-lockfiles nil)

;; Evil makes emacs a better vim
(use-package evil
  :ensure t
  :preface (setq evil-want-keybinding nil)
  :init (setq evil-undo-system 'undo-redo)
  :config (evil-mode 1))

;; Use shell path
(use-package exec-path-from-shell
  :ensure t
  :preface (setq exec-path-from-shell-arguments nil)
  :config (exec-path-from-shell-initialize))

;; On mac make the titlebar the same color as the theme
(when (equal system-type 'darwin)
  (use-package ns-auto-titlebar
    :ensure t
    :config (ns-auto-titlebar-mode)))

;; Set up LSP
(use-package eglot
  :ensure t
  :hook (prog-mode . eglot-ensure))

;; Tree sitter for highlighting
;; List of langs
(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash" "v0.25.1" "src")
	(css "https://github.com/tree-sitter/tree-sitter-css" "v0.25.0" "src")
	(elisp "https://github.com/Wilfred/tree-sitter-elisp" "1.6.1" "src")
	(go "https://github.com/tree-sitter/tree-sitter-go" "v0.25.0" "src")
	(html "https://github.com/tree-sitter/tree-sitter-html" "v0.23.2" "src")
	(javascript "https://github.com/tree-sitter/tree-sitter-javascript" "v0.25.0" "src")
	(json "https://github.com/tree-sitter/tree-sitter-json" "v0.24.8" "src")
	(make "https://github.com/alemuller/tree-sitter-make")
	(python "https://github.com/tree-sitter/tree-sitter-python" "v0.25.0" "src")
	(tsx "https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2" "tsx/src")
	(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2" "typescript/src")
	(yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; Install them
(dolist (lang (mapcar #'car treesit-language-source-alist))
  (if (not (treesit-language-available-p lang))
      (treesit-install-language-grammar lang)))

;; Remap modes
(setq major-mode-remap-alist
 '((yaml-mode . yaml-ts-mode)
   (bash-mode . bash-ts-mode)
   (typescript-mode . typescript-ts-mode)
   (json-mode . json-ts-mode)
   (css-mode . css-ts-mode)
   (python-mode . python-ts-mode)
   (elisp-mode . elisp-ts-mode)))

;; Modes that have to be explicitly specified
;; Maybe replace add-to-list calls with :mode
(use-package go-ts-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode)))

(use-package typescript-ts-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode)))

(use-package markdown-mode
  :ensure t
  :mode
  ("\\.md\\'" . markdown-mode))

;; Command completion
(use-package vertico
  :ensure t
  :config (vertico-mode))

;; Help me find key bindings
(use-package which-key
  :config (which-key-mode))

;; It's Magit!
(use-package magit
  :ensure t)

;; Evil in other things (like Magit)
(use-package evil-collection
  :ensure t
  :preface
  (setq evil-want-keybinding nil)
  (setq evil-want-minibuffer t)
  :config (evil-collection-init))

;; Comment lines that are highlighted
(use-package evil-nerd-commenter
  :ensure t
  :config (evilnc-default-hotkeys))

;; Set timers in emacs
(use-package tmr
  :ensure t
  :config (define-key global-map (kbd "C-c t") #'tmr-prefix-map))

;; Maybe this shell actually works?
(use-package eat
  :ensure t
  :hook (eshell-load-hook . eat-eshell-mode)
  :config (setq eat-enable-auto-line-mode 1))

;; Auto format all the things
(use-package format-all
  :ensure t
  :hook
  (prog-mode . format-all-mode)
  (markdown-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
		'(("Markdown" prettier)
		  ("Javascript" prettier)
		  ("JSX" prettier)
		  ("Typescript" prettier)
		  ("TSX" prettier)
		  ("Shell" shfmt)
		  ("Go" gofmt)
		  ("Python" black))))

;; Show git diffs in the gutter
(use-package git-gutter
  :ensure t
  :hook (prog-mode . git-gutter-mode))
