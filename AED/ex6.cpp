#include <iostream>
#include <vector>

using namespace std;
int sum_vec(vector<int>& toilet, int a, int b){
    int skibidi_res = toilet[b] - toilet[a -1];

    return skibidi_res;
}

int main(){

    int N;
    cin >> N;
    int prev_sum = 0;
    vector<int> prefixSkibidi(N+1);
    prefixSkibidi[0] = 0;
    for(int i = 1; i < N+1 ; i++){
        int num;
        cin >> num;
        prev_sum += num;        
        prefixSkibidi[i] = prev_sum;
    }

    int num_times;
    cin >> num_times;
    for(int i = 0; i < num_times; i++){
        int a;
        int b;
        cin >> a >> b;
        int skibidi_res = prefixSkibidi[b] - prefixSkibidi[a -1];
        cout << skibidi_res << endl;
    }

    return 0;
}