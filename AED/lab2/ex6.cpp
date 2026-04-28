#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

void print_res(vector<int> bakugans, int a , int b, int size){
    int res = 0;
    for(int i = a; i <= b; i++){
        res += bakugans[i]; 
    }
    cout << res << endl;

}


int main(){
    int N;
    cin >> N;
    vector<int> bakugans(N);
    for(int i = 0; i < N; i++){
        int num;
        cin >> num;
        bakugans[i] = num;
    }

    int P;
    cin >> P;
    int size = N-1;
    for(int i = 0; i < P; i++){
        int a, b;
        cin >> a >> b;
        print_res(bakugans, a-1, b-1, size);
    }

    return 0;
}