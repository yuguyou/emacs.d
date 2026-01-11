;; web-mode 语法解析
(require-package 'web-mode)
(when (maybe-require-package 'web-mode)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

;; 使用prettier格式化代码
(require-package 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
          (funcall (cdr my-pair)))))
(add-hook 'web-mode-hook #'(lambda ()
                             (enable-minor-mode
                              '("\\.tsx?\\'" . prettier-js-mode))))

;; tide: TypeScript Interactive Development Environment for Emacs
(require-package 'tide)
(require-package 'flycheck)
(flycheck-mode +1)


;;;;;;;;;;;;;;;;;;;;;;;;; TS
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
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

;;;;;;;;;;;;;;;;;;;;;;;;;; TSX
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)
(setq tide-tsserver-executable "node_modules/typescript/bin/tsserver")

;;;;;;;;;;;;;;;;;;;;;;;;;; JS
(add-hook 'js2-mode-hook #'setup-tide-mode)
;; configure javascript-tide checker to run after your default javascript checker
;; 无法启动javascript-tide
;; (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

;;;;;;;;;;;;;;;;;;;;;;;;;; JSX
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; configure jsx-tide checker to run after your default jsx checker
(flycheck-add-mode 'javascript-eslint 'web-mode)
;; (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)
;; (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)
;;(use-package tide
;;  :ensure t
;;  :after (typescript-mode company flycheck)
;;  :hook ((typescript-mode . tide-setup)
;;         (typescript-mode . tide-hl-identifier-mode)
;;         (before-save . tide-format-before-save)))

(provide 'online-code-tsx)
