;;; 安装vim模拟器:
(require-package 'evil)
(when (maybe-require-package 'evil)
  (evil-mode 1))

;; 安装vim搜索模拟器
(require-package 'evil-anzu)
(with-eval-after-load 'evil
  (require 'evil-anzu))

;; 匹配v/V选中的item, *向前匹配, #向后匹配
(require-package 'evil-visualstar)
(when (maybe-require-package 'evil-visualstar)
  (global-evil-visualstar-mode))

;; 安装主题
(require-package 'cyberpunk-theme)
;; Cyberpunk Theme
;; Grand Shell Theme
;; Ujelly Theme
(when (maybe-require-package 'cyberpunk-theme)
  (load-theme 'cyberpunk))

;; 保持主题颜色在终端下面时与软件下面一致
(require-package 'color-theme-approximate)
(when (maybe-require-package 'color-theme-approximate)
  (color-theme-approximate-on))

;; evil-leader
(require-package 'evil-leader)

;; 将搜索高亮保持到下一次搜索
(require-package 'evil-search-highlight-persist)
(global-evil-search-highlight-persist)
;; C-x SPX 清除高亮
(evil-leader/set-key "SPC" 'evil-search-highlight-persist-remove-all)

;; 显示当前文件函数列表,可以直接跳转,完全可配置,支持所有语言
;; 快捷键: M-'
(require-package 'imenu-list)
(global-set-key (kbd "C-'") #'imenu-list-smart-toggle)
(setq imenu-list-focus-after-activation t)
(setq imenu-list-after-jump-hook nil)
(add-hook 'imenu-list-after-jump-hook #'recenter-top-bottom)

;; 代码缩进提示线
;; (require-package 'highlight-indentation)
;; (when (maybe-require-package 'highlight-indentation)
;; (highlight-indentation-mode 1))

(require-package 'indent-guide)
(when (maybe-require-package 'indent-guide)
  (indent-guide-global-mode 1)
  ;; 延迟显示时间
  (setq indent-guide-delay 1)
  ;; 递归显示缩进线
  (setq indent-guide-recursive t))

;; 命令终端
;; (require-package 'vterm)

;; Customize ‘evil-undo-system’ for redo functionality. 处理

(require-package 'undo-tree)
(when (maybe-require-package 'undo-tree)
  (global-undo-tree-mode)
  ( evil-set-undo-system 'undo-tree))

;; all-the-icons
(require-package 'all-the-icons)

;; tabbar
(require 'local-tab)

(require 'online-code-tsx)
(require 'online-code-vue)

(provide 'init-online-packages)
