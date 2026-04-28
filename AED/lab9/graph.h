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
#include <list>

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
    int outDegree(int v) {
        if (v < 1 || v > n) return -1;
        return nodes[v].adj.size();
    }

    int weightedOutDegree(int v) {
        if (v < 1 || v > n) return -1;
        int sum = 0;
        for (auto e : nodes[v].adj) {
            sum += e.weight;
        }
        return sum;
    }

    int nrConnectedComponents() {
        if (hasDir) return -1; 
        
        
        for (int i = 1; i <= n; i++) nodes[i].visited = false;
        
        int count = 0;
        
        for (int i = 1; i <= n; i++) {
            if (!nodes[i].visited) {
                count++;
                // DFS iterativa usando stack
                std::stack<int> stk;
                stk.push(i);
                nodes[i].visited = true;
                
                while (!stk.empty()) {
                    int u = stk.top();
                    stk.pop();
                    
                    for (auto e : nodes[u].adj) {
                        int w = e.dest;
                        if (!nodes[w].visited) {
                            nodes[w].visited = true;
                            stk.push(w);
                        }
                    }
                }
            }
        }
        
        return count;
    }

    int largestComponent() {
        if (hasDir) return -1; 

        for (int i = 1; i <= n; i++) nodes[i].visited = false;

        int largest = 0;

        for (int i = 1; i <= n; i++) {
            if (!nodes[i].visited) {
                int size = 0;

                
                std::stack<int> stk;
                stk.push(i);
                nodes[i].visited = true;

                while (!stk.empty()) {
                    int u = stk.top();
                    stk.pop();
                    size++;

                    for (auto e : nodes[u].adj) {
                        int w = e.dest;
                        if (!nodes[w].visited) {
                            nodes[w].visited = true;
                            stk.push(w);
                        }
                    }
                }

                if (size > largest) largest = size; 
            }
        }

        return largest;
    }

    // Função auxiliar privada para DFS topológico
    void dfsTopological(int u, std::list<int> &order) {
        nodes[u].visited = true;
        for (auto e : nodes[u].adj) {
            int v = e.dest;
            if (!nodes[v].visited)
                dfsTopological(v, order);
        }
        order.push_front(u); 
    }

    std::list<int> topologicalSorting() {
        std::list<int> order;

        if (!hasDir) return order; // topological sorting apenas faz sentido em grafos dirigidos

        // Reset dos flags visited
        for (int i = 1; i <= n; i++)
            nodes[i].visited = false;

        // Rodar DFS topológico em todos os nós
        for (int i = 1; i <= n; i++)
            if (!nodes[i].visited)
                dfsTopological(i, order);

        return order;
    }

    bool dfsCycle(int u, std::vector<int> &state) {
        state[u] = 1; 
        for (auto e : nodes[u].adj) {
            int v = e.dest;
            if (state[v] == 1) return true;  
            if (state[v] == 0 && dfsCycle(v, state)) return true;
        }
        state[u] = 2; // preto: nó processado
        return false;
    }

    bool hasCycle() {
        if (!hasDir) return false; 

        std::vector<int> state(n + 1, 0);

        for (int i = 1; i <= n; i++)
            if (state[i] == 0)
                if (dfsCycle(i, state)) return true;

        return false;
    }





  

  
};

#endif