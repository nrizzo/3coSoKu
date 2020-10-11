/*
 * put here the JavaScript code from
 * 	http://www.nearly42.org/games/icosoku-solver/
 * (I have not asked permission to use this code). Function icosolve must be
 * parametrized to accept in input the description of the capacities using his
 * naming convention.
 * ~ Nicola Rizzo
 */


// Measure the solving time
var start = new Date();
icosolve([10, 11, 12, 6, 8, 4, 2, 5, 1, 9, 3, 7]);
var end = new Date();
console.log((end - start)/1000 + "");
