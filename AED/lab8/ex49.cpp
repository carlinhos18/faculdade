#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int N;
    cin >> N;
    vector<long long> A(N);
    for (int i = 0; i < N; i++) {
        cin >> A[i];
    }

    unordered_map<long long, int> last_seen; // mapeia evento -> última posição (1-indexada)
    vector<int> B(N);

    for (int i = 0; i < N; i++) {
        if (last_seen.find(A[i]) != last_seen.end()) {
            B[i] = last_seen[A[i]];
        } else {
            B[i] = -1;
        }
        last_seen[A[i]] = i + 1; // posição 1-indexada
    }

    for (int i = 0; i < N; i++) {
        cout << B[i];
        if (i != N - 1) cout << ' ';
    }
    cout << '\n';

    return 0;
}
