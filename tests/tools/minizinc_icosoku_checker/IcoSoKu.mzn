include "alldifferent.mzn";

int: m; int: n; % number of vertices and faces of P
enum VERTEX; enum FACE; % vertices and faces of P
array[FACE,0..2] of VERTEX: vrtx; % vertices involved in each face (clockwise)

m = 12;
n = 20;
VERTEX = {A, B, C, D, E, F, G, H, I, J, K, L};
FACE = {ABC, ACD, ADE, AEF, AFB, BFK, BGC, BKG, CGH, CHD, DHI, DIE, EIJ, EJF, FJK, GKL, GLH, HLI, ILJ, JLK};
vrtx = array2d(FACE, 0..2, [A, B, C,  A, C, D,  A, D, E,  A, E, F,  A, F, B,  B, F, K,  B, G, C,  B, K, G,  C, G, H,  C, H, D,  D, H, I,  D, I, E,  E, I, J,  E, J, F,  F, J, K,  G, K, L,  G, L, H,  H, L, I,  I, L, J,  J, L, K]);
weight = array2d(1..n, 0..2, [0,0,0, 0,0,1, 0,0,2, 0,0,3, 0,1,1, 0,1,2, 0,1,2, 0,1,2, 0,2,1, 0,2,1, 0,2,1, 0,2,2, 0,3,3, 1,1,1, 1,2,3, 1,2,3, 1,3,2, 1,3,2, 2,2,2, 3,3,3]);

array[VERTEX] of int: cap; % capacity of each vertex
array[1..n, 0..2] of int: weight; % description of the tiles (clockwise)

array[FACE] of var 1..n: tile; % mapping of each face to a tile
array[1..n] of var 0..2: rot; % rotation of the each tile

function var int: vertex_sum(VERTEX: v) =
  sum (f in FACE, r in 0..2 where vrtx[f, r] == v)
  (weight[tile[f], [1,2,0,1,2][3 + r - rot[tile[f]]]]);

constraint alldifferent(tile);
constraint forall (v in VERTEX) (vertex_sum(v) == cap[v]);

solve satisfy;
output [ "=====SATISFIABLE=====" ];
