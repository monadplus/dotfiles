;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
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

;; Copied from kcsongor/doom-config
(defmacro defsection (name &optional description &rest body)
  "Set up the general structure of this config file"
  (declare (doc-string 2))
  (unless
      (and description (char-or-string-p description))
    (warn (concat "Section " (prin1-to-string name) " has no docstring.")))
  `(progn ,@body))


(defsection general
  "General configuration."

  (setq user-full-name "Arnau Abella"
        user-mail-address "arnauabella@gmail.com")

  ;; `doom-font'
  ;; `doom-variable-pitch-font'
  ;; `doom-big-font' -- used for `doom-big-font-mode'; use this for presentations or streaming.
  (setq doom-font (font-spec :family "mononoki" :size 14 :weight 'medium )
        doom-variable-pitch-font (font-spec :family "mononoki" :size 14 :weight 'regular))

  (setq doom-theme 'doom-dracula)
  (setq display-line-numbers-type t)
  (setq-default line-spacing 1)
  (setq fancy-splash-image "~/wallpapers/megumin_2.png") ; Change doom-dashboard wallpaper

  ; Keychain saves the agents' environment variables to files inside ~/.keychain/, so that subsequent shells can source these files.
  ; When Emacs is started under X11 and not directly from a terminal these variables are not set.
  (keychain-refresh-environment)

  ;; force emacs to use ~/.zshrc path and aliases
  ;; FIXME the path is not property splited (adds garbage)
  ;; (let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  ;;   (setenv "PATH" path)
  ;;   (setq exec-path
  ;;         (append
  ;;          (split-string-and-unquote path ":")
  ;;          exec-path)))
  ;;
  (defun string-trim-final-newline (string)
    (let ((len (length string)))
      (cond
       ((and (> len 0) (eql (aref string (- len 1)) ?\n))
        (substring string 0 (- len 1)))
       (t string))))
  (add-to-list 'exec-path (string-trim-final-newline (shell-command-to-string "npm bin")))

  ;; Transparency
  (defun toggle-transparency ()
    (interactive)
    (let ((alpha (frame-parameter nil 'alpha)))
      (set-frame-parameter
       nil 'alpha
       (if (eql (cond ((numberp alpha) alpha)
                      ((numberp (cdr alpha)) (cdr alpha))
                      ;; Also handle undocumented (<active> <inactive>) form.
                      ((numberp (cadr alpha)) (cadr alpha)))
                100)
           '(98 . 50) '(100 . 100)))))
  (map! :leader
        (:prefix-map ("t" . "toggle")
         :desc "transparency"
         "t" #'toggle-transparency))

  (defun transparency (value)
    "Sets the transparency of the frame window. 0=transparent/100=opaque"
    (interactive "nTransparency Value 0 - 100 opaque:")
    (set-frame-parameter (selected-frame) 'alpha value))

  ;; Display workspaces ALL the time.
  (defun show-workspaces ()
    (interactive)
    (when (and (not (minibufferp))
               (or (not (current-message))
                   (equal "Quit" (current-message))))
      (+workspace/display)))

  (defvar workspace-timer nil
    "Show workspace timer.")

  (setq workspace-timer (run-with-idle-timer 0.5 t 'show-workspaces)) ;; run-with-idle-timer returns a timer that can be cancelled with cancel-timer

  (add-variable-watcher 'workspace-timer (lambda (&rest _) (cancel-timer workspace-timer))) ;; cancel old timer

  (add-hook 'pre-command-hook 'show-workspaces) ;; Adding this will prevent the workspaces from hiding

  (after! which-key
    (which-key-setup-side-window-bottom)
    (setq which-key-idle-delay 0.5)
    (setq which-key-idle-secondary-delay 0.05)
    (setq which-key-show-transient-maps t))

  ;; Latex
  (setq +latex-viewers '(pdf-tools))
  (map! (:when (featurep! :lang latex)
         (:map LaTeX-mode-map
            :localleader
              :n "p" #'preview-at-point
              :n "d" #'preview-document
              :n "m" #'latex-preview-pane-mode
            )))
  (when (featurep! :lang latex)
    (customize-set-variable 'shell-escape-mode "-shell-escape"))
  (after! latex
    (setf (nth 1 (assoc "LaTeX" TeX-command-list))
      "%`%l -interaction=nonstopmode -shell-escape %(mode)%' %t"))

  ;; Projectile
  (setq projectile-project-search-path '("~")))

(defsection git
  "Git/Magic settings."

   (after! git-gutter
      (map! :n "M-j" 'git-gutter:next-hunk
            :n "M-k" 'git-gutter:previous-hunk
            :n "M-h" 'git-gutter:revert-hunk
            :n "M-l" 'git-gutter:stage-hunk))

   (setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     ")))

(defsection keybinds
  "All my custom keybindings."

  (map! :map evil-motion-state-map "C-f" nil) ;; Remove previous keybinding
  (map! :n "M-]" 'evil-window-increase-width
        :n "M-[" 'evil-window-decrease-width
        :n "M-=" 'evil-window-decrease-height
        :n "M-'" 'evil-window-increase-height)

  ;; (map! :n "..." '+workspace/swap-left
  ;;       :n "..." '+workspace/swap-right
  ;;       :n "..." '+workspace/switch-left
  ;;       :n "..." '+workspace/switch-right
  ;;       :n "..." (lambda () (interactive) (+workspace/new (concat (+workspace-current-name) "-copy") t))
  ;;       :n "..." '+workspace/rename)

  (map! :map pdf-view-mode-map
        :n "TAB" 'pdf-outline)

  (map! "C-f" #'+neotree/open)
  (map! "C-s" #'+neotree/find-this-file)

  (map! :desc "Paste in insert mode" :i "C-v" #'clipboard-yank)

  ; https://github.com/redguardtoo/evil-nerd-commenter
  (map! :nv "gc" #'evilnc-comment-or-uncomment-lines)
  (map! :nv "gC" #'evilnc-copy-and-comment-lines)

  ;; FIXME Not working
  ;; (defadvice! prompt-for-buffer (&rest _)
  ;;   :after 'evil-window-vsplit (switch-to-buffer))

  ; https://github.com/hlissner/doom-emacs/blob/8284f1035bb9366cfa050ab787ca794008f263bc/modules/config/default/%2Bemacs-bindings.el#L22
  (map! :leader
        (:prefix-map ("o" . "open")
         :desc "vterm in a new workspace"
         "t" (cmd! (+workspace/new "vterm" nil)
                   (+vterm/here nil))))

  ;; (map! (:when (executable-find "firefox") :map evil-normal-state-map "g b" 'browse-url-firefox))
  ;; (when (executable-find "firefox") (map! :map evil-normal-state-map "g b" 'browse-url-firefox))
  (map! :map evil-normal-state-map "g b" #'browse-url))

(defsection haskell-mode
  "Haskell settings."

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
        :n "M-RET" 'flycheck-buffer))

(defsection org-mode
  "Org."

  ;; This is just a default location to look for Org files.  There is no need
  ;; at all to put your files into this directory.  It is used in the
  ;; following situations:
  ;;
  ;; 1. When a capture template specifies a target file that is not an
  ;;    absolute path.  The path will then be interpreted relative to
  ;;    org-directory
  ;; 2. When the value of variable org-agenda-files is a single file, any
  ;;    relative paths in this file will be taken as relative to
  ;;    org-directory.
  (setq org-directory "/home/arnau/dotfiles/org/"))
