;;;; font-set_begin

;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("45631691477ddee3df12013e718689dafa607771e7fd37ebc6c6eb9529a8ede5"
     default))
 '(package-selected-packages
   '(all-the-icons company dashboard doom-themes dracula-theme
		   good-scroll highlight-symbol lsp-treemacs
		   monokai-theme org rainbow-delimiters rust-mode
		   smart-mode-line treemacs treemacs-projectile
		   use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Maple Mono NF CN" :foundry "outline" :slant normal :weight regular :height 102 :width normal)))))

;;;; font-set_end


;;;; normal
(setq comfirm-kill-emacs #'yes-or-no-p)
(electric-pair-mode t)
(column-number-mode t)


;;;; package-set-start

;;;use-melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;;use-package
(eval-when-compile
  (require 'use-package))


;;;good-scroll
(use-package good-scroll
  :ensure t
  :if window-system
  :init (good-scroll-mode))


;;;smart-mode-line
(use-package smart-mode-line
  :ensure t
  :init (sml/setup))


;;; dashboard
(use-package dashboard
 :ensure t
 :config
 (setq dashboard-banner-logo-title "Welcome to Emacs!") ;; 个性签名，随读者喜好设置
 ;; (setq dashboard-projects-backend 'projectile) ;; 读者可以暂时注释掉这一行，等安装了 projectile 后再使用
 (setq dashboard-startup-banner 'official) ;; 也可以自定义图片
 (setq dashboard-items '((recents . 5)  ;; 显示多少个最近文件
  (bookmarks . 5) ;; 显示多少个最近书签
  (projects . 10))) ;; 显示多少个最近项目
 (dashboard-setup-startup-hook))


;;;higulight-symbol
(use-package highlight-symbol
 :ensure t
 :init (highlight-symbol-mode)
 :bind ("<f5>" . highlight-symbol)) ;; 按下 F3 键就可高亮当前符号


;;;rainbow-delimiters
(use-package rainbow-delimiters
 :ensure t
 :hook (prog-mode . rainbow-delimiters-mode))


;;;company
(use-package company
 :ensure t
 :init (global-company-mode)
 :config
 (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
 (setq company-tooltip-align-annotations t)
   (setq company-idle-delay 0.0)
 (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
 (setq company-selection-wrap-around t)
 (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序，读者如果不喜欢可以去掉


;;;load-theme

;(load-theme 'dracula t)

(use-package doom-themes
 :ensure t
 :config
 ;; Global settings (defaults)
 (setq doom-themes-enable-bold nil  ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
 (load-theme 'doom-monokai-octagon t)
 (doom-themes-treemacs-config))

;;;all-the-icon
(use-package all-the-icons
 :if (display-graphic-p))

;;;mode-line

(use-package smart-mode-line
 :ensure t
 :init
 ; (setq sml/no-confirm-load-theme t) ; avoid asking when startup
 (sml/setup)
 :config
 (setq rm-blacklist
  (format "^ \\(%s\\)$"
   (mapconcat #'identity
    '("Projectile.*" "company.*" "Google"
  "Undo-Tree" "counsel" "ivy" "yas" "WK")
     "\\|"))))

;;;treemacs
(use-package treemacs
 :ensure t
 :defer t
 :config
 (treemacs-tag-follow-mode)
 :bind
 (:map global-map
    ("M-0"    . treemacs-select-window)
    ("C-x t 1"  . treemacs-delete-other-windows)
    ("C-x t t"  . treemacs)
    ("C-x t B"  . treemacs-bookmark)
    ;; ("C-x t C-t" . treemacs-find-file)
    ("C-x t M-t" . treemacs-find-tag))
 (:map treemacs-mode-map
	("/" . treemacs-advanced-helpful-hydra)))

(use-package treemacs-projectile
 :ensure t
 :after (treemacs projectile))

(use-package lsp-treemacs
 :ensure t
 :after (treemacs lsp))
