# C言語プログラム開発環境
## 開発環境
### Compiler
#### Install
Installer：https://sourceforge.net/projects/mingw/files/<br>
1. 「Download Latest Version」click
1. mingw-get-setup.exe 実行
1. セキュリティの警告 「実行」
1. 「Install」
1. 「Continue」
1. 「mingw32-base」click「Mark for Installation」でマーク
1. 「mingw32-gcc-g++」click「Mark for Installation」でマーク
1. 「msys-base」click「Mark for Installation」でマーク
1. Menu「Installation」→「Apply Changes」
1. 「Apply」
1. 「C:\MinGW\bin」へ gcc を配備したことを確認
1. 「C:\MinGW\msys\1.0\bin」へ make を配備したことを確認

#### Setting
1. 環境変数「PATH」に「C:\MinGW\bin」を追加
1. 環境変数「PATH」に「C:\MinGW\msys\1.0\bin」を追加

### Editor・Builder・Debugger：Visual Studio Code
#### Install
https://code.visualstudio.com/<br>

#### Setting
「」内は VS Code 拡張機能名
1. Build・Debug<br>
    + 「C/C++」<br>
    追加エラーとなる場合、<br>
    [cpptools-win32.vsix](https://github.com/Microsoft/vscode-cpptools/releases) を
    拡張機能の「…」→「VSIXからのインストール」から追加
    + 「Runner」<br>
    crun_gcc.bat を「C:/VisualCodeRunner/」へ配備し、<br>
    「ファイル」→「基本設定」→「設定」から下記を追加<br>
        ```command
        "runner.languageMap": {
            "c":"C:/VisualCodeRunner/crun_gcc.bat"
        },
        ```

1. Document
    + 「Doxygen Documentation Generator」：コメント入力補完に必要
    + 「vscode-pdf」：pdfの参照に必要
    + 「Auto-Open Markdown Preview」：mdファイルの参照に必要
    + 「PlantUML」：PlantUMLファイルの参照に必要<br>
    ＋[Graphviz](https://www.graphviz.org/download/) - Stable 2.38 Windows install packages - graphviz-2.38.msi<br>
    ＋Java

1. Other
    + AutoEncode：文字コード自動判別<br>
    「ファイル」→「基本設定」→「設定」から下記を追加<br>
        ```command
        "files.autoGuessEncoding": true,
        ```
    + 「GitLens」：修正履歴を見やすくする
    + 「vscode-icons」：アイコンを見やすくする
    + 「Markdown All in One」：mdファイル作成支援
    + 「AutoComplate shell」：shell script 開発支援

## 開発方法
### Install 状況確認方法
1. Visual Studio Code 起動
1. フォルダを開く「.vscode」の１つ上のフォルダ選択
1. [Ctrl]+[Shift]+[B] → "version"<br>
→ version.log に保存した各種ツールのバージョン情報を確認

### Build 方法
1. Visual Studio Code 起動
1. フォルダを開く「.vscode」の１つ上のフォルダ選択
1. [Ctrl]+[Shift]+[B] → "build"<br>
→ exeができることを確認

### 実行方法
1. Visual Studio Code 起動
1. フォルダを開く「.vscode」の１つ上のフォルダ選択
1. [Ctrl]+[Shift]+[C] → コマンドプロンプト起動<br>
1. プログラム実行
    ```command
    C:\workspaceFolder>program.exe
    [command line info]: program.exe
    ```
1. プログラム実行結果確認
    ```command
    C:\workspaceFolder>echo %ERRORLEVEL%
    0
    ```

### 修正方法
1. main.cを修正<br>
※コメント補完は関数の前に「/**」と入力して[Enter]

### Debug 方法
1. Visual Studio Code 起動
1. フォルダを開く「.vscode」の１つ上のフォルダ選択
1. main.c内にブレイクポイント設定 → [F5]<br>
→ ブレイクポイントで停止することを確認
1. [F10]<br>
→ ステップ実行できることを確認
