%
% Description of the icosahedron for 3coSoKu.mzn
%

% vertices and faces of the polyhedron
m = 12;
n = 20;
VERTEX = {A, B, C, D, E, F, G, H, I, J, K, L};
FACE = {ABC, ACD, ADE, AEF, AFB,
        BFK, BGC, BKG, CGH, CHD,
        DHI, DIE, EIJ, EJF, FJK,
        GKL, GLH, HLI, ILJ, JLK};

% vrtx is a n x 3 matrix such that vrtx[f, 0], vrtx[f, 1] and vrtx[f, 2] are the
% three vertices of face f
vrtx = array2d(FACE, 0..2,
  [A, B, C,  A, C, D,  A, D, E,  A, E, F,  A, F, B,
   B, F, K,  B, G, C,  B, K, G,  C, G, H,  C, H, D,
   D, H, I,  D, I, E,  E, I, J,  E, J, F,  F, J, K,
   G, K, L,  G, L, H,  H, L, I,  I, L, J,  J, L, K]);
