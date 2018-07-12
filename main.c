/**
 * @brief プログラムメイン
 * 
 * @file main.c
 * @author your name
 * @date 20XX-XX-XX
 */
#include <stdio.h>
/**
 * @brief ユーザー実行内容を表示するプログラムのエントリーポイント
 * 
 * @param argc 引数の数（argument count の略）
 * @param argv 引数文字列の配列（argument vector の略）
 * @return int プログラム終了コード
 */
int main(int argc, char const *argv[])
{
    /* 引数の数分ループ */
    for(int i = 0; i < argc; i++)
    {
        /* 標準出力：各引数文字列 */
        printf("[command line info]: %s\n", argv[i]);
    }
    /* プログラム終了コード返却 */
    return 0;
}
