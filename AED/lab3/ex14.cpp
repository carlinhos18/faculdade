#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

int res_function(vector<int> & vec, int limite){
    int days = 1;
    int current_sum = 0;
    for(int d: vec){
        if(current_sum + d <= limite){
            current_sum += d;
        }else{
            days++;
            current_sum = d;
        }
    }
    return days;
}
int main(){
    int N;
    cin >> N;
    vector<int> vec(N);
    for(int i = 0; i < N; i++){
        int num;
        cin >> num;
        vec[i] = num;
    }
    int Q;
    cin >> Q;
    int lim_min = *max_element(vec.begin(), vec.end());
    int lim_max = accumulate(vec.begin(), vec.end(), 0);
    int res = lim_max;

    for(int i = 0; i < Q; i++){
        int a;
        cin >> a;
        for(int limite = lim_min; limite <= lim_max; limite++){
            if(res_function(vec, limite) <= a){
                res = limite;
                break;
            } 
        }
        cout << res << endl;
    }

    return 0;
}