#include <bits/stdc++.h>
using namespace std;

struct MovieInfo {
    int total = 0;
    int positive = 0;
    int negative = 0;
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int N;
    cin >> N;
    
    unordered_map<string, MovieInfo> movies;
    
    for (int i = 0; i < N; i++) {
        string name;
        int score;
        cin >> name >> score;
        
        movies[name].total++;
        if (score >= 5)
            movies[name].positive++;
        else
            movies[name].negative++;
    }

    // 1. Number of different movies
    int differentMovies = movies.size();

    // 2. Maximum number of reviews and how many movies have that max
    int maxReviews = 0;
    for (auto& [name, info] : movies) {
        maxReviews = max(maxReviews, info.total);
    }

    int moviesWithMaxReviews = 0;
    for (auto& [name, info] : movies) {
        if (info.total == maxReviews)
            moviesWithMaxReviews++;
    }

    // 3. Number of movies with more positive than negative reviews
    int morePositive = 0;
    for (auto& [name, info] : movies) {
        if (info.positive > info.negative)
            morePositive++;
    }

    // Output results
    cout << differentMovies << '\n';
    cout << maxReviews << ' ' << moviesWithMaxReviews << '\n';
    cout << morePositive << '\n';

    return 0;
}
