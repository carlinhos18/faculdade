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

int upper_bound(vector<int>& vec, int num, int a, int b) {
    int answer = -1;
    while(a <= b){
        int mid = (a+b) / 2;
        if(vec[mid] <= num){
            answer = mid;
            a = mid +1;
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

int count_interval(vector<int>& vec, int a, int b) {
    int first = lower_bound(vec, a, 0, vec.size()-1); // get first idx 


    int last = upper_bound(vec, b,0, vec.size() -1);
    if(first == -1 || last == -1){
        return 0;
    }
    return (last - first) + 1;

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
        int a;
        cin >> a;
        int b;
        cin >> b;
        cout << count_interval(vec,a,b) << endl;
    }

    return 0;
}