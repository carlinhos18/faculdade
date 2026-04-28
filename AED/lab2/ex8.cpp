#include <iostream>
#include <vector>
#include <string>

using namespace std;

int main(){
    int L, K, T;
    cin >> L >> K >> T;
    vector<int> vec(L);
    for(int i = 0; i < L; i++){
        int num;
        cin >> num;
        vec[i] = num;
    }
    int res = 0;
    int aux_c = 0;
    int biggerThan = (K+1) / 2;
    vector<int> win(K);
    for(int i = 0; i < K; i++){
        if(vec[i] >= T){
            aux_c++;
        }
        win[i] = vec[i];
    }
    if(aux_c >= biggerThan){
        res++;
    }
    aux_c = 0;


    for(int i = K; i < L; i++){
        if(vec[i - K] >= T) aux_c--;
        if(vec[i] >= T) aux_c++;
        if(aux_c >= biggerThan) res++;
    }


    cout << res << endl;
    return 0;
}