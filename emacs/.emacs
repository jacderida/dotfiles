(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
(package-initialize)
(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents)
     package-install package)))
(load-theme 'tango-dark t)
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(require 'evil-leader)
(require 'relative-line-numbers)
(evil-mode t)

(global-evil-leader-mode t)
(setq evil-leader/in-all-states t)
(evil-leader/set-leader ",")

(global-relative-line-numbers-mode)
(defun jp-rel-format (offset)
    "Another formatting function"
      (format "%03d " (abs offset)))
(setq relative-line-numbers-format 'jp-rel-format)
