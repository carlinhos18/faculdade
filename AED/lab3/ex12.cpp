#include <iostream>
#include <vector>

using namespace std;

int lower_bound(vector<int>& vec, int num, int a, int b) {
    int answer = -1;
    while(a <= b){
        int mid = (a+b) / 2;
        if(vec[mid] >= num){
            answer = mid;
            b = mid -1;
        }
        else if(vec[mid] < num){
            a = mid +1;
        }
        else if(vec[mid] > num){
            b = mid -1;
        }
    }
    return answer;
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

    for(int i = 0; i < Q; i++){
        int num_find;
        cin >> num_find;
        cout << lower_bound(vec, num_find, 0, vec.size()-1) << endl;
    }

    return 0;
}