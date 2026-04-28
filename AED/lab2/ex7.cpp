#include <iostream>
#include <vector>
#include <string>

using namespace std;

void calculate_res(vector<pair<char, int>>& chest, char a, int b, int &cur_pos, int &count) {
    int offset = 0;
    if (a == 'R') {
        offset = cur_pos + b;
        for (int i = cur_pos; i <= offset; i++) {
            if (chest[i].first == 'T' && chest[i].second != 1) {
                count++;
            }
            chest[i].second = 1; // mark visited
        }
    }
    else { // L
        offset = cur_pos - b;
        for (int i = cur_pos; i >= offset; i--) {
            if (chest[i].first == 'T' && chest[i].second != 1) {
                count++;
            }
            chest[i].second = 1; // mark visited
        }
    }
    cur_pos = offset;

}

int main() {
    int N, S, I;
    cin >> N >> S >> I;
    vector<pair<char, int>> chest(N);
    string chests;
    cin >> chests;
    for(int i = 0; i < N; i++){
        chest[i] = {chests[i] , 0};
    }

    int cur_pos = S - 1;
    int count = 0;


    if (chest[cur_pos].first == 'T') {
        count = 1;
    }
    chest[cur_pos].second = 1; // mark starting chest visited

    for (int i = 0; i < I; i++) {
        char a;
        int b;
        cin >> a >> b;
        calculate_res(chest, a, b, cur_pos, count);
    }

    cout << count << endl;

    return 0;
}
