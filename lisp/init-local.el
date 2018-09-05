(provide 'init-local)

(add-to-list 'load-path (expand-file-name "lisp/local" user-emacs-directory))

(require 'cygwin-mount)
(cygwin-mount-activate)

(require 'tabbar)
(tabbar-mode 1)
(evil-mode 1)
(global-set-key [(meta >)] 'tabbar-forward)
(global-set-key [(meta L)] 'tabbar-backward)
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
                    :background "gray"
                    :foreground "gray30")
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :background "green"
                    :box '(:line-width 3 :color "DarkGoldenrod") )
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 3 :color "gray"))

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
