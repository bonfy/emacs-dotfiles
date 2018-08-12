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

(defun kill-current-buffer ()
  "Kills the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(use-package switch-window
  :ensure t
  :config
    (setq switch-window-input-style 'minibuffer)
    (setq switch-window-increase 4)
    (setq switch-window-threshold 2)
    (setq switch-window-shortcut-style 'qwerty)
    (setq switch-window-qwerty-shortcuts
        '("a" "s" "d" "f" "j" "k" "l" "i" "o"))
  :bind
    ([remap other-window] . switch-window))

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;; mode set
(when window-system (global-hl-line-mode t))
(global-prettify-symbols-mode t)

;; ido-mode
(setq ido-enalbe-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(use-package rainbow-mode
  :ensure t
  :init
    (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))
;; if only need for prog mode
  ;; (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(global-subword-mode 1)

(setq electric-pair-pairs '(
			   (?\{ . ?\})
			   (?\( . ?\))
			   (?\[ . ?\])
			   (?\" . ?\")
			   ))
(electric-pair-mode t)

(setq line-number-mode t)
(setq column-number-mode t)

;; install spacemacs-theme
(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

(unless (package-installed-p 'dracula-theme)
  (package-refresh-contents)
  (package-install 'dracula-theme))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
    (setq spaceline-buffer-encoding-abbrev-p nil)
    (setq spaceline-line-column-p nil)
    (setq spaceline-line-p nil)
    (setq powerline-default-separator (quote arrow))
    (spaceline-spacemacs-theme))

(use-package diminish
  :ensure t
  :init
  (diminish 'which-key-mode)
  (diminish 'subword-mode)
  (diminish 'beacon-mode)
  (diminish 'hungry-delete-mode)
  (diminish 'rainbow-mode))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 20)))
  (setq dashboard-banner-logo-title "Be Happy~ Bonfy"))

(use-package linum-relative
  :ensure t
  :config
    (setq linum-relative-current-symbol "")
    (add-hook 'prog-mode-hook 'linum-relative-mode))

(use-package hungry-delete
  :ensure t
  :config
    (global-hungry-delete-mode))

(use-package ivy
  :ensure t)

(use-package swiper
  :ensure t
  :bind ("C-s" . 'swiper))

(use-package popup-kill-ring
  :ensure t
  :bind ("M-y" . popup-kill-ring))

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

(global-set-key (kbd "C-c l k") 'kill-whole-line)

(defun daedreth/kill-inner-word ()
  "Kills the entire word your cursor is in. Equivalent to 'ciw' in vim."
  (interactive)
  (forward-char 1)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c w k") 'daedreth/kill-inner-word)

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(setq org-src-window-setup 'current-window)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(add-to-list 'org-structure-template-alist
	       '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))
