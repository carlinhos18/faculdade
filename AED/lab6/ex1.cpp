#include <vector>
#include <iostream>
#include <string>
#include <sstream>

using namespace std;

int putSecond1(vector<pair<string,int>> &magic, int K, int N, int startIdx) {
    int count = 0;  
    int idx = startIdx;  

    while(true) {
        if(magic[idx].second == 0) count++; 
        if(count == K) {
            magic[idx].second = 1; 
            cout << magic[idx].first << endl;
            return (idx + 1) % N;
        }
        idx = (idx + 1) % N;
    }
}

int main() {
    string skibidi;
    getline(cin, skibidi);

    stringstream ss(skibidi);
    string word;
    int K = 0;
    while (ss >> word) K++;

    int N;
    cin >> N;
    vector<pair<string,int>> magic(N);

    for(int i = 0; i < N; i++) {
        string name;
        cin >> name;
        magic[i].first = name;
        magic[i].second = 0;
    }

    int startIdx = 0; // começa no início da lista
    for(int i = 0; i < N; i++) {
        startIdx = putSecond1(magic, K, N, startIdx);
    }

    return 0;
}
