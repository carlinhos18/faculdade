#include <iostream>
#include <vector>
#include <set>
#include <algorithm>

using namespace std;

int main() {

    int N;
    cin >> N;
    set<int> s;
    for(int i = 0; i < N; i++){
        int num;
        cin >> num;
        s.insert(num);
    }
    vector<int> vec;
    int L;
    cin >>L;
    int res = 0;
    for(int i = 0; i < L; i++){
        int num;
        cin >> num;
        if (s.find(num) == s.end()){ // são diferentes
            res++;
            vec.push_back(num);
        }
    }
    cout << res << endl;
    sort(vec.begin(), vec.end());
    for(int i = 0; i < vec.size(); i++){
        if (i == vec.size()-1){
            cout << vec[i] << endl;
        }
        else{
            cout << vec[i] << " ";
        }
    }

    return 0;
}