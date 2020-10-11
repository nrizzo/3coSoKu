%
% Description of the tetrahedron for 3coSoKu.lp
%

% vertices and faces of the polyhedron
#const m = 4.
#const n = 4.
vertex(a; b; c; d).
face(abc, acd, adb, bdc).

% vrtx/3 is such that vrtx(v, f, 0) means that v is the first
%    vertex involved in face f, vrtx(v, f, 1) means that v is the second
%    vertex of f, vrtx(v, f, 2) the third one
vrtx(a, abc, 0;  b, abc, 1;  c, abc, 2;   a, acd, 0;  c, acd, 1;  d, acd, 2;
     a, adb, 0;  d, adb, 1;  b, adb, 2;   b, bdc, 0;  d, bdc, 1;  c, bdc, 2).
