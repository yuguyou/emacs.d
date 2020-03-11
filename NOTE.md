# 使用手册
## 安装与初始化:
> 官网：https://www.gnu.org/software/emacs/
---------------------------------

* 最新EMACS安装包下载
  - http://mirrors.ustc.edu.cn/gnu/emacs/
  - https://ftp.gnu.org/gnu/emacs/


* 安装方法
  - 解压包后见INSTALL流程

  ```
  $ ./configure
  $ make
  $ make install
  ```


* 卸载方法

  ```
  // 解压对应版本包后执行
  $ ./configure
  $ make
  $ make uninstall
  ```


* 初始化
> 新版本安装好后第一次启动emacs会自动初始化，时候化时候会下载默认插件，初始化时候会偶尔出现`elpa.gnu.org``melpa.gnu.org`连接不上的情况，隔段时间会恢复。

* 在命令行打开emacs命令设置
  - 在.bashrc添加

  ```
  alias emacs="emacs -nw"
  ```


* 获取当前可用的所有扩展插件列表

```
// 进入ELPA插件列表: EMACS官方扩展插件[elpa.gnu.org]
M-x package-install

// 进入MELPA插件列表: 知名的扩展插件聚集地[melpa.org/packages]
M-x package-list-packages

// 搜索插件名
C-s
```

* 使用主题
可到`emacsthemes.com`查看主题样式，然后通过`M-x package-list-packages`安装
```
(load-theme 'cyberpunk)
```


## 使用
-----------------------------------------


### 常用快捷键
/************************************/
C-h-h    查看帮助信息
C-h b    查看键值绑定信息 (重要)
C-h k    查看一个键值用法及源码
C-h o    查看一个变量或函数用法及源码
/************************************/
基本命令
C-x C-f   打开/新建文件
C-x C-s   保存当前缓冲区
C-x C-w   当前缓冲区另存为
C-x C-v   关闭当前Buffer并打开新文件
C-x i     光标处插入文件
C-x b     切换Buffer
C-x C-b   显示Buffer列表
C-x k     关闭当前Buffer
C-x C-c   关闭Emacs

/************************************/
窗口命令
C-x 0     关闭当前窗口
C-x 1     关闭其他窗口
C-x 2     水平分割窗格
C-x 3     垂直分割窗格
C-x o     切换窗口
C-x 5 2   新建窗口
C-x 5 f   新窗口中打开文件

/************************************/
光标移动命令
C-f       前进一个字符
C-b       后退一个字符
C-p       上一行
C-n       下一行
M-f       前进一个单词
M-b       后退一个单词
C-a       行首
C-e       行尾
C-v       下翻一页
M-v       上翻一页
M-<       文件头
M->       文件尾

/**********************************/
编辑命令
C-Space         设置开始标记
C-@             设置开始标记(C-space可能被操作系统拦截)
M-w             复制标记区内容
C-y             帖粘
M-u             使光标处的单词大写
M-l             使光标处的单词小写
M-c             使光标处单词首字母大写
C-k             删除一行



### 常用插件
#### evil
> vim模拟插件

##### vim常用快捷键
- 基本操作
```
Esc  从当前模式转换到“普通模式”。所有的键对应到命令。
i    “插入模式”用于插入文字。回归按键的本职工作。
:    “命令行模式” Vim 希望你输入类似于保存该文档命令的地方。
```

- 方向键
```
h   光标向左移动一个字符
j   或 Ctrl + J 光标向下移动一行
k   或 Ctrl + P 光标向上移动一行
l   光标向右移动一个字符
0   （数字 0）移动光标至本行开头
$   移动光标至本行末尾
^   移动光标至本行第一个非空字符处
w   向前移动一个词 （上一个字母和数字组成的词之后）
W   向前移动一个词 （以空格分隔的词）
5w  向前移动五个词
b   向后移动一个词 （下一个字母和数字组成的词之前）
B   向后移动一个词 （以空格分隔的词）
5b  向后移动五个词
G   光标移动至尾行
gg  光标移动至首行
```

