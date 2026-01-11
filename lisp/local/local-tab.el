;; ========================
;; tabbar 配置
;; ========================

(require 'awesome-tab)
(awesome-tab-mode t)
(when (not (display-graphic-p))
  (setq frame-background-mode 'dark))

;; 绑定切换快捷键 (示例)
(with-eval-after-load 'awesome-tab
  ;; 可见标签页循环
  (define-key awesome-tab-mode-map (kbd "C-M-<left>") 'awesome-tab-backward-tab) ; 绑定到 C-M-Left (home)
  (define-key awesome-tab-mode-map (kbd "C-M-<right>") 'awesome-tab-forward-tab) ; 绑定到 C-M-Right (end)

  ;; 基础循环
  (define-key awesome-tab-mode-map (kbd "C-M-<prior>") 'awesome-tab-backward) ; C-M-Prior (PageUp)
  (define-key awesome-tab-mode-map (kbd "C-M-<next>")  'awesome-tab-forward)  ; C-M-Next (PageDown)

  ;; 标签组循环
  (define-key awesome-tab-mode-map (kbd "C-M-S-<prior>") 'awesome-tab-backward-group) ; C-M-Shift-Prior (PageUp)
  (define-key awesome-tab-mode-map (kbd "C-M-S-<next>")  'awesome-tab-forward-group)  ; C-M-Shift-Next (PageDown)
  )

;; 显示图标（可选，需要 all-the-icons 包）
(setq awesome-tab-display-icon t)

;; 设置标签最大长度（可选）
;; (setq awesome-tab-label-max-length 20)

(provide 'local-tab)
