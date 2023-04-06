(add-to-list 'load-path (expand-file-name "lisp/local" user-emacs-directory))


;; 安装melpa插件或设置设置melpa插件默认配置
(require 'init-online-packages)

;; 显示时间
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)


;; 显示行号
(global-linum-mode t)


;; 显示行列
(setq column-number-mode t)


;; "Font `tty' is not defined
(setq desktop-restore-frames nil)
;; 自动保存/恢复编辑环境
;; 不自动恢复编辑环境使用 emacs --no-desktop
(desktop-save-mode 1)


(define-key global-map [C-@] 'set-mark-command)
(setq default-tab-width 2)
(setq c-basic-offset 4)
(setq tab-width 2)
(setq scroll-step 1 scroll-margin 2 scroll-conservatively 10000)

;; tabbar
(require 'awesome-tab)
(awesome-tab-mode t)
(setq awesome-tab-height 120)
(setq awesome-tab-display-icon nil)
(custom-set-variables
 '(awesome-tab-dark-selected-background-color "white")
 '(awesome-tab-dark-selected-foreground-color "dark magenta")
)


;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)
;; use xsel to copy/paste in emacs-nox
(unless window-system
  (when (getenv "DISPLAY")
    (defun xsel-cut-function (text &optional push)
      (with-temp-buffer
        (insert text)
        (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")
      )
    )
    (defun xsel-paste-function ()
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
        (unless (string= (car kill-ring) xsel-output) xsel-output)
      )
      )
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)
  )
)


(provide 'init-local)
