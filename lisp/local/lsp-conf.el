;; ========================
;; 专门针对 Vue 开发的配置
;; ========================
;; 安装前提：
;; 1. npm install -g @vue/language-server typescript typescript-language-server

;; ========================
;; Vue 语言服务器优化配置
;; ========================

;; Vue 单文件组件支持
(use-package vue-mode
  :ensure t
  :mode "\\.vue\\'"
  :config
  ;; Vue 文件的专用缩进设置
  (setq vue-html-tab-width 2
        vue-script-tab-width 2
        vue-style-tab-width 2
        vue-indent-tabs-mode nil)
  ;; 确保 vue-mode-map 存在
  (defvar vue-mode-map (make-sparse-keymap)
    "Keymap for Vue mode."))

;; ========================
;; Volar 语言服务器核心配置
;; ========================
(use-package lsp-mode
  :ensure t
  ;; 仅针对 Vue 文件的 LSP
  :hook ((vue-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :init
  ;; Vue 专用快捷键前缀
  (setq lsp-keymap-prefix "C-c l")
  ;; Vue 项目性能优化
  (setq lsp-idle-delay 0.5
        lsp-log-io nil
        lsp-completion-provider :capf
        lsp-file-watch-threshold 2000
        lsp-auto-guess-root t)
  ;; Volar 特定配置（Vue 3）
  (setq lsp-volar-auto-complete-refs t
        lsp-volar-check-js t
        lsp-volar-use-pnpm nil
        lsp-volar-take-over-mode t
        lsp-volar-prefer-tabs nil
        lsp-volar-indent-script-and-style t)
  :config
  ;; 显示加载 lsp-mode
  (require 'lsp-mode)
  ;; 注册 TypeScript 语言服务器
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("typescript-language-server" "--stdio"))
    :activation-fn (lsp-activate-on "typescript")
    :server-id 'typescript-language-server))

  ;; 注册 Volar 语言服务器
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("vue-language-server" "--stdio"))
    :activation-fn (lsp-activate-on "vue")
    :server-id 'volar))
  )

;; ========================
;; Vue 专用 UI 增强
;; ========================

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  ;; Vue 模板中更好的文档显示
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-doc-max-height 12)
  (lsp-ui-doc-max-width 70)
  (lsp-ui-doc-enable t)
  
  ;; 侧边栏优化 Vue 体验
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-delay 0.3))

;; ========================
;; Vue 专用补全配置
;; ========================

(use-package company
  :ensure t
  :hook (vue-mode . company-mode)
  :custom
  ;; Vue 组件名补全优化
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.2)
  (company-tooltip-limit 12)
  (company-selection-wrap-around t))

;; ========================
;; Vue 格式化专用配置
;; ========================

(use-package prettier
  :ensure t
  :hook (vue-mode . prettier-mode)
  :custom
  ;; Vue 格式化专用参数
  (prettier-js-args '("--single-quote" "true"
                      "--tab-width" "2"
                      "--vue-indent-script-and-style" "false")))

;; ========================
;; Vue 专用导航和符号搜索
;; ========================

(use-package lsp-ivy
  :ensure t
  :commands (lsp-ivy-workspace-symbol))

;; ========================
;; Vue 专用开发工具
;; ========================

;; Vue 模板内标签补全和展开
(use-package emmet-mode
  :ensure t
  :hook (vue-mode . emmet-mode)
  :config
  ;; Vue 模板专用配置
  (setq emmet-expand-jsx-className? t))

;; ========================
;; Vue 项目智能检测
;; ========================

(defun my-vue-project-p ()
  "检测当前项目是否为 Vue 项目"
  (when-let ((root (locate-dominating-file default-directory "package.json")))
    (let ((pkg-file (expand-file-name "package.json" root)))
      (when (file-exists-p pkg-file)
        (with-temp-buffer
          (insert-file-contents pkg-file)
          (goto-char (point-min))
          (or (re-search-forward "\"vue\"" nil t)
              (re-search-forward "\"@vue/cli-service\"" nil t)
              (re-search-forward "\"vite\"" nil t)
              (re-search-forward "\"nuxt\"" nil t)))))))

;; ========================
;; Vue 专用开发辅助函数
;; ========================

(defun my-insert-vue-component (name)
  "快速插入 Vue 组件模板"
  (interactive "M组件名: ")
  (insert (format "<template>
  <div class=\"%s\">
    
  </div>
</template>

<script setup>
defineProps({
  // 组件属性
})
</script>

<style scoped>
.%s {
  /* 组件样式 */
}
</style>" name name)))

;; ========================
;; Vue 开发环境诊断
;; ========================

(defun my-check-vue-environment ()
  "检查 Vue 开发环境配置"
  (interactive)
  (message "=== Vue 开发环境检查 ===")
  (message "1. vue-mode: %s" (if (featurep 'vue-mode) "已加载" "未加载"))
  (message "2. LSP 状态: %s" (if (bound-and-true-p lsp-mode) "已启用" "未启用"))
  (message "3. Vue 项目检测: %s" (if (my-vue-project-p) "是" "否"))
  
  ;; 检查语言服务器
  (let ((volar (executable-find "vue-language-server"))
        (ts-server (executable-find "typescript-language-server")))
    (message "4. Volar 语言服务器: %s" (if volar "已安装" "未安装"))
    (message "5. TypeScript 语言服务器: %s" (if ts-server "已安装" "未安装")))
  
  (message "======================"))

;; ========================
;; 快捷键配置（修复版）
;; ========================

;; Vue 专用快捷键
(global-set-key (kbd "C-c v r") 'lsp-rename)
(global-set-key (kbd "C-c v f") 'lsp-format-buffer)
(global-set-key (kbd "C-c v a") 'lsp-execute-code-action)
(global-set-key (kbd "C-c v d") 'lsp-ui-doc-show)
(global-set-key (kbd "C-c v g") 'lsp-find-definition)
(global-set-key (kbd "C-c v R") 'lsp-find-references)

;; Vue 文件打开时设置模式特定的快捷键
(add-hook 'vue-mode-hook
          (lambda ()
            ;; 确保键映射存在
            (unless (keymapp vue-mode-map)
              (define-key vue-mode-map (kbd "C-c C-v i") 'my-insert-vue-component) ; 插入模板
              (define-key vue-mode-map (kbd "C-c C-v c") 'my-check-vue-environment)
              (define-key vue-mode-map (kbd "C-c C-v f") 'prettier) ; 格式化
              (define-key vue-mode-map (kbd "C-c C-v d") 'lsp-ui-doc-show) ; 查看文档
              (define-key vue-mode-map (kbd "C-c C-v i") 'lsp-ui-imenu) ; 组建大纲
              (define-key vue-mode-map (kbd "C-c C-v e") 'emmet-expand-line) ; 展开模板
              (define-key vue-mode-map (kbd "M-.") 'lsp-find-definition) ;跳转定义
              (define-key vue-mode-map (kbd "M-,") 'pop-tag-mark)))) ; 返回
;; ========================
;; Vue 开发性能优化
;; ========================

;; 仅在 Vue 项目中应用性能优化
(add-hook 'vue-mode-hook
          (lambda ()
            (when (my-vue-project-p)
              ;; 增加 GC 阈值以避免 Vue 项目中的卡顿
              (setq-local gc-cons-threshold (* 100 1024 1024))
              ;; 增加读取输出大小
              (setq-local read-process-output-max (* 1024 1024))
              ;; 延迟 LSP 初始化
              (setq-local lsp-idle-delay 0.8))))

;; Vue 文件保存时自动格式化
(add-hook 'vue-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'prettier nil t))
          )

(provide 'lsp-conf)
