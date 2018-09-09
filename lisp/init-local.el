(add-to-list 'load-path (expand-file-name "lisp/local" user-emacs-directory))


;; 安装melpa插件或设置设置melpa插件默认配置
(require 'init-online-packages)


;; tab标签插件
(require 'tabbar)
(tabbar-mode 1)
;; 配置切换tab快捷键
(global-set-key [(C-next)] 'tabbar-forward)
(global-set-key [(C-prior)] 'tabbar-backward)
; close default tabs，and move all files into one group
(setq tabbar-buffer-list-function
    (lambda ()
        (remove-if
          (lambda(buffer)
             (find (aref (buffer-name buffer) 0) " *"))
          (buffer-list))))
(setq tabbar-buffer-groups-function
      (lambda()(list "All")))
(set-face-attribute 'tabbar-button nil)

;;set tabbar's backgroud color
(set-face-attribute 'tabbar-default nil
                    :background "#333333"
                    :foreground "#eeeeee")

(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "gray30"))

(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :background "#36fe4f"
                    :box '(:line-width 1 :color "#36fe4f"))

;; USEFUL: set tabbar's separator gap
(custom-set-variables '(tabbar-separator (quote (1.5))))
(put 'scrol-left 'disabled nil)


;; 显示时间
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)


;; 显示行号
(global-linum-mode t)


;; 显示行列
(setq column-number-mode t)

(define-key global-map [C-@] 'set-mark-command)
(setq default-tab-width 2)
(setq c-basic-offset 4)
(setq tab-width 2)
(setq scroll-step 1 scroll-margin 2 scroll-conservatively 10000)


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
