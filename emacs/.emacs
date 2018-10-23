(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(global-linum-mode t)
(setq sgml-quick-keys 'indent)
(setq default-frame-alist '((vertical-scroll-bars . nil)
                            (tool-bar-lines . 0)
                            (menu-bar-lines . 0)))

(setq frame-title-format
  (list (format "%s %%S: %%j " (system-name))
    '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-directory-alist '(("" . "~/.emacs.d/backups")))
(setq undo-tree-history-directory-alist '(("" . "~/.emacs.d/backups")))
(set-default 'truncate-lines t)
(setq-default tab-width 4 indent-tabs-mode nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(require 'diminish)

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  (evil-define-key 'normal global-map (kbd "C-p") 'helm-projectile)
  (evil-define-key 'normal global-map (kbd "C-S-p") 'helm-projectile-switch-project)

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode 1))

  (use-package evil-smartparens
    :init
    (add-hook 'smartparents-enabled-hook #'evil-smartparens-mode)
    :ensure t
    :diminish smartparens-mode)
  
  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader ",")))

(smartparens-global-mode t)

(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (setq helm-input-idle-delay 0.1)
  (setq helm-cycle-resume-delay 2)
  (setq helm-follow-input-idle-delay 1)
  :config
  (require 'helm-config)
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (define-key global-map [remap find-file] 'helm-find-files)
  (define-key global-map [remap occur] 'helm-occur)
  (helm-autoresize-mode 1)
  (helm-mode 1)

  (use-package helm-ag
    :ensure t)
  (use-package helm-projectile
    :ensure t))

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))

(use-package yaml-mode
  :ensure t
  :diminish yaml-mode
  :config
  (yaml-mode))

(use-package rainbow-delimiters
  :ensure t
  :diminish rainbow-delimiters-mode
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package powerline
  :ensure t
  :config
  (powerline-vim-theme)
  (setq powerline-utf-8-separator-left       #xe0b0
        powerline-utf-8-separator-right      #xe0b2
        airline-utf-glyph-separator-left     #xe0b0
        airline-utf-glyph-separator-right    #xe0b2
        airline-utf-glyph-subseparator-left  #xe0b1
        airline-utf-glyph-subseparator-right #xe0b3
        airline-utf-glyph-branch             #xe0a0
        airline-utf-glyph-readonly           #xe0a2
        airline-utf-glyph-linenumber         #xe0a1)
  
  (use-package powerline-evil
    :ensure t)
  (use-package airline-themes
    :ensure t
    :config
    (load-theme 'airline-kalisi)))

(use-package company
  :ensure t
  :diminish company-mode
  :init
  (global-company-mode)
  :config
  (add-to-list 'company-backends 'company-ansible)
  (add-to-list 'company-backends 'company-jedi)
  (add-to-list 'company-backends 'company-web-html)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  (define-key company-active-map [tab] 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)

  (use-package company-ansible
    :ensure t)
  (use-package company-jedi
    :ensure t
    :config
    (add-hook 'python-mode-hook 'jedi-mode))
  (use-package company-shell
    :ensure t)
  (use-package company-web
    :ensure t))

(use-package yasnippet
  :ensure t
  :defer t
  :init
  (yas-global-mode t)
  :config
  (yas-reload-all)

  (use-package yasnippet-snippets
    :ensure t))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  (add-hook 'markdown-mode-hook 'flyspell-mode))

(use-package json-mode
  :ensure t
  :init
  (add-hook 'json-mode-hook
    (lambda ()
      (make-local-variable 'js-indent-level)
      (setq js-indent-level 2))))

(use-package powershell
  :ensure t)

(use-package org
  :ensure t
  :defer t
  :commands (org-capture)
  :bind (("C-c a" . org-agenda)
         ("C-c l" . org-store-link))
  :config
  (setq-default fill-column 100)
  (setq org-startup-with-inline-images t)
  (setq org-log-done t)
  (setq org-agenda-files '("~/org/"))
  (add-hook 'org-mode-hook
            (lambda ()
              (when (not (eq major-mode 'org-agenda-mode))
                (flyspell-mode)))))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme))))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-bullets-bullet-list '("•")))

(use-package page-break-lines
  :ensure t
  :diminish page-break-lines-mode
  :init
  (global-page-break-lines-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 5)
                          (projects . 5))))

(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :init
  (global-git-gutter-mode 1))

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :config
  (setq undo-tree-auto-save-history t))

(use-package highlight-indent-guides
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (add-hook 'yaml-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'column))

(use-package ansible
  :ensure t
  :config
  (add-hook 'yaml-mode-hook '(lambda () (ansible 1))))

(use-package groovy-mode
  :ensure t)

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (add-hook 'flycheck-mode-hook
            (lambda ()
              (evil-define-key 'normal flycheck-mode-map (kbd "]e") 'flycheck-next-error)
              (evil-define-key 'normal flycheck-mode-map (kbd "[e") 'flycheck-previous-error)
              (evil-leader/set-key (kbd "e") 'flycheck-list-errors))))

(use-package virtualenvwrapper
  :ensure t
  :config
  (setq venv-location (expand-file-name "~/.virtualenvs")))

(use-package gruvbox-theme
  :ensure t)

(load-theme 'gruvbox-dark-hard t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("cf284fac2a56d242ace50b6d2c438fcc6b4090137f1631e32bedf19495124600" default)))
 '(package-selected-packages (quote (flycheck company-shell-env evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#1d2021" :foreground "#fdf4c1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "pyrs" :family "RobotoMono Nerd Font")))))
