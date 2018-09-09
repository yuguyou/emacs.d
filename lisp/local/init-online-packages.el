;; 安装melpa插件或设置设置melpa插件默认配置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
; Cyberpunk Theme
; Grand Shell Theme
; Ujelly Theme
(when (maybe-require-package 'cyberpunk-theme)
  (load-theme 'cyberpunk))


;; 保持主题颜色在终端下面时与软件下面一致
(require-package 'color-theme-approximate)
(when (maybe-require-package 'color-theme-approximate)
  (color-theme-approximate-on))





(provide 'init-online-packages)
