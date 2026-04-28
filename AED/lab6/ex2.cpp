#include <vector>
#include <iostream>
#include <string>
#include <stack>

using namespace std;

bool isMatching(char open, char close) {
    return (open == '(' && close == ')') ||
           (open == '{' && close == '}') ||
           (open == '[' && close == ']');
}

int main(){
    string skibidi;
    getline(cin, skibidi);
    vector<pair<char, int>> caracas;
    int idx = 0;
    for(auto& letter : skibidi){
        if(letter == '(' || letter == '{' || letter == '[' || letter == ')' || letter == '}' || letter == ']'){
            caracas.push_back({letter, idx});
        }
        idx++;
    }
    if(caracas.empty()){
        cout << "no brides and grooms to marry" << endl;

    }

    stack<pair<char, int>> pilha;
    vector<pair<pair<char,char>, pair<int,int>>> matches;


    for(pair<char, int> letter : caracas){
        if(letter.first == '(' || letter.first == '{' || letter.first == '['){
            pilha.push(letter);
        }
        else if(letter.first == ')' || letter.first == '}' || letter.first == ']'){
            if (pilha.empty()){
                cout << "badly matched pairs" << endl;
                return 0;
            }
            if (!isMatching(pilha.top().first, letter.first)){
                cout << "badly matched pairs" << endl; 
                return 0;
            }
            matches.push_back({{pilha.top().first, letter.first}, {pilha.top().second, letter.second}});
            pilha.pop();    
        }
    }
    if(!pilha.empty()){
        cout << "badly matched pairs" << endl;
        return 0;
    } 

    for (auto &m : matches){
        cout << m.first.first << m.first.second << " " << m.second.first << " " << m.second.second << endl;
    }
    return 0;
}