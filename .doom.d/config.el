;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Arnau Abella"
      user-mail-address "arnauabella@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;; (setq doom-font (font-spec :family "Input Mono Narrow" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans"))
 (setq doom-font (font-spec :family "mononoki" :size 14 :weight 'medium )
          doom-variable-pitch-font (font-spec :family "mononoki" :size 14 :weight 'regular))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "/home/arnau/dotfiles/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ;; after-call to load package before hook
;; ;; defer-incrementally to load dependencies incrementally on idle periods.
;; (use-package! recentf
;;   :defer-incrementally easymenu tree-widget timer
;;   :after-call after-find-file)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ;; Appending and local hooks
;; (add-hook! (one-mode second-mode) :append #'enable-something)
;; (add-hook! (one-mode second-mode) :local #'enable-something)
;;
;; ;; With arbitrary forms
;; (add-hook! (one-mode second-mode) (setq v 5) (setq a 2))
;; (add-hook! (one-mode second-mode) :append :local (setq v 5) (setq a 2))
;;
;; ;; Inline named hook functions
;; (add-hook! '(one-mode-hook second-mode-hook)
;;   (defun do-something ()
;;     ...)
;;   (defun do-another-thing ()
;;     ...))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; (map! :map magit-mode-map
;;       :m  "C-r" 'do-something           ; C-r in motion state
;;       :nv "q" 'magit-mode-quit-window   ; q in normal+visual states
;;       "C-x C-r" 'a-global-keybind
;;       :g "C-x C-r" 'another-global-keybind  ; same as above
;;
;;       (:when IS-MAC
;;         :n "M-s" 'some-fn
;;         :i "M-o" (cmd! (message "Hi"))))
;;
;; (map! (:when (featurep! :completion company) ; Conditional loading
;;         :i "C-@" #'+company/complete
;;         (:prefix "C-x"                       ; Use a prefix key
;;           :i "C-l" #'+company/whole-lines)))
;;
;; (map! (:when (featurep! :lang latex)    ; local conditional
;;         (:map LaTeX-mode-map
;;           :localleader                  ; Use local leader
;;           :desc "View" "v" #'TeX-view)) ; Add which-key description
;;       :leader                           ; Use leader key from now on
;;       :desc "Eval expression" ";" #'eval-expression)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; **** projectile ****

(setq projectile-project-search-path '("~"))

;; **** magit ****

(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     ")) ;; Enable Gravatars on magit

;; **** neotree ****

(map! :map evil-motion-state-map "C-f" nil) ;; Remove previous keybinding
(map! "C-f" #'+neotree/open)
(map! "C-s" #'+neotree/find-this-file)

;; **** firefox ****

;; (map! (:when (executable-find "firefox") :map evil-normal-state-map "g b" 'browse-url-firefox))
;; (when (executable-find "firefox") (map! :map evil-normal-state-map "g b" 'browse-url-firefox))
(map! :map evil-normal-state-map "g b" #'browse-url)

;; **** haskell *****

;; (add-hook 'haskell-mode-hook 'turn-on-haskell-unicode-input-method) ;; unicode support

(remove-hook 'haskell-mode-hook 'interactive-haskell-mode)
(remove-hook 'haskell-mode-hook 'structured-haskell-mode)

(setq haskell-interactive-popup-errors nil)
(setq haskell-process-suggest-language-pragmas nil)

(after! smartparens
  (require 'smartparens-haskell))

(use-package! ormolu
  ;; :demand t
  ;; :hook (haskell-mode . ormolu-format-on-save-mode)
  ;; :bind
  ;; (:map haskell-mode-map
  ;;  ("C-c f" . ormolu-format-buffer))
  :config
  (setq ormolu-process-path "ormolu"))
(map! :map haskell-mode-map "C-c f" #'ormolu-format-buffer)

(use-package! lsp-haskell
 :ensure t
 :config
 (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper"))

(after! lsp-mode
  (map! :n "g ?" 'lsp-ui-doc-glance
        :n "g ]" 'lsp-find-definition
        :n "g r" 'lsp-restart-workspace)
  (setq lsp-ui-sideline-enable nil))
(setq lsp-lens-enable t)

(use-package! hs-lint
  :bind
  (:map haskell-mode-map
   ("C-c l" . hs-lint)))

(after! flycheck
    (setq-default flycheck-disabled-checkers '(haskell-ghc haskell-stack-ghc haskell-hlint)))
;; TODO
;; https://www.flycheck.org/en/latest/user/syntax-checkers.html#flycheck-checker-chains
;; (flycheck-add-next-checker 'lsp 'haskell-hlint)
(map! :map haskell-mode-map
      :n "C-j" 'flycheck-next-error
      :n "C-k" 'flycheck-previous-error
      :n "M-n" 'next-error
      :n "M-p" 'previous-error
      :n "M-RET" 'flycheck-buffer)
