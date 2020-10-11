%
% ASP encoding of 3coSoKu ~ Nicola Rizzo and Agostino Dovier
%

% The description of the polyhedron acting as playing field is in the folder 
% variants and must be appended to this file.

tile(1..n). % tiles
rotation(0..2). % possible (clockwise) rotations

% The description of capacities and tiles (input-ico.lp for IcoSoKu) must be
% appended to this file and contains functions cap/2, with cap(V, I) indicating
% that vertex V has capacity I, and weight/3, with weight(T, 0, W0),
% weight(T, 1, W1) and weight(T, 2, W2) indicating that tile T is (W0, W1, W2)

% The solution is given by assign/2 and rotate/2
1 { assign(T, F): face(F) } 1 :- tile(T).
1 { assign(T, F): tile(T) } 1 :- face(F).

1 { rotate(T, R) : rotation(R) } 1 :- tile(T).

% The capacity of each vertex must be filled
:- #sum { P,F : vrtx(V, F, A), assign(T, F), rotate(T, R), weight(T, (A - R + 3) \ 3, P) } != C, cap(V, C).

% Simmetry breaking: uniform tiles should not be rotated
rotate(T, 0) :- weight(T, 0, I), weight(T, 1, I), weight(T, 2, I).

% Simmetry breaking: equivalent tiles should keep their relative order when
% assigned to the faces
F1 < F2 :- assign(T1, F1), assign(T2, F2), weight(T1, 0, I1),
  weight(T2, 0 ,I1), weight(T1, 1, I2), weight(T2, 1, I2), weight(T1, 2, I3),
  weight(T2, 2, I3), T1 < T2.

% put/6 is a print predicate, put(W0, W1, W2, V0, V1, V2, C0, C1, C2) means that
% the solution found puts tile (W0, W1, W2) on face (V0, V1, V2) whose vertices
% correspond to capacities C0, C1 and C2.
% WARNING: put/6 affects grounding size, remove if necessary
put(W0, W1, W2, V0, V1, V2, C0, C1, C2) :- assign(T, F), vrtx(V0, F, 0), vrtx(V1, F, 1), vrtx(V2, F, 2), rotate(T, R), weight(T, (3 - R) \ 3, W0), weight(T, (4 - R) \ 3, W1), weight(T, (2 - R) \ 3, W2), cap(V0, C0), cap(V1, C1), cap(V2, C2).

% Output solution
%#show assign/2.
%#show rotate/2.

% Output instructions
#show cap/2.
#show put/9.
