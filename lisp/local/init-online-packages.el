;; 安装melpa插件或设置设置melpa插件默认配置 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; 安装vim模拟器
(require-package 'evil)
;; 启用vim模式
(when (maybe-require-package 'evil)
  (evil-mode 1))


;; 安装vim搜索模拟器
(require-package 'evil-anzu)
;; [vim搜索模式] 启用evil的evil-anzu插件
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
;; 使用
;;   M-x imenus-mode-buffers
;;   M-x imenus
(require-package 'imenu)


;; jsx 语法解析
;; (require-package 'rjsx-mode)


(provide 'init-online-packages)
