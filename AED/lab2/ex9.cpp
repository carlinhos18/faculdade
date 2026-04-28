#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <cstdint>

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
    int cur_sum = 0;
    int max_sum = -2001;
    for(int i = 0; i < N; i++){
        cout << vec[i] << " ";
    }
    cout << "\n";
    for(int i = 0; i < N; i++){
        cur_sum += vec[i];
        if(cur_sum <= vec[i]){
            cur_sum = vec[i];
        }
        if(cur_sum > max_sum){
            max_sum = cur_sum;
        }
    }
    cout << max_sum << endl;
    return 0;
}