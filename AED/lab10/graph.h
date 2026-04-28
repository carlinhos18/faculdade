// -------------------------------------------------------------
// Algorithms and Data Structures 2025/2026 - LEIC (FCUP/FEUP)
// http://www.dcc.fc.up.pt/~pribeiro/aulas/aed2526/
// -------------------------------------------------------------
// A simple lightweight graph class
// Last update: 24/11/2024
// -------------------------------------------------------------

#ifndef GRAPH_H
#define GRAPH_H

#include <iostream>
#include <string>
#include <vector>
#include <list>
#include <queue>
#include <stack>
#include <functional> 


class Graph {
  struct Edge {
    int dest;   // Destination node 
    int weight; // An integer weight
  };
	
  struct Node {
    std::list<Edge> adj; // The list of outgoing edges (to adjacent nodes)
    bool visited;        // Has the node been visited in a graph traversal?
  };
	
  int n;                   // Graph size (vertices are numbered from 1 to n)
  bool hasDir;             // false: undirected; true: directed
  std::vector<Node> nodes; // The list of nodes being represented
	
public:  
  // Constructor: nr nodes and direction (default: undirected)
  Graph(int num, bool dir = false) : n(num), hasDir(dir), nodes(num+1) {}
  
  // Add edge from source to destination with a certain weight
  void addEdge(int src, int dest, int weight = 1) {
    if (src<1 || src>n || dest<1 || dest>n) return;
    nodes[src].adj.push_back({dest, weight});
    if (!hasDir) nodes[dest].adj.push_back({src, weight});
  }
  
  // --------------------------------------------------------------
  
  // Read a graph in the format:
  // nr_nodes directed/undirected weighted/unweighted
  // nr_edges
  // src_1 dest_1 <weight_1>
  // src_2 dest_2 <weight_2>
  // ...
  // src_n dest_n <weight_n>
  static Graph *readGraph() {
    int n;
    std::string sdirection, sweight;
    std::cin >> n >> sdirection >> sweight;  
    bool directed = (sdirection == "directed")?true:false;
    bool weighted = (sweight == "weighted")?true:false;
  
    Graph *g = new Graph(n, directed);
    int e;
    std::cin >> e;
    for (int i=0; i<e; i++) {
      int u, v, w = 1;
      std::cin >> u >> v;
      if (weighted) std::cin >> w;
      g->addEdge(u, v, w);
    }
    return g;
  }

  // --------------------------------------------------------------
  // Depth-First Search (DFS): example implementation
  // --------------------------------------------------------------
  void dfs(int v) {
    std::cout << v << " "; // show node order
    nodes[v].visited = true;
    for (auto e : nodes[v].adj) {
      int w = e.dest;
      if (!nodes[w].visited)
        dfs(w);
    }
  }
  
  // --------------------------------------------------------------
  // Breadth-First Search (BFS): example implementation
  // --------------------------------------------------------------
  void bfs(int v) {
    for (int i=1; i<=n; i++) nodes[i].visited = false;
    std::queue<int> q; // queue of unvisited nodes
    q.push(v);
    nodes[v].visited = true;
    while (!q.empty()) { // while there are still unvisited nodes
      int u = q.front(); q.pop();      
      std::cout << u << " ";  // show node order
      for (auto e : nodes[u].adj) {
        int w = e.dest;
        if (!nodes[w].visited) {
          q.push(w);
          nodes[w].visited = true;
        }
      }
    }
  }
  
  
  // --------------------------------------------------------------

  // ---------------------------------------------------------
  // TODO: put the functions you need to implement below this
  // ---------------------------------------------------------
        int distance(int a, int b) {
        if (a < 1 || a > n || b < 1 || b > n) return -1; 
        
        for (int i = 1; i <= n; i++) nodes[i].visited = false;

        std::queue<int> q;
        std::vector<int> dist(n + 1, -1); 
        
        q.push(a);
        nodes[a].visited = true;
        dist[a] = 0;
        
        while (!q.empty()) {
            int u = q.front(); q.pop();
            for (auto e : nodes[u].adj) {
                int v = e.dest;
                if (!nodes[v].visited) {
                    nodes[v].visited = true;
                    dist[v] = dist[u] + 1;
                    q.push(v);
                }
            }
        }
        
        return dist[b]; // se b não foi alcançado, permanece -1
    }

    int diameter() {
        if (hasDir) return -1; // não aplicável a grafos dirigidos

        for (int i = 1; i <= n; i++) nodes[i].visited = false;
        std::queue<int> q;
        q.push(1);
        nodes[1].visited = true;
        int visitedCount = 1;

        while (!q.empty()) {
            int u = q.front(); q.pop();
            for (auto e : nodes[u].adj) {
                int v = e.dest;
                if (!nodes[v].visited) {
                    nodes[v].visited = true;
                    visitedCount++;
                    q.push(v);
                }
            }
        }

        if (visitedCount != n) return -1; // grafo não é conexo

        // Calcular o diâmetro
        int maxDist = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) nodes[j].visited = false;

            std::vector<int> dist(n + 1, -1);
            q.push(i);
            nodes[i].visited = true;
            dist[i] = 0;

            while (!q.empty()) {
                int u = q.front(); q.pop();
                for (auto e : nodes[u].adj) {
                    int v = e.dest;
                    if (!nodes[v].visited) {
                        nodes[v].visited = true;
                        dist[v] = dist[u] + 1;
                        q.push(v);
                    }
                }
            }

            for (int j = 1; j <= n; j++) {
                if (dist[j] > maxDist) maxDist = dist[j];
            }
        }

        return maxDist;
    }

    int countSCCs() {
      if (!hasDir) return -1; // Só faz sentido em grafos dirigidos

      // ----------- 1. DFS para obter ordem de término ----------
      std::vector<bool> visited(n + 1, false);
      std::stack<int> st; // usar std::stack

      // DFS auxiliar
      std::function<void(int)> dfs1 = [&](int u) {
          visited[u] = true;
          for (auto &e : nodes[u].adj) {
              if (!visited[e.dest]) dfs1(e.dest);
          }
          st.push(u);
      };

      for (int i = 1; i <= n; i++) {
          if (!visited[i]) dfs1(i);
      }

      // ----------- 2. Construir grafo transposto ----------
      Graph gt(n, true); // grafo dirigido
      for (int u = 1; u <= n; u++) {
          for (auto &e : nodes[u].adj) {
              gt.addEdge(e.dest, u); // inverter aresta
          }
      }

      // ----------- 3. DFS no transposto seguindo stack ----------
      std::vector<bool> visitedT(n + 1, false);
      int sccCount = 0;

      std::function<void(int)> dfs2 = [&](int u) {
          visitedT[u] = true;
          for (auto &e : gt.nodes[u].adj) {
              if (!visitedT[e.dest]) dfs2(e.dest);
          }
      };

      while (!st.empty()) {
          int u = st.top(); st.pop();
          if (!visitedT[u]) {
              sccCount++;   // nova componente encontrada
              dfs2(u);      // explorar toda a SCC
          }
      }

      return sccCount;
    }


  

  
};

#endif