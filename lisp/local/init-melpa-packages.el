;; 安装melpa插件或设置设置melpa插件默认配置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 启用vim模式
(require-package 'evil)
;; vim搜索模式
(require-package 'evil-anzu)


(when (maybe-require-package 'evil)
  (evil-mode 1))

;; [vim搜索模式] 启用evil的evil-anzu插件
(with-eval-after-load 'evil
  (require 'evil-anzu))


(provide 'init-melpa-packages)
