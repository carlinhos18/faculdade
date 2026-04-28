#include <iostream>
#include <set>

using namespace std;

int main() {
    int A, B;
    multiset<int> mul1, mul2;


    cin >> A;
    for(int i = 0; i < A; i++){
        int num;
        cin >> num;
        mul1.insert(num);
    }


    cin >> B;
    for(int i = 0; i < B; i++){
        int num;
        cin >> num;
        mul2.insert(num);
    }


    while(!mul1.empty() && !mul2.empty()){
        int card_1 = *mul1.rbegin(); 
        int card_2 = *mul2.rbegin(); 

        mul1.erase(prev(mul1.end()));
        mul2.erase(prev(mul2.end()));

        if(card_1 > card_2){
            mul1.insert(card_1 - card_2);
        } else if(card_2 > card_1){
            mul2.insert(card_2 - card_1);
        }
    }


    if(mul1.empty() && !mul2.empty()){
        cout << "Bob wins\n" << mul2.size() << endl;
    } else if(mul2.empty() && !mul1.empty()){
        cout << "Alice wins\n" << mul1.size() << endl;
    } else {
        cout << "Tie\n0\n";
    }

    return 0;
}
