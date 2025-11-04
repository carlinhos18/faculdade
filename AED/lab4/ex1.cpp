#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

int main(){
    int N;
    cin >> N;
    int K; 
    cin >> K;
    vector<int> sorted_vector(N);
    for(int i = 0; i < N; i++){
        int num;
        cin >> num;
        sorted_vector[i] = num;
    }
    sort(sorted_vector.begin(), sorted_vector.end());
    for(int i = N - 1; i > N - K - 1; i--){
        cout << sorted_vector[i] << endl;
    }
    return 0;
}