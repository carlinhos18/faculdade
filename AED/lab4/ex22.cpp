#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

using namespace std;

struct team{
    string name;
    int wins;
    int draws;
    int losses;
    int goals_scored;
    int goals_against;
    int points;
    int diff;
};

int main(){
    int N;
    cin >> N;
    vector<team> vec(N);
    for(int i = 0; i < N; i++){
        struct team equipa;
        string word;
        cin >> word;
        equipa.name = word;
        int win, draw, loss, goals_score, goal_agains;
        cin >> win >> draw >> loss >> goals_score >> goal_agains;
        equipa.wins = win;
        equipa.draws = draw;
        equipa.losses = loss;
        equipa.goals_scored = goals_score;
        equipa.goals_against = goal_agains;
        equipa.points = win * 3 + draw;
        equipa.diff = goals_score - goal_agains;
        vec[i] = equipa;        
    }
    sort(vec.begin(), vec.end(), [] (const team &a, const team &b) {
    if (a.points != b.points)
        return a.points > b.points;            // mais pontos primeiro
    if (a.diff != b.diff)
        return a.diff > b.diff;                // maior diferença de golos primeiro
    return a.name < b.name;               // ordem alfabética normal
    });


    for(int i = 0; i < N; i++){
        cout << vec[i].name << " " << vec[i].points << " " << vec[i].diff << endl;
    }
}