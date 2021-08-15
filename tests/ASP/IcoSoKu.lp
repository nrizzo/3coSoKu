tile(1..n). % tiles
rotation(0..2). % possible (clockwise) rotations

#const m = 12.
#const n = 20.
vertex(a; b; c; d; e; f; g; h; i; j; k; l).
face(abc; acd; ade; aef; afb; bfk; bgc; bkg; cgh; chd; dhi; die; eij; ejf; fjk; gkl; glh; hli; ilj; jlk).
vrtx(a, abc, 0;  b, abc, 1;  c, abc, 2;   a, acd, 0;  c, acd, 1;  d, acd, 2;
     a, ade, 0;  d, ade, 1;  e, ade, 2;   a, aef, 0;  e, aef, 1;  f, aef, 2;
     a, afb, 0;  f, afb, 1;  b, afb, 2;   b, bfk, 0;  f, bfk, 1;  k, bfk, 2;
     b, bgc, 0;  g, bgc, 1;  c, bgc, 2;   b, bkg, 0;  k, bkg, 1;  g, bkg, 2;
     c, cgh, 0;  g, cgh, 1;  h, cgh, 2;   c, chd, 0;  h, chd, 1;  d, chd, 2;
     d, dhi, 0;  h, dhi, 1;  i, dhi, 2;   d, die, 0;  i, die, 1;  e, die, 2;
     e, eij, 0;  i, eij, 1;  j, eij, 2;   e, ejf, 0;  j, ejf, 1;  f, ejf, 2;
     f, fjk, 0;  j, fjk, 1;  k, fjk, 2;   g, gkl, 0;  k, gkl, 1;  l, gkl, 2;
     g, glh, 0;  l, glh, 1;  h, glh, 2;   h, hli, 0;  l, hli, 1;  i, hli, 2;
     i, ilj, 0;  l, ilj, 1;  j, ilj, 2;   j, jlk, 0;  l, jlk, 1;  k, jlk, 2).

1 { assign(T, F): face(F) } 1 :- tile(T).
1 { assign(T, F): tile(T) } 1 :- face(F).

1 { rotate(T, R) : rotation(R) } 1 :- tile(T).

:- #sum{ P,F : vrtx(V, F, A), assign(T, F), rotate(T, R), weight(T, (A - R + 3) \ 3, P) } != C, cap(V, C).

rotate(T, 0) :- weight(T, 0, I), weight(T, 1, I), weight(T, 2, I).

F1 < F2 :- assign(T1, F1), assign(T2, F2), weight(T1, 0, I1),
  weight(T2, 0 ,I1), weight(T1, 1, I2), weight(T2, 1, I2), weight(T1, 2, I3),
  weight(T2, 2, I3), T1 < T2.

put(W0, W1, W2, V0, V1, V2, C0, C1, C2) :- assign(T, F), vrtx(V0, F, 0), vrtx(V1, F, 1), vrtx(V2, F, 2), rotate(T, R), weight(T, (3 - R) \ 3, W0), weight(T, (4 - R) \ 3, W1), weight(T, (2 - R) \ 3, W2), cap(V0, C0), cap(V1, C1), cap(V2, C2).

#show cap/2.
#show put/9.
