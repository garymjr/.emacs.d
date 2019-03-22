;; Settings
(setq ace-window-display-mode t
      auto-revert-verbose nil
      auto-save-default nil
      column-number-mode t
      fill-column 100
      global-auto-revert-mode t
      indent-tabs-mode nil
      inhibit-startup-echo-area-message t
      inhibit-startup-screen t
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil
      make-backup-files nil
      ring-bell-function 'ignore
      show-trailing-whitespace t
      standard-indent 2)

;; Fonts
(add-to-list 'default-frame-alist
	     '(font . "Dank Mono-14"))

;; Setup `custom-file'
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(package-refresh-contents)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;;
;; Packages
;;

(use-package better-defaults :ensure t)

(use-package diminish :ensure t)

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :hook (after-init . which-key-mode))

(use-package smex
  :ensure t
  :bind ("M-x" . smex))

(use-package magit
  :ensure t
  :bind ("C-c g" . magit-status))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :init
  (require 'smartparens-config)
  :hook (after-init . smartparens-global-mode)
  :config
  (show-smartparens-global-mode))

(use-package hydra
  :ensure t
  :config
  (defhydra hydra-multiple-cursors ()
    "multiple cursors"
    ("a" mc/mark-all-like-this "all")
    ("n" mc/mark-next-like-this "next"))

  (defhydra hydra-expand-region ()
    "expand region"
    ("e" er/expand-region "expand")
    ("c" er/contract-region "contract")))

(use-package multiple-cursors
  :ensure t
  :bind ("C-c m" . hydra-multiple-cursors/body))

(use-package expand-region
  :ensure t
  :bind ("C-c e" . hydra-expand-region/body))

(use-package flx-ido
  :ensure t
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  ;; I'm not sure what this actually does, but I think it's the setting
  ;; that's causing me some headaches when searching for files.
  ;; I'm keeping it here for now in case I want to turn it back on.
  ;; (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

(use-package ace-window
  :ensure t
  :bind ("C-c w" . ace-window))

(use-package avy
  :ensure t
  :bind ("C-;" . avy-goto-char))

(use-package ripgrep
  :ensure t
  :defer t)

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :hook (after-init . projectile-global-mode)
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package company
  :ensure t
  :diminish company-mode
  :hook (after-init . global-company-mode))

(use-package undo-tree
  :defer t
  :diminish undo-tree-mode)

;;
;; Apperance
;;

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

;;
;; Languages
;;

(use-package web-mode
  :ensure t
  :mode ("\\.html\\'"
         "\\.css\\'"
         "\\.jsx?\\'"
         "\\.vue\\'"
         "\\.json\\'")
  :config
  (setq web-mode-attr-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-markup-indent-offset 2
        web-mode-sql-indent-offset 2
        web-mode-engines-auto-pairs nil
        web-mode-script-padding 0
        web-mode-style-padding 0
        web-mode-enable-auto-quoting nil))

(use-package yaml-mode :ensure t)