- 浏览文档
```
(   跳转到上一句
)   跳转到下一句
{   跳转到上一段
}   跳转到下一段
[[  跳转到上一部分
]]  跳转到下一部分
[]  跳转到上一部分的末尾
][  跳转到上一部分的开头
```

- 插入文本
```
a   在光标后插入文本
A   在行末插入文本
i   在光标前插入文本
o   （小写字母 o）在光标下方新开一行
O   （大写字母 O）在光标上方新开一行
```

- 删除文本
```
x     删除光标处字符
dw    删除一个词
d0    删至行首
d$    删至行末
d)    删至句末
dgg   删至文件开头
dG    删至文件末尾
dd    删除该行
3dd   删除三行
```

- 复制/粘贴文本
```
yy      复制当前行至存储缓冲区
["x]yy  复制当前行至寄存器 x
p       在当前行之后粘贴存储缓冲区中的内容
P       在当前行之前粘贴存储缓冲区中的内容
["x]p   在当前行之后粘贴寄存器 x 中的内容
["x]P   在当前行之前粘贴寄存器 x 中的内容
```

- 撤销/重做操作
```
u       撤销最后的操作
Ctrl+r  重做最后撤销的操作
```

- 搜索和替换
```
/search_text  检索文档，在文档后面的部分搜索 search_text
?search_text  检索文档，在文档前面的部分搜索 search_text
n             移动到后一个检索结果
N             移动到前一个检索结果
:%s/original/replacement      检索第一个 “original” 字符串并将其替换成 “replacement”
:%s/original/replacement/g    检索并将所有的 “original” 替换为 “replacement”
:%s/original/replacement/gc   检索出所有的 “original” 字符串，但在替换成 “replacement” 前，先询问是否替换
```

- 选择文本
```
v     进入逐字可视模式
V     进入逐行可视模式
Esc   退出可视模式
```

- 改动选中文本
```
~   切换大小写
d   删除一个词
c   变更
y   复制
>   右移
<   左移
!   通过外部命令进行过滤
```

- 保存并退出
```
:q              退出 Vim，如果文件已被修改，将退出失败
:w              保存文件
:w new_name     用new_name作为文件名保存文件
:wq             保存文件并退出 Vim
:q!             退出 Vim，不保存文件改动
```

#### anzu
* 搜索时状态栏显示出当前匹配的item个数

#### evil-visualstar
* 匹配v/V选中的item, *向前匹配, #向后匹配

#### evil-search-highlight-persist
* 将搜索高亮保持到下一次搜索
* 用法:
```
(require-package 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)
;; C-x SPX 清除高亮
(evil-leader/set-key "SPC" 'evil-search-highlight-persist-remove-all)
```

#### color-theme-approximate
* 大多数Emacs主题在终端环境(使用emacs -nw会在终端环境下运行emacs)下都很糟糕. 几乎所有的主题都有这个问题. 不过这种情况可以通过安装 color-theme-approximate 这个package得到有效改善. 这个package将色彩转换为终端下的等价色. 安装好 color-theme-approximate 后,再将 (color-theme-approximate-on) 添加到你的 .emacs 配置中. 如果没有生效的话,试着把这一行的位置放后一点再试试.

#### vterm
* https://github.com/akermu/emacs-libvterm, 好用的命令终端

#### js2-mode
* javascript开发神器

#### rjsx-mode
* jsx 语法解析

#### imenu-list
* 显示当前文件函数列表,可以直接跳转,完全可配置,支持所有语言
```
;; 快捷键: M-'
(require-package 'imenu-list)
(imenu-list-minor-mode)
(global-set-key (kbd "C-'") #'imenu-list-smart-toggle)
(setq imenu-list-focus-after-activation t)
(setq imenu-list-after-jump-hook nil)
(add-hook 'imenu-list-after-jump-hook #'recenter-top-bottom)
```

#### web-mode
* 提供了很好的web配件（HTML、JavaScript、CSS、PHP等）的代码缩进、折叠和高亮等出色的功能。

#### highlight-indentation && indent-guide
* 代码缩进提示线

#### tide
* TypeScript Interactive Development Environment for Emacs
