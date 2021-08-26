include "alldifferent.mzn";

int: m; int: n; % number of vertices and faces of P
enum VERTEX; enum FACE; % vertices and faces of P
array[FACE,0..2] of VERTEX: vrtx; % vertices involved in each face (clockwise)

m = 12;
n = 20;
VERTEX = {A, B, C, D, E, F, G, H, I, J, K, L};
FACE = {ABC, ACD, ADE, AEF, AFB, BFK, BGC, BKG, CGH, CHD, DHI, DIE, EIJ, EJF, FJK, GKL, GLH, HLI, ILJ, JLK};
vrtx = array2d(FACE, 0..2, [A, B, C,  A, C, D,  A, D, E,  A, E, F,  A, F, B,  B, F, K,  B, G, C,  B, K, G,  C, G, H,  C, H, D,  D, H, I,  D, I, E,  E, I, J,  E, J, F,  F, J, K,  G, K, L,  G, L, H,  H, L, I,  I, L, J,  J, L, K]);

array[VERTEX] of int: cap; % capacity of each vertex
array[1..n, 0..2] of int: weight; % description of the tiles (clockwise)

array[FACE] of var 1..n: tile; % mapping of each face to a tile
array[1..n] of var 0..2: rot; % rotation of the tile placed on each face

function var int: vertex_sum(VERTEX: v) =
  sum (f in FACE, r in 0..2 where vrtx[f, r] == v)
      (weight[tile[f], [1,2,0,1,2][3 + r - rot[tile[f]]]]); % equiv (3+r-rot[tile[f]]) % 3
constraint alldifferent(tile);
constraint forall (v in VERTEX) (vertex_sum(v) == cap[v]);

constraint forall (t in 1..n)
  (if weight[t, 0] == weight[t, 1] /\ weight[t, 1] == weight[t, 2]
   then forall (f in FACE where tile[f] == t) (rot[tile[f]] == 0)
   endif);
constraint forall (t1 in 1..n, t2 in 1..n where t1 < t2 /\
                   forall (i in 0..2) (weight[t1,i] == weight[t2,i]))
                  (forall (f1 in FACE, f2 in FACE
                           where tile[f1] == t1 /\ tile[f2] == t2)
                          (f1 < f2));

solve satisfy;

function string: instruction(FACE: f) =
  let { 0..3: w0 = weight[fix(tile[f]), (3 - fix(rot[tile[f]])) mod 3],
        0..3: w1 = weight[fix(tile[f]), (4 - fix(rot[tile[f]])) mod 3],
        0..3: w2 = weight[fix(tile[f]), (2 - fix(rot[tile[f]])) mod 3],
        VERTEX: v0 = vrtx[f, 0],
        VERTEX: v1 = vrtx[f, 1],
        VERTEX: v2 = vrtx[f, 2],
        1..12: c0 = cap[v0],
        1..12: c1 = cap[v1],
        1..12: c2 = cap[v2] }
  in "Put tile (" ++ show(w0) ++ ", " ++ show(w1) ++ ", " ++ show(w2) ++ ")" ++
     " on face corresponding to pegs " ++ show(c0) ++ ", " ++ show(c1) ++ ", " ++ show(c2) ++
     " (face " ++ show(v0) ++ show(v1) ++ show(v2) ++ ").\n";

output [ instruction(f) | f in FACE ];
