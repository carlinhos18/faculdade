#include <iostream>

using namespace std;

void print_p(int num){
    cout << num << "=";
    int printed = 0;
    for(int i = 2; i * i <= num; i++){
        if(num % i == 0){
            if(printed == 0){
                cout << i;
                printed = 1;
            }else if(printed == 1){
                cout << "*" << i;
            }
            num /= i;
        }
    }
    if(num > 0){
        if(printed == 1){
            cout << "*";
        }
        cout << num;
    }
    cout << endl;
}

int main(){
    int N;
    cin >> N;
    for(int i = 0; i < N; i++){
        int num;
        cin >> num;
        print_p(num);
    }
    return 0;
}