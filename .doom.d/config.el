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

  (setq user-full-name "Arnau Abella"               ; Used by gpg and others.
        user-mail-address "arnauabella@gmail.com"
        auth-sources '("~/.authinfo.gpg" "~/.emacs.d/.local/cache/org-gcal/tolen.gpg")
        auth-source-cache-expiry nil)               ; default is 7200 (2h)

  (setq doom-font (font-spec :family "hasklig" :size 14 :weight 'regular )
        doom-variable-pitch-font (font-spec :family "hasklig" :size 14 :weight 'regular) ;; e.g. neotree font
        doom-unicode-font (font-spec :family "hasklig" :size 14)
        doom-big-font (font-spec :family "hasklig" :size 20 :weight 'regular)) ; doom-big-font-mode

  (setq-default line-spacing 1
                major-mode 'org-mode) ; default major mode

  (setq evil-want-fine-undo t         ; Be more granular with changes (don't aggregate).
        truncate-string-ellipsis "…"  ; Unicode ellipsis > "..."
        display-line-numbers-type t)

  (defun doom-modeline-conditional-buffer-encoding ()
    "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
    (setq-local doom-modeline-buffer-encoding
                (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                            (eq buffer-file-coding-system 'utf-8)))))

  (add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

  ; default buffer name
  (setq doom-fallback-buffer-name "► Doom"
        +doom-dashboard-name "► Doom")

  ;; (display-time-mode 1)
  ;; (unless (equal "Battery status not available"
  ;;                (battery))
  ;;   (display-battery-mode 1))

  ; theme
  (setq doom-theme 'sanityinc-tomorrow-bright)

  ; windows
  (setq evil-vsplit-window-right t
        evil-split-window-below t) ; when split, move to the window

  ; After split, prompt for buffer
  (defadvice! prompt-for-buffer (&rest _)
    :after '(evil-window-split evil-window-vsplit)
    (+ivy/switch-buffer))

  (setq +ivy-buffer-preview t) ; preview buffer before jump

  ; doom-dashboard
  (setq fancy-splash-image "~/.doom.d/splash.png") ;

  ;; (map! :n [mouse-8] #'better-jumper-jump-backward
  ;;       :n [mouse-9] #'better-jumper-jump-forward)


  ; Keychain saves the agents' environment variables to files inside ~/.keychain/, so that subsequent shells can source these files.
  ; When Emacs is started under X11 and not directly from a terminal these variables are not set.
  (keychain-refresh-environment)

  ; This sets $MANPATH, $PATH and exec-path from your shell, but only when executed in a GUI frame on OS X and Linux.
  (when (memq window-system '(mac ns x))
        (exec-path-from-shell-initialize)) ; module exec-path-from-shell

  ; Adds `npm bin' to exec-path
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
         :desc "truncate lines" "L" #'toggle-truncate-lines
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
    (setq which-key-show-early-on-C-h nil)
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

  (setq projectile-auto-discover nil) ; disable auto discover
  (setq projectile-project-search-path '("~/projects/" )))

(defsection keybinds
  "All my custom keybindings."

  (map! :map evil-motion-state-map "C-f" nil) ;; Remove previous keybinding

  (defun my-pdf-view-hook ()
    (map! :map pdf-view-mode-map :n "C-f" nil))
  (add-hook! 'pdf-view-mode-hook 'my-pdf-view-hook)

  (map! :nm "C-z" nil) ;; Remove when I stop using C-z to disable highlight star.
  (map! :map global-map "C-z" nil) ;; Remove when I stop using C-z to disable highlight star.
  (map! :n "M-]" 'evil-window-increase-width
        :n "M-[" 'evil-window-decrease-width
        :n "M-=" 'evil-window-decrease-height
        :n "M-'" 'evil-window-increase-height)

  (map! :map pdf-view-mode-map
        :n "TAB" 'pdf-outline)

  (map! "C-f" #'+neotree/open)
  (map! "C-s" #'+neotree/find-this-file)

  (map! :desc "Paste in insert mode" :i "C-v" #'clipboard-yank)

  ; https://github.com/redguardtoo/evil-nerd-commenter
  (map! :nv "gc" #'evilnc-comment-or-uncomment-lines)
  (map! :nv "gC" #'evilnc-copy-and-comment-lines)

  ; https://github.com/hlissner/doom-emacs/blob/8284f1035bb9366cfa050ab787ca794008f263bc/modules/config/default/%2Bemacs-bindings.el#L22
  (map! :leader
        (:prefix-map ("o" . "open")
         :desc "vterm in a new workspace"
         "t" (cmd! (+workspace/new "vterm" nil)
                   (+vterm/here nil))))
  (after! vterm
    (map! :map vterm-mode-map :i "C-v" #'vterm-yank))

  (map! :map evil-normal-state-map "g b" #'browse-url))

(defsection company-mode
  "Completition."

  (after! haskell-mode
    (set-company-backend! 'haskell-mode '(company-capf :with company-yasnippet))))

(defsection spelling
  "spell-fu, ispell, aspell"

  (after! ispell
    (setq ispell-program-name "aspell")
    (setq ispell-dictionary "en")))

(defsection atomic-chrome
  "Edit text areas of the browser in Emacs."
  ; FIXME
  ;; (after! atomic-chrome
  ;;   (atomic-chrome-start-server))
  (atomic-chrome-start-server))

(defsection yasnippets
  "Snippets."

  (after! yasnippet
    (setq +snippets-dir "/home/arnau/dotfiles/snippets/"))

  (map! :leader
        (:when (featurep! :editor snippets)
         (:prefix-map ("y" . "yasnippets")
          :desc "new"            "n" #'+snippets/new
          :desc "edit"           "e" #'+snippets/edit
          :desc "file"           "f" #'yas/visit-snippet-file
          :desc "abort"          "a" #'+snippet--abort
          :desc "insert"         "i" #'yas-insert-snippet
          :desc "aya-create"     "c" #'aya-create
          :desc "aya-expand"     "C" #'aya-expand
          :desc "describe table" "t" #'yas/describe-tables
          :desc "tryout snippet" "T" #'yas/tryout-snippet))))

(defsection flycheck
  "Syntax checker on esteroids."

  ; All available checkers: `flycheck-checkers'
  (after! flycheck
    (setq global-flycheck-mode nil)
    (setq flycheck-global-modes nil)
    (setq flycheck-check-syntax-automatically '(mode-enabled idle-change)) ;; save idle-change))
    ; append is also ok (concat is only for strings)
    (add-to-list 'flycheck-disabled-checkers '( markdown-markdownlint-cli markdown-mdl ))))

(defsection magit
  "Git settings."

   (after! git-gutter
      (map! :n "M-j" 'git-gutter:next-hunk
            :n "M-k" 'git-gutter:previous-hunk
            :n "M-h" 'git-gutter:revert-hunk
            :n "M-l" 'git-gutter:stage-hunk
            :n "M-i" 'git-gutter:popup-hunk
            :leader :n "g p" 'git-gutter:popup-hunk))

   ;(use-package! magithub
     ;:after magit
     ;:config
     ;(magithub-feature-autoinject t)
     ;(setq magithub-clone-default-directory "~/haskell/"))

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

  ;; FIXME The command is called with call-process and arguments are not accepted
  ;; (setq pdf-latex-command "\"pdflatex --synctex=1\"") ; --synctex=1 to be able to jump to sources

  (after! latex
    (setf (nth 1 (assoc "LaTeX" TeX-command-list))
      "%`%l -interaction=nonstopmode -shell-escape %(mode)%' %t")))

(defsection lsp
  "Language Server Protocol."

  ; FIXME this is a workaround for +lookup/documentation poping two windows.
  (after! lsp-mode
    (map! :map lsp-mode-map
          :n "K" #'lsp-describe-thing-at-point
          ))

  (after! lsp-ui
    (setq lsp-ui-sideline-enable         nil
            lsp-ui-doc-include-signature   t
            lsp-ui-doc-max-height          15
            lsp-ui-doc-max-width           150
            lsp-ui-doc-position            'at-point
            lsp-ui-peek-always-show        t
            lsp-ui-peek-fontify            'always)))

(defsection nix-mode
  "Nix."
  (after! nix-mode
    (map! :localleader
          :map nix-mode-map
          ; Really slow if pressed by accident nix-update-fetch
          "f" #'nix-format-buffer)))

(defsection haskell-mode
  "Haskell."

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
  (setq lsp-lens-enable nil) ; bothersome after a while.

  (after! smartparens
    (require 'smartparens-haskell))

  (use-package! ormolu
    :config
    (setq ormolu-process-path "ormolu"))
  (map! :map haskell-mode-map :localleader :desc "format" "f" #'ormolu-format-buffer)

  ; ghcid
  (use-package! ghcid
    :after compile)
  (after! ghcid
    (map! :localleader
          (:map haskell-mode-map
           :desc "ghcid: start" "g" #'ghcid
           :desc "ghcid: stop" "G" #'ghcid-stop)
          (:map haskell-cabal-mode-map
           :desc "ghcid: start" "g" #'ghcid
           :desc "ghcid: stop" "G" #'ghcid-stop)))

  ; FIXME hoogle should query remote server, not local
  ; hoogle
  ; If the search doesn't output anything, you may need to run $ google generate

  ; haskell-mode
  (map! (:after haskell-mode
         :map haskell-mode-map
          :localleader
          :desc "ghci: load file" "l" #'haskell-process-load-file
          :desc "ghci: clear" "k" #'haskell-interactive-mode-clear
          :desc "ghci" "i" #'haskell-interactive-bring
          ;; :desc "find reference" "r" #'lsp-ui-peek-find-references ;; TODO not implemented in the LSP yet
          ;; :desc "cabal command" "C" #'haskell-process-cabal ; arbitrary cabal command
          :desc "cabal: compile" "b" #'haskell-process-cabal-build ; faster than 'haskell-compile
          ;; :desc "ghci process" "1" (lambda () (interactive) (setq haskell-process-type 'auto) (haskell-process-restart))
          :desc "cabal process" "1" (lambda () (interactive) (setq haskell-process-type 'cabal-repl) (haskell-process-restart))
          :desc "stack process" "2" (lambda () (interactive) (setq haskell-process-type 'stack-ghci) (haskell-process-restart))
          :desc "doc" "t" 'lsp-ui-doc-glance
          ;; :desc "show doc" "t" '+lookup/documentation
          ;; :desc "type" "t" 'haskell-process-do-type
          ;; :desc "ghc: compile" "B" #'haskell-compile ; override
          ;; :desc "start hoogle" "" #'haskell-hoogle-start-server
          ;; :desc "stop hoogle" "" #'haskell-hoogle-kill-server
          :desc "hoogle (local)" "h" #'haskell-hoogle
          :desc "hoogle (web)" "H" #'haskell-hoogle-lookup-from-website)
        )

  (after! lsp-mode
    (map! :map haskell-mode-map
          :localleader
            :desc "restart lsp" "R" 'lsp-restart-workspace))

  (add-hook 'haskell-mode-hook ( lambda () (setq-default flycheck-disabled-checkers '(haskell-stack-ghc haskell-ghc haskell-hlint)) ))
  (defun haskell-mode-leave ()
    (when (eq major-mode 'haskell-mode)
      (setq-default flycheck-disabled-checkers '())))
  (add-hook 'change-major-mode-hook #'haskell-mode-leave)

  (map! :map haskell-mode-map
        :n "C-j" 'flycheck-next-error
        :n "C-k" 'flycheck-previous-error
        :n "M-n" 'next-error
        :n "M-p" 'previous-error
        :n "M-RET" 'flycheck-buffer))

(defsection rust-mode
  "Rust."
        (after! rustic
        (setq rustic-lsp-server 'rust-analyzer)))

(defsection cc-mode
  "C/C++."
  (after! ccls
    (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
    ; optional as ccls is the default in Doom
    (set-lsp-priority! 'ccls 2)))

(defsection python-mode
  "Python."

  ;; NOTE If you find yourself using a lot of pipenv, just uncomment these lines.
  ;;
  ;; (defun pipenv-projectile-lsp ()
  ;;   "Projectile will call pipenv-activate automatically."
  ;;   (pipenv-projectile-after-switch-default)
  ;;   (run-at-time 1.5 nil #'lsp-restart-workspace))
  ;; (setq pipenv-with-projectile t)
  ;; (setq pipenv-projectile-after-switch-function #'pipenv-projectile-lsp)

  (map! :map python-mode-map
        :localleader
        :desc "restart lsp" "r" 'lsp-restart-workspace)

  (setq ein:worksheet-enable-undo t)
  (customize-set-variable 'ein:output-area-inlined-images t))

(defsection lua-mode
  "Lua."

  (setq lsp-clients-lua-language-server-bin "/usr/bin/lua-language-server")
  (setq +lua-lsp-dir "/usr/share/"))

(defsection org-mode
  "Org."

  ;; Example of creating your own links
  ;; (defun make-youtube-link (youtube_id)
  ;;   (browse-url (concat "https://www.youtube.com/embed/" youtube_id)))
  ;; (org-add-link-type "my-yt" #'make-youtube-link)

  ;; Allow links to non-headlines parts of your document
  ;; (setq org-link-search-must-match-exact-headline nil)

  ;; (setq org-todo-keywords
  ;;     '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))

  (setq org-tag-alist '(("master" . ?m) ("personal" . ?p)))

  ; change priority labels colors
  ;; (setq org-priority-faces '( (?A :foreground "#E45649")
  ;;                             (?B :foreground "#da8548")
  ;;                             (?C :foreground "#0098dd")))

  (defun org-insert-src-block (src-code-type)
        "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
        (interactive
        (let ((src-code-types
                '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
                "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
                "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
                "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
                "scheme" "sqlite")))
        (list (ido-completing-read "Source code type: " src-code-types))))
        (progn
        (newline-and-indent)
        (insert (format "#+BEGIN_SRC %s\n" src-code-type))
        (newline-and-indent)
        (insert "#+END_SRC\n")
        (previous-line 2)
        (org-edit-src-code)))

  ; org is loaded after this overriding all keybindings
  (map! (:map org-mode-map
         :localleader
         :n "C" #'org-insert-src-block))

  (if (featurep! :ui workspaces)
      (map! :leader
            :desc "calendar" "o c" (lambda () (interactive) (org-gcal-sync) (=calendar))))

  (after! org-fancy-priorities
    (setq org-fancy-priorities-list '((?A . "⚡")
                                      (?B . "⚡")
                                      (?C . "⚡"))))

  (after! org-gcal
    (setq org-gcal-client-id "476287550487-e5gdqkh7cbbvpc62f3rogq9dup63d98u.apps.googleusercontent.com"
          org-gcal-client-secret "AxH42LSZyd64bEKeHW_g-_RU"
          org-gcal-fetch-file-alist '( ("arnauabella@gmail.com" .  "~/Dropbox/org/schedule.org")
                                       ("uf9i2quiq9c81mrvpts2ftgu5i71e71p@import.calendar.google.com" . "~/Dropbox/org/schedule-master.org"))
          ))

  (setq org-gcal-up-days 60  ; fetch all events up to 5 months
        org-gcal-down-days 150)

  (add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))
  (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync) ))

  (after! org-capture
    (add-to-list 'org-capture-templates
          '("a" "Appointment" entry (file  "~/Dropbox/org/schedule.org" )
             "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")))

  ;; I prefer to pick all ~/Dropbox/org files
  ;; (setq org-agenda-files (list "~/Dropbox/org/schedule.org" "~/Dropbox/org/schedule-master.org"))

  (setq org-directory "/home/arnau/Dropbox/org/"))
