#include <bits/stdc++.h>
using namespace std;

struct Pos {
    int r, c, dist;
};

int main() {
    int N;
    cin >> N;

    while (N--) {
        int R, C;
        cin >> R >> C;
        vector<string> maze(R);
        for (int i = 0; i < R; i++) cin >> maze[i];

        int pr, pc, tr, tc;
        // localizar o jogador e o tesouro
        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                if (maze[i][j] == 'P') { pr = i; pc = j; }
                if (maze[i][j] == 'T') { tr = i; tc = j; }
            }
        }

        vector<vector<bool>> visited(R, vector<bool>(C, false));
        queue<Pos> q;
        q.push({pr, pc, 0});
        visited[pr][pc] = true;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        int ans = -1;

        while (!q.empty()) {
            Pos cur = q.front(); q.pop();
            if (cur.r == tr && cur.c == tc) {
                ans = cur.dist;
                break;
            }
            for (int k = 0; k < 4; k++) {
                int nr = cur.r + dr[k];
                int nc = cur.c + dc[k];
                if (nr >= 0 && nr < R && nc >= 0 && nc < C &&
                    !visited[nr][nc] && maze[nr][nc] != '#') {
                    visited[nr][nc] = true;
                    q.push({nr, nc, cur.dist + 1});
                }
            }
        }

        cout << ans << endl;
    }

    return 0;
}
