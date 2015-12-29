;; ; package.el
(require 'package)
(require 'cl-lib)
(defvar install-packages '(cider
                           clojure-mode
                           haskell-mode
                           ido-at-point
                           ido-ubiquitous
                           ido-vertical-mode
                           magit
                           markdown-mode
                           mozc
                           paredit
                           slime
                           smex
                           undo-tree
                           web-mode
                           yaml-mode))
(cl-loop for alist in '(("melpa" . "http://melpa.org/packages/")
                        ("marmalade" . "https://marmalade-repo.org/packages/"))
         do (add-to-list 'package-archives alist))
(package-initialize)
(cl-loop for pkg in install-packages
         unless (package-installed-p pkg)
         collect pkg into not-installed
         finally do (when not-installed
                      (package-refresh-contents)
                      (cl-loop for pkg in not-installed do (package-install pkg))))

;; buffer.c
(setq-default tab-width 2)

;; indent.c
(setq-default indent-tabs-mode nil)

;; browse-url.el
(setq browse-url-browser-function 'eww-browse-url)

;; cider-mode
(add-hook 'clojure-mode-hook 'cider-mode)

;; cperl-mode.el
(cl-loop for regexp in '("\\.p[lm]\\'"
                         "\\.psgi\\'"
                         "\\.t\\'")
         do (add-to-list 'auto-mode-alist `(,regexp . cperl-mode)))
(add-hook 'cperl-mode-hook
          #'(lambda ()
              (setq cperl-indent-level 4
                    cperl-close-paren-offset -4
                    cperl-continued-statement-offset 4
                    cperl-indent-parens-as-block t
                    cperl-tab-always-indent t)))

;; custom.el
(load-theme 'wombat t)

;; diff.el
(setq diff-switches '("-u"))

;; dired.el
(setq dired-listing-switches "-alhF")

;; eshell.el
(add-hook 'after-init-hook #'(lambda () (cd "~/") (eshell)))

;; em-cmpl.el
(setq eshell-cmpl-ignore-case t)

;; em-hist.el
(setq eshell-history-size 10000
      eshell-hist-ignoredups t)

;; eww.el
(defun eww-open-hatena-bookmark ()
  "Open a hatena bookmark page of a current page."
  (interactive)
  (let ((url eww-current-url))
    (eww-browse-url (concat "http://b.hatena.ne.jp/add?mode=confirm&url=" url))))

;; files.el
(setq auto-save-default nil
      make-backup-files nil
      require-final-newline t)

;; flymake-mode.el
(add-hook 'cperl-mode-hook #'(lambda () (flymake-mode t)))

;; ido.el
(setq ido-case-fold t
      ido-enable-flex-matching t
      ido-everywhere t)
(ido-mode 1)

;; ido-at-point.el
(ido-at-point-mode 1)

;; ido-ubiquitous-mode.el
(ido-ubiquitous-mode 1)

;; ido-vertical-mode.el
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; smex.el
(cl-loop for (key cmd) in '(("M-x" smex)
                            ("M-X" smex-major-mode-commands)
                            ("C-c C-c M-x" execute-extended-command))
         do (global-set-key (kbd key) cmd))
(smex-initialize)

;; linum.el
(setq linum-format "%3d ")
(add-hook 'find-file-hook #'(lambda () (linum-mode 1)))

;; magit.el
(setq magit-last-seen-setup-instructions "2.1.0"
      magit-push-always-verify nil)

;; markdown-mode.el
(cl-loop for regexp in '("\\.markdown\\'"
                         "\\.md\\'")
         do (add-to-list 'auto-mode-alist `(,regexp . markdown-mode)))

;; menu-bar.el
(menu-bar-mode -1)

;; paredit.el
(cl-loop for mode-hook in '(emacs-lisp-mode-hook
                            eval-expression-minibuffer-setup-hook
                            ielm-mode-hook
                            lisp-mode-hook
                            lisp-interaction-mode-hook
                            scheme-mode-hook)
         do (add-hook mode-hook #'enable-paredit-mode))

;; mozc.el
(setq default-input-method "japanese-mozc"
      mozc-candidate-style 'echo-area
      mozc-keymap-preedit-method-to-keymap-name-map '((roman . mozc-keymap-kana)
                                                      (kana . mozc-keymap-kana)))

;; paren.el
(show-paren-mode t)

;; scheme.el
(setq scheme-program-name "/usr/bin/gosh -i")

;; scroll-bar.el
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; simple.el
(add-hook 'before-save-hook #'delete-trailing-whitespace)

(defun switch-before-save-hook-delete-trailing-whitespace ()
  (if (member #'delete-trailing-whitespace before-save-hook)
      (remove-hook 'before-save-hook #'delete-trailing-whitespace)
    (add-hook 'before-save-hook #'delete-trailing-whitespace)))

;; slime.el
(setq inferior-lisp-program "sbcl"
      slime-contribs '(slime-fancy))

;; startup.el
(setq inhibit-startup-message t
      initial-scratch-message nil)

;; subr.el
(fset 'yes-or-no-p #'y-or-n-p)

;; time.el
(display-time)

;; tool-bar.el
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; undo-tree.el
(global-undo-tree-mode 1)

;; web-mode.el
(cl-loop for regexp in '("\\.html?\\'"
                         "\\.css\\'"
                         "\\.php\\'"
                         "\\.mtml\\'"
                         "\\.tmpl\\'")
         do (add-to-list 'auto-mode-alist `(,regexp . web-mode)))

(add-hook 'web-mode-hook #'(lambda ()
                             (setq web-mode-markup-indent-offset 2
                                   web-mode-css-indent-offset 2
                                   web-mode-code-indent-offset 2)))

;; yaml-mode.el
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))
