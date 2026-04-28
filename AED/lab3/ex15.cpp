#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

int main(){
    int N;
    cin >> N;
    vector<int> vec(N);
    for(int i = 0; i < N; i++){
        int num;
        cin >> num;
        vec[i] = num;
    }
    int times;
    cin >> times;
    sort(vec.begin(), vec.end());
    for(int i = 0; i < N; i++){
        cout << vec[i] << " ";
    }
    cout << endl;
    for(int i = 0; i < times; i++){
        int target;
        int res = 0;
        cin >> target;
        int aux = target;
        target = target / 2;
        if(target < vec[0]){
            res = vec[0] + vec[1];
        }else if(target > vec[N-1]){
            res = vec[N-1] + vec[N-2];
        }
        auto it = lower_bound(vec.begin(), vec.end(), target);
        int idx = it - vec.begin();
        cout << "IDX: " << idx << endl;
        int cur_dif = 0;
        vector<int> difs(N);
        while(true){
            int num1 = vec[idx]; // nª direita
            int num2 = vec[idx-1]; // nª esquerda
            int sum = num1 + num2;
            int dif = abs(aux - (num1 + num2)); 
            if(sum > aux){

            }
        }
        cout << res << endl;
    }
    return 0;
}