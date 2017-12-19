(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(global-linum-mode t)
(setq default-frame-alist '((vertical-scroll-bars . nil)
                            (tool-bar-lines . 0)
                            (menu-bar-lines . 0)))

(setq frame-title-format
  (list (format "%s %%S: %%j " (system-name))
    '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))
(setq make-backup-files nil)
(setq-default tab-width 4 indent-tabs-mode nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(smartparens-global-mode t)

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
    :ensure t))

(use-package helm
  :ensure t
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
  :config
  (yaml-mode))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package telephone-line
  :ensure t
  :config
  (telephone-line-evil-config))

(use-package company
  :ensure t
  :init
  (global-company-mode)
  :config
  (add-to-list 'company-backends 'company-jedi)
  (add-to-list 'company-backends '(company-shell company-shell-env))
  (setq company-idle-delay 0.2)
  (setq company-selection-wrap-around t)
  (define-key company-active-map [tab] 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)

  (use-package company-jedi
    :ensure t)
  (use-package company-shell
    :ensure t)
  (use-package company-shell-env
    :ensure t))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package neotree
  :ensure t
  :config
  (global-set-key [f4] 'neotree-toggle)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (add-hook 'neotree-mode-hook
    (lambda ()
      (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
      (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
      (define-key evil-normal-state-local-map (kbd "m") 'neotree-rename-node)
      (define-key evil-normal-state-local-map (kbd "c") 'neotree-create-node)
      (define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)
      (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
      (define-key evil-normal-state-local-map (kbd "i") 'neotree-enter-horizontal-split)
      (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter))))

(use-package json-mode
  :ensure t
  :init
  (add-hook 'json-mode-hook
    (lambda ()
      (make-local-variable 'js-indent-level)
      (setq js-indent-level 2))))

(use-package powershell
  :ensure t)

(use-package gruvbox-theme
  :ensure t)

(load-theme 'gruvbox-dark-hard t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#1d2021" :foreground "#fdf4c1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "pyrs" :family "RobotoMono Nerd Font")))))
