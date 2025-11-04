#include <iostream>
#include <vector>
#include <algorithm>
#include <string>


using namespace std;

string sortString(const string & s){
    string res;
    for(char c : s){
        res += tolower(c);
    }
    res.erase(std::remove_if(res.begin(), res.end(), ::isspace),
        res.end());
    sort(res.begin(), res.end());
    return res;

}



int main(){
    int N;
    cin >> N;
    string aux;
    getline(cin, aux);
    vector<string> vec(N);
    for(int i = 0; i < N; i++){
        string skibidi;
        getline(cin,skibidi);
        vec[i] = sortString(skibidi);
    }

    sort(vec.begin(), vec.end());
\
    int res = 0;
    int n_elem = 1;
    string prev = vec[0];
    for(int i = 1; i < N; i++){
        string cur = vec[i];
        if(cur == prev){
            n_elem += 1;
            if(n_elem == 2){
                res++;
            }
        }else{
            n_elem = 1;
        }
        prev = cur;

    }
       


    cout << res << endl;

    return 0;
}