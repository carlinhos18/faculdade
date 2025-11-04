#include <iostream>
#include <vector>

using namespace std;

int is_in(vector<int>& vec, int num, int a, int b) {
    while(a <= b){
        int mid = (a+b) / 2;
        if(vec[mid] == num){
            return mid;
        }
        else if(vec[mid] < num){
            a = mid +1;
        }
        else if(vec[mid] > num){
            b = mid;
        }
    }
    return -1;
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
        cout << is_in(vec, num_find, 0, vec.size()-1) << endl;
    }

    return 0;
}