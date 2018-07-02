# C言語プログラム開発環境
## 開発環境
### Compiler：MinGW(gcc)
#### Install
https://sourceforge.net/projects/mingw/files/  
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
1. 「C:\MinGW\bin」へgccを配備したことを確認

#### Setting
1. 環境変数「PATH」に「C:\MinGW\bin」を追加

### Editor・Builder・Debugger：Visual Studio Code
#### Install
https://code.visualstudio.com/<br>

#### Setting
1. Build・Debug<br>
参考サイト：https://gabekore.org/vscode-c-windows<br>
※Visual Studio 2015は使わないこと。<br>
    1. 「C/C++」<br>
追加エラーとなる場合、<br>
https://github.com/Microsoft/vscode-cpptools/releases<br>
から cpptools-win32.vsix を落とし、拡張機能の「…」から<br>
「VSIXからのインストール」でファイル選択して追加すること。   
    1. 「Runner」<br>
crun_gcc.batは00_environment内に作成済みです。  <br>

1. Document
    1. 「Doxygen Documentation Generator」：コメント入力補完に必要。
    2. 「vscode-pdf」：コーディング規約の参照に必要。
    3. 「Auto-Open Markdown Preview」：mdファイルの参照に必要。
    4. 「PlantUML」：PlantUMLファイルの参照に必要。

1. Other<br>
AutoEncode：https://qiita.com/ustakr/items/acad8dc12c166c2ad5e9
    1. 「GitLens」：修正履歴見やすくなる。（任意）
    2. 「vscode-icons」：アイコン見やすくなる。（任意）
    3. 「Markdown All in One」：mdファイル作成支援。（任意）

## 開発方法
### Build方法
1. Visual Studio Code 起動
1. フォルダを開く。00_environment選択
1. main.cを開く。
1. [Ctrl]+[Shift]+[B] → "build"<br>
→ main.exeができることを確認

### 修正方法
1. main.cを修正。
2. コメント補完は関数の前に「/**」と入力して[Enter]

### 実行方法
1. コマンドプロンプト起動<br>
[Win]+[R] → "cmd" → [Enter]
1. ディレクトリ移動
```command
C:\Users\UserName>cd "C:\C_LANG\00_environment"
```
1. プログラム実行
```command
C:\C_LANG\00_environment>main.exe
```
4. プログラム実行結果確認
```command
C:\C_LANG\00_environment>echo %ERRORLEVEL%
0
```

### Debug方法
1. main.c内にブレイクポイント設定 → [F5]<br>
→ ブレイクポイントで停止することを確認。
1. [F10]<br>
→ ステップ実行できることを確認。

