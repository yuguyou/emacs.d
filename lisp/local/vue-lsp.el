(use-package lsp-mode
  :ensure t
  :commands lsp
  ;; --- 修改 Hook: 使用 lsp-deferred 延迟启动，提高性能 ---
  ;; --- 修改 Hook: 移除 js-mode/css-mode/scss-mode，因为它们有自己的主模式 (typescript-mode, css-mode, scss-mode) ---
  ;; --- 修改 Hook: 保留 web-mode 用于 Vue，并添加 vue-mode (如果使用) ---
  :hook (
         ;; web-mode 用于 .vue 文件
         (web-mode . lsp-deferred)
         ;; 如果你安装并使用了专门的 vue-mode (来自 mmm-vue 或其他)，则用下面这行替换上一行
         ;; (vue-mode . lsp-deferred)
         ;; 为 JavaScript/TypeScript 文件启用 (注意 ts-mode, js-mode, js2-mode 等)
         (typescript-mode . lsp-deferred)
         (tsx-ts-mode . lsp-deferred)
         ;; (js-mode . lsp-deferred) ; js2-mode 通常更好
         (js2-mode . lsp-deferred)
         ;; 为 CSS/SCSS 文件启用
         (css-mode . lsp-deferred)
         (scss-mode . lsp-deferred)
         ;; 为 JSON 文件启用 (可选，取决于你的 LSP 服务器)
         ;; (json-mode . lsp-deferred)
         )
  :init
  ;; lsp-mode 现在默认使用 lsp-diagnostics，Flymake/Flycheck 集成需要额外配置
  ;; (setq lsp-prefer-flymake nil)

  ;; 推荐使用 capf，它允许 lsp-mode 通过 company-capf 与 company-mode 交互
  (setq lsp-completion-provider :capf)

  ;; 如果你主要处理 Vue 3 项目，推荐启用 takeover 模式
  (setq lsp-volar-take-over-mode t)
  ;; 对于 Vue 2 项目，可能需要禁用 takeover 模式
  ;; (setq lsp-volar-take-over-mode nil)

  ;; --- 新增设置: 其他有用的 LSP 配置 ---
  ;; 设置日志级别 (可选，用于调试)
  ;; (setq lsp-log-io t)
  ;; 禁用自动重启服务器 (可选，根据需要调整)
  ;; (setq lsp-restart 'auto-restart)
  ;; --- 移除: 不再需要 (require 'lsp-clients) ---
  ;; lsp-mode 现在自动管理客户端
  )

;; --- LSP UI (可选，提供悬浮提示、侧边栏等) ---
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode) ; 在 lsp-mode 启动时自动启用 lsp-ui
  :config
  ;; 配置 lsp-ui-doc (悬浮文档)
  (setq lsp-ui-doc-position 'bottom) ; 文档位置
  (setq lsp-ui-doc-max-height 8)    ; 最大高度
  (setq lsp-ui-doc-max-width 60)    ; 最大宽度
  ;; 配置 lsp-ui-sideline (侧边栏显示信息)
  (setq lsp-ui-sideline-show-hover t) ; 悬停时显示
  (setq lsp-ui-sideline-delay 0.5)    ; 延迟时间
  ;; 配置 lsp-ui-peek (跳转到定义时的预览)
  ;; (setq lsp-ui-peek-always-show t) ; 总是显示 Peek 窗口
  )

;; --- Web Mode for Vue Files ---
(use-package web-mode
  :ensure t
  :mode ("\\.vue\\'" . web-mode) ; 确保 .vue 文件用 web-mode 打开
  :config
  ;; 为 Vue 文件配置引擎
  (add-to-list 'web-mode-engines-alist '("vue" . "\\.vue\\'"))
  ;; 设置缩进
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  ;; 其他 web-mode 配置...
  )
;; --- Company (补全框架) ---
(use-package company
  :ensure t
  :init
  :config
  (global-company-mode)
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 1)
  (setq company-show-numbers nil)
  ;; lsp-mode 会自动将 lsp-capf 后端添加到 company-backends (在 lsp-mode 5.x+ 中)
  ;; 如果需要手动设置 (在某些旧版本或特殊配置下)，可以取消注释下面几行
  ;; (add-to-list 'company-backends 'company-capf)
  )

;; --- Company Box (美化 Company 补全菜单) ---
(use-package company-box
  :ensure t
  :if window-system
  :hook (company-mode . company-box-mode)
  ;; 如果 company-box 显示有问题，可以尝试添加 :config
  ;; :config
  ;; (setq company-box-doc-delay 0.2) ; 调整文档延迟
  )

;; --- 可选: 如果你更喜欢专门的 Vue 模式 (例如 mmm-vue) ---
;; (use-package mmm-vue
;;   :ensure t
;;   :mode ("\\.vue\\'" . vue-mode)
;;   :config
;;   ;; 可能需要额外配置以配合 lsp-mode
;;   )

(provide 'vue-lsp)
