%
% Description of the deltahedron for 3coSoKu.mzn
%

% vertices and faces of the polyhedron
m = 4;
n = 4;
VERTEX = {A, B, C, D};
FACE = {ABC, ACD, ADB, BDC};

% vrtx is a n x 3 matrix such that vrtx[f, 0], vrtx[f, 1] and vrtx[f, 2] are the
% three vertices of face f
vrtx = array2d(FACE, 0..2,
      [A, B, C,
       A, C, D,
       A, D, B,
       B, D, C]);
