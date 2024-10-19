(require 'package)

;; package-archivesを上書き
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
	("org" . "https://orgmode.org/elpa/")
	("gnu" . "https://elpa.gnu.org/packages/")))

;; 所期化
(package-initialize)

;; use-packageがなかったら入れるようにする
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; skkの設定
(use-package ddskk
  :ensure t
  :custom
  (skk-sticky-key ";")
  (skk-large-jisyo "~/.cache/dein/nvim/repos/github.com/skk-dev/dict/SKK-JISYO.L")
  :bind (("C-x C-j" . skk-mode)))

; delete by <C-h>
(keyboard-translate ?\C-h ?\C-?)

