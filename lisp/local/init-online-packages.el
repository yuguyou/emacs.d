;; 安装melpa插件或设置设置melpa插件默认配置
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes

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
;; (require-package 'color-theme-approximate)
;; (when (maybe-require-package 'color-theme-approximate)
;; (color-theme-approximate-on))

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

;; jsx 语法解析
;; (require-package 'rjsx-mode)

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
(require-package 'vterm)

;; tide: TypeScript Interactive Development Environment for Emacs
;; Typescript
(require-package 'company)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; web-mode 语法解析
(require-package 'web-mode)
(when (maybe-require-package 'web-mode)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

;; TSX
(require-package 'tide)
(require-package 'flycheck)
(flycheck-mode +1)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)
(setq tide-tsserver-executable "node_modules/typescript/bin/tsserver")

;;javascript
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

;; JSX
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; configure jsx-tide checker to run after your default jsx checker
(flycheck-add-mode 'javascript-eslint 'web-mode)
;;(flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)

(require-package 'use-package)
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))
(provide 'init-online-packages)
