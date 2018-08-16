;; hide startup frame message
(setq inhibit-startup-message t)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(set-face-attribute 'default nil :height 150 :family "InconsolataDZ for Powerline")
;; (tooltip-mode -1)

;; Spaces instead of tabs
;; (setq-default indent-tabs-mode nil)

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

(use-package neotree
:ensure t
:bind (("s-m" . neotree-toggle))
:config (setq neo-autorefresh nil))

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

(use-package helm
  :ensure t
  :bind
  ("C-x C-f" . 'helm-find-files)
  ("C-x C-b" . 'helm-buffers-list)
  ("M-x" . 'helm-M-x)
  :config
  (defun daedreth/helm-hide-minibuffer ()
    (when (with-helm-buffer helm-echo-input-in-header-line)
      (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
        (overlay-put ov 'window (selected-window))
        (overlay-put ov 'face
                     (let ((bg-color (face-background 'default nil)))
                       `(:background ,bg-color :foreground ,bg-color)))
        (setq-local cursor-type nil))))
  (add-hook 'helm-minibuffer-set-up-hook 'daedreth/helm-hide-minibuffer)
  (setq helm-autoresize-max-height 0
        helm-autoresize-min-height 40
        helm-M-x-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-split-window-in-side-p nil
        helm-move-to-line-cycle-in-source nil
        helm-ff-search-library-in-sexp t
        helm-scroll-amount 8 
        helm-echo-input-in-header-line t)
  :init
  (helm-mode 1))

(require 'helm-config)    
(helm-autoresize-mode 1)
(define-key helm-find-files-map (kbd "C-b") 'helm-find-files-up-one-level)
(define-key helm-find-files-map (kbd "C-f") 'helm-execute-persistent-action)

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

(setq display-time-24hr-format t)
(setq display-time-format "%Y-%m-%dT%H:%M:%SZ")
(display-time-mode 1)

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

    (setq powerline-default-separator nil)
    ;; (setq powerline-default-separator (quote arrow))
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

(use-package magit
  :ensure t
  :config
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  :bind
  ("M-g" . magit-status))

(use-package ivy
  :ensure t)

(use-package swiper
  :ensure t
  :bind ("C-s" . 'swiper))

(use-package mark-multiple
  :ensure t
  :bind ("s-d" . 'mark-next-like-this))

(use-package expand-region
  :ensure t
  :bind ("C-q" . er/expand-region))

(use-package popup-kill-ring
  :ensure t
  :bind ("M-y" . popup-kill-ring))

(use-package company               
  :ensure t
  :defer t
  :init (global-company-mode)
  :config
  (progn
    ;; Use Company for completion
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)

    (setq company-tooltip-align-annotations t
          ;; Easy navigation to candidates with M-<n>
          company-show-numbers t
          company-idle-delay 0
          company-minimum-prefix-length 2)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode)


(with-eval-after-load 'company
  ;; (define-key company-active-map (kbd "M-h") #'company-show-doc-buffer)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "SPC") #'company-abort))


(use-package company-quickhelp          ; Documentation popups for Company
  :ensure t
  :defer t
  :init 
  (add-hook 'global-company-mode-hook #'company-quickhelp-mode)
  :config
  (global-set-key (kbd "M-/") 'company-complete))

(use-package company-quickhelp
   :ensure t
   :config
   (setq pos-tip-background-color "#ff0000")
   (company-quickhelp-mode))

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

(setq org-ellipsis " ")
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-confirm-babel-evaluate nil)
(setq org-export-with-smart-quotes t)
(setq org-src-window-setup 'current-window)
(add-hook 'org-mode-hook 'org-indent-mode)

(setq org-src-window-setup 'current-window)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(add-to-list 'org-structure-template-alist
	       '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))

(use-package projectile
  :ensure t
  :init
    (projectile-mode 1))
;; (global-set-key (kbd "s-p") 'projectile-compile-project)

(use-package yasnippet
  :ensure t
  :config
    (use-package yasnippet-snippets
      :ensure t)
    (yas-reload-all))

(yas-global-mode 1)

(use-package exec-path-from-shell
  :ensure t
  :config 
  (exec-path-from-shell-initialize))

(use-package flycheck
  :ensure t)

(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)

(use-package flycheck-clang-analyzer
  :ensure t
  :config
  (with-eval-after-load 'flycheck
    (require 'flycheck-clang-analyzer)
     (flycheck-clang-analyzer-setup)))

(use-package company-c-headers
  :ensure t)

(use-package company-irony
  :ensure t
  :config
  (setq company-backends '((company-c-headers
                            company-dabbrev-code
                            company-irony))))

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(add-hook 'python-mode-hook 'yas-minor-mode)

(add-hook 'python-mode-hook 'flycheck-mode)

(setenv "PATH" (concat (expand-file-name "~/.local/bin:") (getenv "PATH")))

(use-package python
  :ensure t
  :defer t
  :mode 
  ("\\.wsgi$" . python-mode)
  ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  :init 
  (setq-default indent-tabs-mode nil)
  ;; :bind (:map python-mode-map
  ;;             (("M-/" . completion-at-point)))
  :config 
  (setq python-indent-offset 4))

(defun company-yasnippet-or-completion ()
  "Solve company yasnippet conflicts."
  (interactive)
  (let ((yas-fallback-behavior
         (apply 'company-complete-common nil)))
    (yas-expand)))

(add-hook 'company-mode-hook
          (lambda ()
            (substitute-key-definition
             'company-complete-common
             'company-yasnippet-or-completion
             company-active-map)))

(use-package elpy
  :ensure t 
  :init
  (with-eval-after-load 'python (elpy-enable))
  :config
  (setq elpy-rpc-python-command "python3"
        python-shell-interpreter "ipython3"
        python-shell-interpreter-args "-i"
        elpy-rpc-backend "jedi")
  (add-hook 'python-mode-hook 'company-mode))

;; (eval-after-load 'python
;;   '(define-key python-mode-map ["M-/"] 'completion-at-point))


;; (use-package jedi
;; :ensure t
;; :init
;; (add-to-list 'company-backends 'company-jedi)
;; :config
;; (use-package company-jedi
;;   :ensure t
;;   :init
;;   (add-hook 'python-mode-hook (lambda () (add-to-list 'company-backends 'company-jedi)))
;;   (setq company-jedi-python-bin "python3")))


  ;; (setq elpy-modules (delq 'elpy-module-company elpy-modules))
  ;; (add-hook 'python-mode-hook
  ;;         (lambda ()
  ;;           ;; explicitly load company for the occasion when the deferred
  ;;           ;; loading with use-package hasn't kicked in yet
  ;;           (company-mode)
  ;;           (add-to-list 'company-backends
  ;;                        (company-mode/backend-with-yas 'elpy-company-backend)))))

;; (use-package pipenv
;;   :commands (pipenv-activate
;;              pipenv-deactivate
;;              pipenv-shell
;;              pipenv-open
;;              pipenv-install
;;              pipenv-uninstall)
;;   :hook (python-mode . pipenv-mode)
;;   :init
;;   (setq
;;    pipenv-projectile-after-switch-function
;;    #'pipenv-projectile-after-switch-extended))

(use-package js2-mode
  :ensure t
  :init
  (setq js-basic-indent 2)
  (setq-default js2-basic-indent 2
                js2-basic-offset 2
                js2-auto-indent-p t
                js2-cleanup-whitespace t
                js2-enter-indents-newline t
                js2-indent-on-enter-key t
                js2-global-externs (list "window" "module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "jQuery" "$"))

  (add-hook 'js2-mode-hook
            (lambda ()
              (push '("function" . ?ƒ) prettify-symbols-alist)))

  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))


(use-package color-identifiers-mode
    :ensure t
    :init
      (add-hook 'js2-mode-hook 'color-identifiers-mode))

(add-hook 'js2-mode-hook
          (lambda () (flycheck-select-checker "javascript-eslint")))

(add-hook 'js2-mode-hook 'yas-minor-mode)

(use-package company-go
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-go)))


(use-package go-mode
  :ensure t
  :init
  (progn
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)
    (bind-key [remap find-tag] #'godef-jump))
  :config
  (add-hook 'go-mode-hook 'electric-pair-mode))

(use-package go-eldoc
  :ensure t
  :defer
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

(add-hook 'emacs-lisp-mode-hook 'yas-minor-mode)

(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq slime-contribs '(slime-fancy)))

(use-package slime-company
  :ensure t
  :init
    (require 'company)
    (slime-setup '(slime-fancy slime-company)))
