#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int main() {
    int N;
    cin >> N;
    vector<pair<int,int>> intervals(N);

    for(int i = 0; i < N; i++){
        cin >> intervals[i].first >> intervals[i].second;
    }

    vector<pair<int,int>> events;

    for(auto &it : intervals){
        events.push_back({it.first, 1}); 
        events.push_back({it.second, -1}); 
    }

    sort(events.begin(), events.end(), [](const auto &a, const auto &b){
        if(a.first == b.first) return a.second < b.second;
        return a.first < b.first;
    });

    int current = 0;
    int maximum = 0;

    for(auto &e : events){
        current += e.second;
        maximum = max(maximum, current);
    }

    cout << maximum << endl;
}
