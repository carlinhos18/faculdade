#include <iostream>
#include <vector>
using namespace std;

int main() {
    int N, S, I;
    cin >> N >> S >> I;
    S--; // convert to 0-based index

    vector<char> chests(N);
    for (int i = 0; i < N; i++)
        cin >> chests[i];

    int cur = S;
    int min_pos = S;
    int max_pos = S;

    for (int i = 0; i < I; i++) {
        char dir;
        int steps;
        cin >> dir >> steps;

        if (dir == 'R') cur += steps;
        else cur -= steps;

        if (cur < min_pos) min_pos = cur;
        if (cur > max_pos) max_pos = cur;
    }

    // Count treasures in the interval [min_pos, max_pos]
    int collected = 0;
    for (int i = min_pos; i <= max_pos; i++) {
        if (chests[i] == 'T') collected++;
    }

    cout << collected << endl;
    return 0;
}
