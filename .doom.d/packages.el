;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")

;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;(package! builtin-package :disable t)

(package! ghcid
  :recipe (:host github :repo "monadplus/ghcid"))

;; FIXME local is not updating WTF
;; (package! ghcid
;;   :recipe (:local-repo "~/elisp/ghcid/"))

(package! hlint
  :recipe (:local-repo "~/elisp/hs-lint/"))

(package! ormolu)
(package! keychain-environment) ; FIX the bug with keychain not found https://github.com/tarsius/keychain-environment
(package! magithub)
;; (package! iedit) ; included with multi-cursor

;; https://github.com/daichirata/emacs-rotate

;; https://github.com/Mstrodl/elcord

;; https://github.com/dandavison/delta/

;; TODO Not working
;; (package! doom-snippets :disable t)
(package! yasnippet-snippets)

;; requires +local
(package! agda-input
  :recipe (:host github
           :repo "agda/agda"
           :branch "release-2.6.1.2"
           :files ("src/data/emacs-mode/agda-input.el")
           :nonrecursive t))

(package! agda2-mode
  :recipe (:host github
           :repo "agda/agda"
           :branch "release-2.6.1.2"
           :files ("src/data/emacs-mode/*.el" (:exclude "agda-input.el"))
           :nonrecursive t))
