# 使用手册
## 安装与初始化:
* 最新包下载
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

## 使用
### 常用快捷键




### 常用插件

