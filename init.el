(require 'package)


(setq package-enable-at-startup nil)

;; hide startup frame message
(setq inhibit-startup-message t)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; Install Packages

;; install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; install spacemacs-theme
(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

;; Install Packages End


;; Use Package Define

(use-package which-key
  :ensure t
  :init
  (which-key-mode))


(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

;; Use Package End


;; yes-or-no change to y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Default Ansi Shell

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

;; backupfile setting
;; (setq make-backup-files nil)
;; (setq auto-save-default nil)

;; hide tool-bar
(tool-bar-mode -1)

;; hide menu-bar
(menu-bar-mode -1)

;; hide scroll-bar
(scroll-bar-mode -1)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages (quote (beacon spacemacs-theme which-key use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "nil" :family "Menlo")))))
