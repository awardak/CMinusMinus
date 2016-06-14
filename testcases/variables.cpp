
int main() {
    int longVariable;
    int anotherLongVariable123456789123456789;

    longVariable = 1;
    anotherLongVariable123456789123456789 = 2;

    int XXX;

    {
        cout << longVariable << endl;                           /* 1 */
        cout << anotherLongVariable123456789123456789 
             << endl;                                           /* 2 */

        int longVariable;
        longVariable = 111;
        cout << longVariable << endl;                           /* 111 */

        int aaa;
        aaa = 3;

        XXX = 5;
    }

    cout << longVariable << endl;                               /* 1 */
    /* cout << aaa;  */                 /* ERROR */
    cout << XXX << endl;                                        /* 5 */

    /* int longVariable; */             /* ERROR */

    /* aaa was used in nested block also */
    int aaa;
    aaa = 6;
    cout << aaa << endl;                                        /* 6 */
}