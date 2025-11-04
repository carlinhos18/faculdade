#include <iostream>
#include <vector>
#include <cmath> // for ceil

using namespace std;

int main() {
    int N, K, T;
    cin >> N >> K >> T;

    vector<int> depth(N);
    for(int i = 0; i < N; i++)
        cin >> depth[i];

    vector<int> good(N, 0);
    for(int i = 0; i < N; i++)
        if(depth[i] >= T) good[i] = 1;

    int min_good = (K + 1) / 2; // at least half (ceil(K/2))
    int count = 0;

    // sum of first window
    int window_sum = 0;
    for(int i = 0; i < K; i++)
        window_sum += good[i];

    if(window_sum >= min_good) count++;

    // slide the window
    for(int i = K; i < N; i++){
        window_sum = window_sum - good[i - K] + good[i];
        if(window_sum >= min_good) count++;
    }

    cout << count << endl;

    return 0;
}
