#include <vector>
#include <string>
#include <queue>
#include <iostream>
#include <cmath>


using namespace std;

int main(){

    int T;
    cin >> T;
    int N;
    cin >> N;
    queue<pair<string, int>> fila;
    for(int i = 0; i < N; i++){
        string word;
        cin >> word;
        int time;
        cin >> time;
        fila.push({word, time});
    }
    int num_it = 0;
    int cur_time = 0;
    while(fila.size() != 0){
        pair process = fila.front();
        //executar processo
        pair executed_process = {process.first, process.second - T};
        num_it++;
        fila.pop();
        if(executed_process.second > 0){ // ainda nao acabou
            fila.push(executed_process);
            cur_time += T;
        }
        else{
            cur_time += T - abs(executed_process.second);
            cout << executed_process.first << " " << cur_time << " " << num_it << endl;

        }
    }

    return 0;
}