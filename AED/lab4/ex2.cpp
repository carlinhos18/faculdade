#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

vector<int> count_ones(int num){
    vector<int> res;
    int one = 1;
    int zero = 0;
    
    while(num > 0){
        int div = num % 2;
        switch (div){
            case 0:
                res.push_back(zero);
                break;
            case 1:
                res.push_back(one);
                break;
        }
        num /= 2;
    }
    return res;
}

int main(){
    int N;
    cin >> N;
    vector<pair<vector<int>, int>> vec(N);
    for(int i = 0; i < N; i++){
        int num;
        cin >> num;
        vec[i].first = count_ones(num);
        vec[i].second = num;
    }
    sort(vec.begin(), vec.end(), [](const auto &a, const auto &b){
        int countA = count(a.first.begin(), a.first.end(), 1);
        int countB = count(b.first.begin(), b.first.end(), 1);

        if (countA == countB)
            return a.second < b.second; // número menor primeiro em caso de empate
        return countA > countB;         // maior número de 1s primeiro
    });


    for(int i = 0; i < vec.size(); i++){
        cout << vec[i].second << endl;
    }

}