;; hide startup frame message
(setq inhibit-startup-message t)

;; hide tool-bar
(tool-bar-mode -1)

;; hide menu-bar
(menu-bar-mode -1)

;; hide scroll-bar
(scroll-bar-mode -1)

;; backupfile setting
;; (setq make-backup-files nil)
;; (setq auto-save-default nil)

;; yes-or-no change to y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; (defvar my-fish-shell "/usr/local/bin/fish")
;; (defvar my-zsh-shell "/usr/local/bin/zsh")
;; (defadvice ansi-term (before force-bash)
;;   (interactive (list my-fish-shell)))
;; (ad-activate 'ansi-term)

(global-set-key (kbd "<s-return>") 'ansi-term)

(setq scroll-conservatively 100)

(setq ring-bell-function 'ignore)

;; mode set
(when window-system (global-hl-line-mode t))
(global-prettify-symbols-mode t)

;; ido-mode
(setq ido-enalbe-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

;; install spacemacs-theme
(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

(unless (package-installed-p 'dracula-theme)
  (package-refresh-contents)
  (package-install 'dracula-theme))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))
