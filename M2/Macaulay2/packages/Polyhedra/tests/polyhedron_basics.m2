-- Test 0
-- Checking convexHull basics
TEST ///
P = convexHull matrix {{3,1,0,2},{0,2,2,1},{1,-1,2,0}};
assert(numColumns vertices P == 3)
assert(dim P == 2)
assert(ambDim P == 3)
assert(rays P == 0)
assert(linSpace P == 0)
M = matrix {{3,4,1}};
v = matrix {{10}};
assert(hyperplanes P == (M,v) or hyperplanes P == (-M,-v))
///

-- Test 1
-- Checking convexHull basics
TEST ///
P = convexHull matrix {{3,1,0,2},{0,2,2,1},{1,-1,2,0}};
P = convexHull {P,(matrix{{4},{0},{-2}},matrix{{1,0,0},{0,1,-1},{0,0,0}})};
assert(dim P == 3)
assert(image linSpace P == image matrix {{0},{1},{0}})
assert(hyperplanes P == (0,0))
///

-- Test 2
-- Checking convexHull halfspaces
TEST ///
P = convexHull (matrix{{1},{1}},matrix{{1,0},{0,1}});
M1 = matrix {{-1,0},{0,-1}};
v = matrix {{-1},{-1}};
assert(halfspaces P == (M1,v))
///
-- Test 3
-- Checking convexHull and intersection
TEST ///
P2 =  convexHull matrix {{1,-2,-1,2},{2,1,-2,-1}};
M = matrix{{3,1},{-3,-1},{1,-3},{-1,3}};
v = matrix{{5},{5},{5},{5}};
assert(intersection(M,v) == P2)
///

-- Test 4
-- Checking intersection
TEST ///
P = intersection (matrix{{1,0},{0,1},{-1,0},{0,-1}},matrix{{1},{2},{3},{4}});
V1 = vertices P;
V1 = set apply(numColumns V1, i -> V1_{i});
V2 = set {matrix{{1},{2}},matrix{{1},{-4}},matrix{{-3},{2}},matrix{{-3},{-4}}};
assert(isSubset(V1,V2) and isSubset(V2,V1))
///

-- Test 5
-- Checking polar
TEST ///
P = convexHull matrix {{1,1,-1,-1},{1,-1,1,-1}};
Q = convexHull matrix {{1,-1,0,0},{0,0,1,-1}};
P = polar P;
assert(P == Q)
P = convexHull(matrix {{1,-1,1,-1},{1,1,-1,-1},{1,2,3,4}},matrix {{0,0},{0,0},{1,-1}});
Q = convexHull matrix {{1,-1,0,0},{0,0,1,-1},{0,0,0,0}};
P = polar P;
assert(P == Q)
///

-- Test 11
-- Checking equality for polyhedra and cones
TEST ///
P = convexHull matrix {{1,1,-1,-1},{1,-1,1,-1}};
Q = intersection(matrix{{1,0},{-1,0},{0,1},{0,-1}},matrix{{1},{1},{1},{1}});
assert(P == Q)
C1 = posHull matrix {{1,2},{2,1}};
C2 =intersection matrix {{2,-1},{-1,2}};
assert(C1 == C2)
///

-- Test 9
-- Checking contains for polyhedra
TEST ///
P1 = convexHull matrix {{0,1,1,0},{0,0,1,1}};
P2 = convexHull matrix {{0,2,0},{0,0,2}};
assert contains(P2,P1)
assert(not contains(P1,P2))
P1 = convexHull(matrix {{0,1,1,0},{0,0,1,1},{0,0,0,0}},matrix {{0},{0},{1}});
P2 = convexHull matrix {{0,1,1,0},{0,0,1,1},{1,2,3,4}};
assert(not contains(P2,P1))
assert contains(P1,P2)
///

-- Test 14
-- Checking bipyramid, faces and fVector
TEST ///
P = convexHull matrix {{0,-1,1,0,0,1,-1},{0,0,0,1,-1,-1,1}};
P = bipyramid P;
F2 = set {matrix{{-1_QQ},{0},{0}},matrix{{1_QQ},{0},{0}},matrix{{0_QQ},{1},{0}},matrix{{0_QQ},{-1},{0}},matrix{{1_QQ},{-1},{0}},matrix{{-1_QQ},{1},{0}},matrix{{0_QQ},{0},{1}},matrix{{0_QQ},{0},{-1}}};
desired = sort matrix {elements F2};
assert(desired == vertices P)
assert(fVector P == {8,18,12,1})
///

-- Test 15
-- Checking isEmpty
TEST ///
P = intersection(matrix{{1,1,1},{-1,0,0},{0,-1,0},{0,0,-1}},matrix{{1},{0},{0},{0}});
assert not isEmpty P
P = intersection {P,(matrix{{-1,-1,-1}},matrix{{-2}})};
assert isEmpty P
///

-- Test 38
-- Checking latticePoints
TEST ///
P = convexHull matrix {{1,-1,0,0},{0,0,1,-1}};
LP = latticePoints P;
LP1 = {matrix {{1},{0}},matrix {{-1},{0}},matrix {{0},{1}},matrix {{0},{-1}},matrix {{0},{0}}};
assert(set LP === set LP1)
P = intersection(matrix {{-6,0,0},{0,-6,0},{0,0,-6},{1,1,1}},matrix{{-1},{-1},{-1},{1}});
assert(latticePoints P == {})
///

