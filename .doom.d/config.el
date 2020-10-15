;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to this file. Emacs searches the `load-path' when you load packages with `require' or `use-package'.
;; - `use-package!'
;; - `add-hook!'
;; - `map!'

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

  ; font
  (setq doom-font (font-spec :family "Iosevka" :size 15 :weight 'medium )
        doom-variable-pitch-font (font-spec :family "Iosevka" :size 14 :weight 'regular) ;; e.g. neotree font
        doom-big-font (font-spec :family "Iosevka" :size 20 :weight 'regular)) ; doom-big-font-mode

  ; theme
  (setq doom-theme 'doom-dracula)

  (setq display-line-numbers-type t)
  (setq-default line-spacing 1)

  ; doom-dashboard
  (setq fancy-splash-image "~/wallpapers/megumin_2.png") ;

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

  ; add missing paths to PATH
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

  ;; You don't want to disable the current line highlight
  ;; hl-line-mode overrides the color highlighting of `rainbow-mode'.
  ;; (add-hook! 'rainbow-mode-hook
  ;;   (hl-line-mode (if rainbow-mode -1 +1)))

  ;; rainbow-mode hook
  (defun my-rainbow-mode-hook ()
    (rainbow-mode 1))
  (add-hook! '(markdown-mode-hook org-mode-hook yaml-mode-hook) 'my-rainbow-mode-hook)

  ; Default directory for projectile
  (setq projectile-project-search-path '("~")))

(defsection keybinds
  "All my custom keybindings."

  (map! :map evil-motion-state-map "C-f" nil) ;; Remove previous keybinding
  (map! :map pdf-view-mode-map :n "C-f" nil)     ;; Remove previous keybinding
  (map! :nm "C-z" nil) ;; Remove when I stop using C-z to disable highlight star.
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

  (map! :map evil-normal-state-map "g b" #'browse-url))

(defsection magit
  "Git settings."

   (after! git-gutter
      (map! :n "M-j" 'git-gutter:next-hunk
            :n "M-k" 'git-gutter:previous-hunk
            :n "M-h" 'git-gutter:revert-hunk
            :n "M-l" 'git-gutter:stage-hunk
            :n "M-i" 'git-gutter:popup-hunk
            :leader :n "g p" 'git-gutter:popup-hunk))

   (setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     ")))

(defsection latex
  "LaTeX settings."

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
      "%`%l -interaction=nonstopmode -shell-escape %(mode)%' %t")))

(defsection haskell-mode
  "Haskell settings."

  ; https://github.com/projectional-haskell/structured-haskell-mode
  (remove-hook 'haskell-mode-hook 'structured-haskell-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
  ; http://haskell.github.io/haskell-mode/manual/latest/Interactive-Haskell.html#Interactive-Haskell
  (customize-set-variable 'haskell-process-auto-import-loaded-modules t)

  ;; It's bad because the replaced unicodes cannot be use in substitution of the original word.
  ;; For example, `map1 ∪ map2' won't compile
  ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-unicode-input-method) ;; unicode support

  ; `haskell-compile' use stack instead of cabal
  ; (setq haskell-compile-cabal-build-command "stack build")
  (setq haskell-interactive-popup-errors nil)
  (setq haskell-process-suggest-language-pragmas nil) ; haskell-interactive-mode only
  (setq lsp-lens-enable t)

  (after! smartparens
    (require 'smartparens-haskell))

  (use-package! ormolu
    ;; FIXME
    ;; :demand t
    ;; :hook (haskell-mode . ormolu-format-on-save-mode)
    ;; :bind
    ;; (:map haskell-mode-map
    ;;  ("C-c f" . ormolu-format-buffer))
    :config
    (setq ormolu-process-path "ormolu"))
  (map! :map haskell-mode-map :localleader :desc "format" "f" #'ormolu-format-buffer)

  ; ghcid
  (use-package! ghcid :after compile)
  (after! ghcid
    (map! :localleader
          :map haskell-mode-map
          :map haskell-cabal-mode-map
          :desc "ghcid: start" "g" #'ghcid
          :desc "ghcid: stop" "G" #'ghcid-stop))

  ; haskell-mode
  (map! (:after haskell-mode
         :map haskell-mode-map
          :localleader
          :desc "ghci: load file" "l" #'haskell-process-load-or-reload
          :desc "ghci: clear" "k" #'haskell-interactive-mode-clear
          :desc "ghci" "i" #'haskell-interactive-bring
          :desc "cabal command" "C" #'haskell-process-cabal ; arbitrary cabal command
          :desc "cabal: compile" "b" #'haskell-process-cabal-build ; faster than 'haskell-compile
          ; :desc "doc" "?" 'lsp-ui-doc-glance
          ; :desc "type" "t" 'haskell-process-do-type
          :desc "show doc" "t" '+lookup/documentation
          :desc "ghc: compile" "B" #'haskell-compile ; override
          ;; :desc "start hoogle" "" #'haskell-hoogle-start-server
          ;; :desc "stop hoogle" "" #'haskell-hoogle-kill-server
          :desc "hoogle" "h" #'haskell-hoogle
          :desc "local hoogle" "H" #'haskell-hoogle-lookup-from-local))

  ; lsp
  (use-package! lsp-haskell
    :ensure t
    :config
    (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper"))
  (after! lsp-mode
    (map! :map haskell-mode-map
          :localleader
            :desc "definition" "d" 'lsp-find-definition
            :desc "restart lsp" "r" 'lsp-restart-workspace)
    (setq lsp-ui-sideline-enable nil))

  ; hlint
  (use-package! hs-lint)
  (map! (:after hs-lint
         :map haskell-mode-map
         :localleader
           :desc "hlint" "?" #'hs-lint))

  ; flycheck
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
