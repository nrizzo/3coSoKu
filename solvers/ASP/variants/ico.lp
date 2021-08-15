%
% Description of the icosahedron for 3coSoKu.lp
%

% vertices and faces of the polyhedron
#const m = 12.
#const n = 20.
vertex(a; b; c; d; e; f; g; h; i; j; k; l).
face(abc; acd; ade; aef; afb; bfk; bgc; bkg; cgh; chd; dhi; die; eij; ejf; fjk; gkl; glh; hli; ilj; jlk).

% vrtx/3 is such that vrtx(v, f, 0) means that v is the first
%    vertex involved in face f, vrtx(v, f, 1) means that v is the second
%    vertex of f, vrtx(v, f, 2) the third one
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
