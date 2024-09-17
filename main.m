_<e_1,e_2,e_3,e_4,e_5,e_6>:=PolynomialRing(Rationals(),6);
_<x>:=PolynomialRing(Parent(e_1));
_<y>:=PolynomialRing(Rationals());
_<a>:=PolynomialRing(Integers());

B:=30;


C:=[a^3+a^2+a,a^4+a^3+a^2+1];
BadPrimes:=[23,257];
N:=5911;


/*
Reducible One-Dim:  161243136
[ 2, 3 ]
Reducible Three-Dim:  1
[]
Imprimitive 3+3:  1
[]
Imprimitive 2+2+2:  16
[ 2 ]
Class C4:  4503599627370496
[ 2 ]

Small prime exception or exceptional group:  6
Exceptional of Lie Type ruled out for:  [ 3, 5, 7, 11, 13 ]
*/


/*
C:=[a^5 - a^4+a^3, a^4+1];
N:=7744;
BadPrimes :=[2,11];
*/

/*
Reducible One-Dim:  3338539259776438869866308239360000000
[ 2, 3, 5, 11, 13, 19, 29, 37, 181 ]
Reducible Three-Dim:  4
[ 2 ]
Imprimitive 3+3:  128
[ 2 ]
Imprimitive 2+2+2:  16777216
[ 2 ]
Class C4:  22799473113563136
[ 2, 3 ]
*/

/*
C:=[a^7+a^6-a^4-a^2-a, a^4 + a^2 + a + 1];
N:=7967;
BadPrimes := [31,257];
*/
/*
Reducible One-Dim:  2957312
[ 2, 19 ]
Reducible Three-Dim:  1
[]
Imprimitive 3+3:  1
[]
Imprimitive 2+2+2:  8
[ 2 ]
Class C4:  1099511627776
[ 2 ]
Small prime exception or exceptional group:  171722 [ <2, 1>, <19, 1>, <4519, 1>
]
Exceptional of Lie Type ruled out for:  [ 3, 5, 7, 11, 13 ]
*/


/*
C:=[a^7-8*a^5-4*a^4+18*a^3-3*a^2-16*a+8,a^4+a^3+a^2+1];
N:=8233;
BadPrimes := PrimeDivisors(N);
*/
/*
Reducible One-Dim:  483729408
[ 2, 3 ]
Reducible Three-Dim:  1
[]
Imprimitive 3+3:  2
[ 2 ]
Imprimitive 2+2+2:  8
[ 2 ]
Class C4:  4294967296
[ 2 ]
Small prime exception or exceptional group:  6 [ <2, 1>, <3, 1> ]
Exceptional of Lie Type ruled out for:  [ 3, 5, 7, 11, 13 ]

*/

/*

C:=[a^3+a^2,a^4+a^3+a+1];
N:=8907;
BadPrimes := PrimeDivisors(N);
*/
/*
Reducible One-Dim:  2048
[ 2 ]
Reducible Three-Dim:  1
[]
Imprimitive 3+3:  1
[]
Imprimitive 2+2+2:  50
[ 2, 5 ]
Class C4:  4294967296
[ 2 ]
Small prime exception or exceptional group:  2 [ <2, 1> ]
Exceptional of Lie Type ruled out for:  [ 3, 5, 7, 11, 13 ]
*/
/*
C:=[-2*a^4+a^3-2*a^2,a^4+a+1];
N:=4458861;
BadPrimes:=PrimeDivisors(N);
*/
/*
Reducible One-Dim:  128
[ 2 ]
Reducible Three-Dim:  1
[]
Imprimitive 3+3:  1
[]
Imprimitive 2+2+2:  317827579904
[ 2, 37 ]
Class C4:  256
[ 2 ]
Small prime exception or exceptional group:  2 [ <2, 1> ]
Exceptional of Lie Type ruled out for:  [ 2, 3, 5, 7, 11, 13 ]
*/

T:=[];
j:=1;
for i in [1..B] do
    if IsPrime(i) and not (i in BadPrimes) then
        T[j]:=i;
        j:=j+1;
    end if;
end for;


/*Generic polynomials P^(e) (raising the roots to the e power) for e = 2,3,5,7 */
polys:= [
    x^6 + (-e_1^2 + 2*e_2)*x^5 + (-2*e_1*e_3 + e_2^2 + 2*e_4)*x^4 + (-2*e_1*e_5
        + 2*e_2*e_4 - e_3^2 + 2*e_6)*x^3 + (2*e_2*e_6 - 2*e_3*e_5 + e_4^2)*x^2 +
        (2*e_4*e_6 - e_5^2)*x + e_6^2,
    x^6 + (-e_1^3 + 3*e_1*e_2 - 3*e_3)*x^5 + (3*e_1^2*e_4 - 3*e_1*e_2*e_3 -
        3*e_1*e_5 + e_2^3 - 3*e_2*e_4 + 3*e_3^2 + 3*e_6)*x^4 + (3*e_1*e_2*e_6 +
        3*e_1*e_3*e_5 - 3*e_1*e_4^2 - 3*e_2^2*e_5 + 3*e_2*e_3*e_4 - e_3^3 -
        6*e_3*e_6 + 3*e_4*e_5)*x^3 + (-3*e_1*e_5*e_6 - 3*e_2*e_4*e_6 +
        3*e_2*e_5^2 + 3*e_3^2*e_6 - 3*e_3*e_4*e_5 + e_4^3 + 3*e_6^2)*x^2 +
        (-3*e_3*e_6^2 + 3*e_4*e_5*e_6 - e_5^3)*x + e_6^3,
    x^6 + (-e_1^5 + 5*e_1^3*e_2 - 5*e_1^2*e_3 - 5*e_1*e_2^2 + 5*e_1*e_4 +
        5*e_2*e_3 - 5*e_5)*x^5 + (5*e_1^4*e_6 - 5*e_1^3*e_2*e_5 -
        5*e_1^3*e_3*e_4 + 5*e_1^2*e_2^2*e_4 + 5*e_1^2*e_2*e_3^2 -
        15*e_1^2*e_2*e_6 + 10*e_1^2*e_3*e_5 + 5*e_1^2*e_4^2 - 5*e_1*e_2^3*e_3 +
        10*e_1*e_2^2*e_5 - 5*e_1*e_2*e_3*e_4 - 5*e_1*e_3^3 + 10*e_1*e_3*e_6 -
        15*e_1*e_4*e_5 + e_2^5 - 5*e_2^3*e_4 + 5*e_2^2*e_3^2 + 5*e_2^2*e_6 -
        15*e_2*e_3*e_5 + 5*e_2*e_4^2 + 5*e_3^2*e_4 - 5*e_4*e_6 + 10*e_5^2)*x^4 +
        (-10*e_1^3*e_6^2 + 15*e_1^2*e_2*e_5*e_6 + 15*e_1^2*e_3*e_4*e_6 -
        5*e_1^2*e_3*e_5^2 - 5*e_1^2*e_4^2*e_5 - 10*e_1*e_2^2*e_4*e_6 -
        5*e_1*e_2^2*e_5^2 - 10*e_1*e_2*e_3^2*e_6 + 5*e_1*e_2*e_3*e_4*e_5 +
        5*e_1*e_2*e_4^3 + 15*e_1*e_2*e_6^2 + 5*e_1*e_3^3*e_5 - 5*e_1*e_3^2*e_4^2
        - 20*e_1*e_3*e_5*e_6 - 10*e_1*e_4^2*e_6 + 15*e_1*e_4*e_5^2 +
        5*e_2^3*e_3*e_6 + 5*e_2^3*e_4*e_5 - 5*e_2^2*e_3^2*e_5 -
        5*e_2^2*e_3*e_4^2 - 10*e_2^2*e_5*e_6 + 5*e_2*e_3^3*e_4 +
        5*e_2*e_3*e_4*e_6 + 15*e_2*e_3*e_5^2 - 10*e_2*e_4^2*e_5 - e_3^5 +
        5*e_3^3*e_6 - 10*e_3^2*e_4*e_5 + 5*e_3*e_4^3 - 5*e_3*e_6^2 +
        15*e_4*e_5*e_6 - 10*e_5^3)*x^3 + (10*e_1^2*e_6^3 - 15*e_1*e_2*e_5*e_6^2
        - 15*e_1*e_3*e_4*e_6^2 + 10*e_1*e_3*e_5^2*e_6 + 10*e_1*e_4^2*e_5*e_6 -
        5*e_1*e_4*e_5^3 + 5*e_2^2*e_4*e_6^2 + 5*e_2^2*e_5^2*e_6 +
        5*e_2*e_3^2*e_6^2 - 5*e_2*e_3*e_4*e_5*e_6 - 5*e_2*e_3*e_5^3 -
        5*e_2*e_4^3*e_6 + 5*e_2*e_4^2*e_5^2 - 5*e_2*e_6^3 - 5*e_3^3*e_5*e_6 +
        5*e_3^2*e_4^2*e_6 + 5*e_3^2*e_4*e_5^2 - 5*e_3*e_4^3*e_5 +
        10*e_3*e_5*e_6^2 + e_4^5 + 5*e_4^2*e_6^2 - 15*e_4*e_5^2*e_6 +
        5*e_5^4)*x^2 + (-5*e_1*e_6^4 + 5*e_2*e_5*e_6^3 + 5*e_3*e_4*e_6^3 -
        5*e_3*e_5^2*e_6^2 - 5*e_4^2*e_5*e_6^2 + 5*e_4*e_5^3*e_6 - e_5^5)*x +
        e_6^5,
    x^6 + (-e_1^7 + 7*e_1^5*e_2 - 7*e_1^4*e_3 - 14*e_1^3*e_2^2 + 7*e_1^3*e_4 +
        21*e_1^2*e_2*e_3 - 7*e_1^2*e_5 + 7*e_1*e_2^3 - 14*e_1*e_2*e_4 -
        7*e_1*e_3^2 + 7*e_1*e_6 - 7*e_2^2*e_3 + 7*e_2*e_5 + 7*e_3*e_4)*x^5 +
        (-7*e_1^5*e_3*e_6 - 7*e_1^5*e_4*e_5 + 7*e_1^4*e_2^2*e_6 +
        14*e_1^4*e_2*e_3*e_5 + 7*e_1^4*e_2*e_4^2 + 7*e_1^4*e_3^2*e_4 +
        14*e_1^4*e_4*e_6 + 7*e_1^4*e_5^2 - 7*e_1^3*e_2^3*e_5 -
        21*e_1^3*e_2^2*e_3*e_4 - 7*e_1^3*e_2*e_3^3 + 7*e_1^3*e_2*e_3*e_6 +
        7*e_1^3*e_2*e_4*e_5 - 21*e_1^3*e_3^2*e_5 - 21*e_1^3*e_3*e_4^2 -
        21*e_1^3*e_5*e_6 + 7*e_1^2*e_2^4*e_4 + 14*e_1^2*e_2^3*e_3^2 -
        21*e_1^2*e_2^3*e_6 - 14*e_1^2*e_2^2*e_3*e_5 - 7*e_1^2*e_2^2*e_4^2 +
        35*e_1^2*e_2*e_3^2*e_4 - 14*e_1^2*e_2*e_4*e_6 - 7*e_1^2*e_2*e_5^2 +
        7*e_1^2*e_3^4 - 7*e_1^2*e_3^2*e_6 + 35*e_1^2*e_3*e_4*e_5 +
        14*e_1^2*e_4^3 + 14*e_1^2*e_6^2 - 7*e_1*e_2^5*e_3 + 14*e_1*e_2^4*e_5 +
        7*e_1*e_2^3*e_3*e_4 - 21*e_1*e_2^2*e_3^3 + 35*e_1*e_2^2*e_3*e_6 -
        14*e_1*e_2^2*e_4*e_5 + 35*e_1*e_2*e_3^2*e_5 - 14*e_1*e_2*e_3*e_4^2 +
        7*e_1*e_2*e_5*e_6 - 21*e_1*e_3^3*e_4 + 7*e_1*e_3*e_4*e_6 -
        21*e_1*e_3*e_5^2 - 21*e_1*e_4^2*e_5 + e_2^7 - 7*e_2^5*e_4 +
        7*e_2^4*e_3^2 + 7*e_2^4*e_6 - 21*e_2^3*e_3*e_5 + 14*e_2^3*e_4^2 -
        7*e_2^2*e_3^2*e_4 - 21*e_2^2*e_4*e_6 + 14*e_2^2*e_5^2 + 7*e_2*e_3^4 -
        21*e_2*e_3^2*e_6 + 7*e_2*e_3*e_4*e_5 - 7*e_2*e_4^3 + 7*e_2*e_6^2 -
        7*e_3^3*e_5 + 14*e_3^2*e_4^2 + 14*e_3*e_5*e_6 + 7*e_4^2*e_6 +
        7*e_4*e_5^2)*x^4 + (-7*e_1^4*e_5*e_6^2 + 21*e_1^3*e_2*e_4*e_6^2 +
        21*e_1^3*e_2*e_5^2*e_6 - 14*e_1^3*e_3^2*e_6^2 - 7*e_1^3*e_3*e_4*e_5*e_6
        + 7*e_1^3*e_3*e_5^3 + 7*e_1^3*e_4^3*e_6 - 14*e_1^3*e_4^2*e_5^2 +
        7*e_1^3*e_6^3 + 7*e_1^2*e_2^2*e_3*e_6^2 - 35*e_1^2*e_2^2*e_4*e_5*e_6 -
        14*e_1^2*e_2^2*e_5^3 + 14*e_1^2*e_2*e_3^2*e_5*e_6 -
        35*e_1^2*e_2*e_3*e_4^2*e_6 + 14*e_1^2*e_2*e_3*e_4*e_5^2 +
        21*e_1^2*e_2*e_4^3*e_5 - 35*e_1^2*e_2*e_5*e_6^2 + 21*e_1^2*e_3^3*e_4*e_6
        - 14*e_1^2*e_3^3*e_5^2 + 7*e_1^2*e_3^2*e_4^2*e_5 - 7*e_1^2*e_3*e_4^4 +
        14*e_1^2*e_3*e_4*e_6^2 - 35*e_1^2*e_3*e_5^2*e_6 + 14*e_1^2*e_4^2*e_5*e_6
        + 21*e_1^2*e_4*e_5^3 - 7*e_1*e_2^4*e_6^2 - 7*e_1*e_2^3*e_3*e_5*e_6 +
        21*e_1*e_2^3*e_4^2*e_6 + 21*e_1*e_2^3*e_4*e_5^2 +
        14*e_1*e_2^2*e_3^2*e_4*e_6 + 7*e_1*e_2^2*e_3^2*e_5^2 -
        35*e_1*e_2^2*e_3*e_4^2*e_5 - 7*e_1*e_2^2*e_4^4 - 35*e_1*e_2^2*e_4*e_6^2
        + 14*e_1*e_2^2*e_5^2*e_6 - 14*e_1*e_2*e_3^4*e_6 -
        7*e_1*e_2*e_3^3*e_4*e_5 + 21*e_1*e_2*e_3^2*e_4^3 +
        14*e_1*e_2*e_3^2*e_6^2 + 105*e_1*e_2*e_3*e_4*e_5*e_6 -
        7*e_1*e_2*e_3*e_5^3 - 7*e_1*e_2*e_4^3*e_6 - 35*e_1*e_2*e_4^2*e_5^2 +
        21*e_1*e_2*e_6^3 + 7*e_1*e_3^5*e_5 - 7*e_1*e_3^4*e_4^2 -
        7*e_1*e_3^3*e_5*e_6 - 35*e_1*e_3^2*e_4^2*e_6 + 14*e_1*e_3^2*e_4*e_5^2 -
        7*e_1*e_3*e_4^3*e_5 + 14*e_1*e_3*e_5*e_6^2 + 7*e_1*e_4^5 +
        7*e_1*e_4^2*e_6^2 - 35*e_1*e_4*e_5^2*e_6 - 7*e_1*e_5^4 + 7*e_2^5*e_5*e_6
        - 14*e_2^4*e_3*e_4*e_6 - 7*e_2^4*e_3*e_5^2 - 7*e_2^4*e_4^2*e_5 +
        7*e_2^3*e_3^3*e_6 + 21*e_2^3*e_3^2*e_4*e_5 + 7*e_2^3*e_3*e_4^3 +
        21*e_2^3*e_3*e_6^2 - 7*e_2^3*e_4*e_5*e_6 + 7*e_2^3*e_5^3 -
        7*e_2^2*e_3^4*e_5 - 14*e_2^2*e_3^3*e_4^2 - 35*e_2^2*e_3^2*e_5*e_6 +
        14*e_2^2*e_3*e_4^2*e_6 - 35*e_2^2*e_3*e_4*e_5^2 + 21*e_2^2*e_4^3*e_5 +
        7*e_2^2*e_5*e_6^2 + 7*e_2*e_3^5*e_4 - 7*e_2*e_3^3*e_4*e_6 +
        21*e_2*e_3^3*e_5^2 + 14*e_2*e_3^2*e_4^2*e_5 - 14*e_2*e_3*e_4^4 -
        35*e_2*e_3*e_4*e_6^2 + 14*e_2*e_3*e_5^2*e_6 - 35*e_2*e_4^2*e_5*e_6 +
        21*e_2*e_4*e_5^3 - e_3^7 + 7*e_3^5*e_6 - 14*e_3^4*e_4*e_5 +
        7*e_3^3*e_4^3 - 14*e_3^3*e_6^2 + 14*e_3^2*e_4*e_5*e_6 - 14*e_3^2*e_5^3 +
        21*e_3*e_4^3*e_6 + 7*e_3*e_4^2*e_5^2 + 7*e_3*e_6^3 - 7*e_4^4*e_5 +
        21*e_4*e_5*e_6^2 + 7*e_5^3*e_6)*x^3 + (7*e_1^2*e_2*e_6^4 -
        21*e_1^2*e_3*e_5*e_6^3 + 14*e_1^2*e_4^2*e_6^3 - 7*e_1^2*e_4*e_5^2*e_6^2
        + 7*e_1^2*e_5^4*e_6 - 21*e_1*e_2^2*e_5*e_6^3 + 7*e_1*e_2*e_3*e_4*e_6^3 +
        35*e_1*e_2*e_3*e_5^2*e_6^2 - 14*e_1*e_2*e_4^2*e_5*e_6^2 +
        7*e_1*e_2*e_4*e_5^3*e_6 - 7*e_1*e_2*e_5^5 - 7*e_1*e_3^3*e_6^3 +
        35*e_1*e_3^2*e_4*e_5*e_6^2 - 21*e_1*e_3^2*e_5^3*e_6 -
        21*e_1*e_3*e_4^3*e_6^2 - 14*e_1*e_3*e_4^2*e_5^2*e_6 +
        14*e_1*e_3*e_4*e_5^4 + 14*e_1*e_3*e_6^4 + 14*e_1*e_4^4*e_5*e_6 -
        7*e_1*e_4^3*e_5^3 + 7*e_1*e_4*e_5*e_6^3 - 21*e_1*e_5^3*e_6^2 -
        7*e_2^3*e_4*e_6^3 + 14*e_2^3*e_5^2*e_6^2 + 14*e_2^2*e_3^2*e_6^3 -
        14*e_2^2*e_3*e_4*e_5*e_6^2 - 21*e_2^2*e_3*e_5^3*e_6 +
        14*e_2^2*e_4^3*e_6^2 - 7*e_2^2*e_4^2*e_5^2*e_6 + 7*e_2^2*e_4*e_5^4 +
        7*e_2^2*e_6^4 - 21*e_2*e_3^3*e_5*e_6^2 - 7*e_2*e_3^2*e_4^2*e_6^2 +
        35*e_2*e_3^2*e_4*e_5^2*e_6 + 7*e_2*e_3^2*e_5^4 + 7*e_2*e_3*e_4^3*e_5*e_6
        - 21*e_2*e_3*e_4^2*e_5^3 + 7*e_2*e_3*e_5*e_6^3 - 7*e_2*e_4^5*e_6 +
        7*e_2*e_4^4*e_5^2 - 21*e_2*e_4^2*e_6^3 - 14*e_2*e_4*e_5^2*e_6^2 +
        14*e_2*e_5^4*e_6 + 7*e_3^4*e_4*e_6^2 + 7*e_3^4*e_5^2*e_6 -
        21*e_3^3*e_4^2*e_5*e_6 - 7*e_3^3*e_4*e_5^3 + 7*e_3^2*e_4^4*e_6 +
        14*e_3^2*e_4^3*e_5^2 - 21*e_3^2*e_4*e_6^3 - 7*e_3^2*e_5^2*e_6^2 -
        7*e_3*e_4^5*e_5 + 35*e_3*e_4^2*e_5*e_6^2 + 7*e_3*e_4*e_5^3*e_6 -
        7*e_3*e_5^5 + e_4^7 + 7*e_4^4*e_6^2 - 21*e_4^3*e_5^2*e_6 + 7*e_4^2*e_5^4
        + 7*e_4*e_6^4 + 14*e_5^2*e_6^3)*x^2 + (7*e_1*e_4*e_6^5 -
        7*e_1*e_5^2*e_6^4 + 7*e_2*e_3*e_6^5 - 14*e_2*e_4*e_5*e_6^4 +
        7*e_2*e_5^3*e_6^3 - 7*e_3^2*e_5*e_6^4 - 7*e_3*e_4^2*e_6^4 +
        21*e_3*e_4*e_5^2*e_6^3 - 7*e_3*e_5^4*e_6^2 + 7*e_4^3*e_5*e_6^3 -
        14*e_4^2*e_5^3*e_6^2 + 7*e_4*e_5^5*e_6 - e_5^7 + 7*e_5*e_6^5)*x + e_6^7
];
/*numberedp[n] is the generic polynomial for P^(n)*/
numberedp:= [];
numberedp[2]:= polys[1];
numberedp[3]:= polys[2];
numberedp[5]:= polys[3];
numberedp[7]:= polys[4];

/*Given a polynomial p, computes p^(e) (raising the roots to e) */
SpecializePoly:=function(p,e)
    g:=x^6;
    
    w:=Reverse(Prune(Coefficients(p)));

    /*sign discrepencies with expressing coefficients with elementary symmetric polynomials*/
    w[1]:= -w[1];
    w[3]:= -w[3];
    w[5]:= -w[5];
    
    for i in [1..6] do
        g:= g + Evaluate(Coefficients(numberedp[e])[i],w)*x^(i-1);
    end for;
    
return g;
end function;
/*
Given a polynomial p, computes p^(e^n) (raising the roots to e^n)
*/
IterateSpecializePoly := function(p,e,n)
    q:=p; 
    for i in [1..n] do
        q:=SpecializePoly(q,e);
    end for;
    return q;
end function;

/* 
Given a polynomial p, computes p^(2520) (raising the roots to 2520)
*/
p2520:=function(p)
    q:=p;
    q:=IterateSpecializePoly(q,2,3);
    q:=IterateSpecializePoly(q,3,2);
    q:=IterateSpecializePoly(q,5,1);
    q:=IterateSpecializePoly(q,7,1);
    return q;
end function;

/* 
Input: Two polynomials defining a hyperelliptic curve, auxiliary primes
Returns list of frobenius polynomials for the given auxiliary primes
*/
ComputeFrobPolys:= function(C,T)
    frobpolys:=[];
    for p in T do
    
        coeff:=[];
        coeff[1]:= Coefficients(C[1]);
        coeff[2]:= Coefficients(C[2]);

        coeffp1:=[];
        coeffp2:=[];
    
        i:=1;
        for c in coeff[1] do
            coeffp1[i] := GF(p)! c;
            i:=i+1; 
        end for;
        i:=1;
        for c in coeff[2] do
            coeffp2[i] := GF(p)! c; 
            i:=i+1;
        end for;
        _<b>:=PolynomialRing(GF(p));
        q1:=Polynomial(coeffp1);
        q2:=0;
        if IsEmpty(coeffp2) eq false then
            q2:=Polynomial(coeffp2);
        end if;
       
        Cp:=HyperellipticCurve([q1,q2]);
   
        frobpoly := y^6*Evaluate(Parent(y)!LPolynomial(Cp),1/y);
        frobpoly:=Parent(y)!frobpoly;

        frobpolys[p]:=frobpoly;

    end for;

    return frobpolys;
end function;

/*
Input: Two polynomials defining a hyperelliptic curve, auxiliary primes
Returns an integer whose prime factors are the possible one-dimensional cases
*/
ReducibleOneDim := function(C,T)

    frobpolys:=ComputeFrobPolys(C,T);

    eigen1list:=[]; /*list of values for P_p(1), where p runs through auxiliary primes*/
    j:=1;
    for p in T do
    
        eigen1list[j]:=Integers()! Evaluate(p2520(frobpolys[p]),1);
        j:=j+1;

    end for;

    return Gcd(eigen1list);

end function;

/*
Returns a polynomial with the roots consisting of all possible traces
of degree 2 factors of P_p.
*/
TracePoly:= function(P,p)  
    K:=SplittingField(P); Pol<v>:=PolynomialRing(K);

    return &*[v-a : a in {r[1]+p/r[1]: r in Roots(Pol!P)}];
end function;

/*
Input: Two polynomials defining a hyperelliptic curve, conductor, auxiliary primes
Returns an integers whose prime factors are the possible two-dimensional cases
*/
ReducibleTwoDim:= function(C,N,T)
    _<v>:=PolynomialRing(Rationals());
    frobpolys := ComputeFrobPolys(C,T);
    res:=[];
    i:=1;

    S:= CuspForms(Gamma0(N));
    for p in T do
        tracep:=TracePoly(frobpolys[p],p);
        heckep:=Parent(v)!HeckePolynomial(S,p);
        /*Check if the Hecke polynomial has a_p as a root, in which case a_p is an eigenvalue for T_p and so might come from an eigenform*/
        res[i]:= Integers()!Resultant(tracep, heckep);
        i:=i+1;
    end for;

    return Gcd(res);
end function;

/*
Input: Two polynomials defining a hyperelliptic curve, auxiliary primes
Returns an integer whose prime factors are the possible three-dimensional cases
*/
ReducibleThreeDim:= function(C,T)
    frobpolys:=ComputeFrobPolys(C,T);

    res1 := []; /*quantity that must be 0 for tame inertia weight e=0 case, one for each auxiliary prime*/
    res2 := []; /*quantity that must be 0 for tame inertia weight e=1 case, one for each auxiliary prime*/
    i:=1;
    for p in T do
        _<u>:=PolynomialRing(Rationals());
        frobpoly:=frobpolys[p];
        a5:=Coefficients(frobpoly)[6];
        a4:=Coefficients(frobpoly)[5];
        a3:=Coefficients(frobpoly)[4];
       
        q1:=p^2520*u + (-u - a5) + u*(-u - a5)-a4;
        q2:=-(p^2520*+p^(2520*2)+u^2*p^2520+(-u-a5)^2) - a3;
        
        res1[i]:=Integers()!Resultant(q1,q2);

        q1:=-a5*u - a5*p^2520 - u^2*p^2520 - u*p^5040 + u - a4;
        q2:=-a5^2*p^2520 - 2*a5*u * p^5040 - u^2 * p^7560 - u^2 - p^5040 - p^2520 - a3;
        
        res2[i]:=Integers()!Resultant(q1,q2);
        
        i:=i+1;
    end for; 

    
    M1:=Gcd(res1);
    M2:=Gcd(res2);

    return M1*M2;
    

end function;
/*This is essentially the algorithm of the many-authored genus 2 paper
for dealing with an imprimitive composition into two subspaces.
*/
ImprimitiveTwoDecomp:= function(C,N,T)

    frobpolys:=ComputeFrobPolys(C,T);
    chars:=Elements(DirichletGroup(N));


    M:=[]; /*M[j] is a quantity that must be 0 if the jth Dirichlet character in our list governs our representation*/
    j:=1;
    for char in chars do
        m:=[];

        /*populate "m=[]" with all traces governed by the Dirichlet character "char"*/
        i:=1;
        for p in T do 
            frobpoly:=frobpolys[p];
            
            a_p:=Coefficients(frobpoly)[6];
            if a_p ne 0 and char(p) eq -1 then
                m[i]:=Integers()!a_p;
                i:=i+1;
            end if;
        end for;
        if IsEmpty(m) and Conductor(char) ne 1 then
            /*There are no conditions on the primes for this specific character. 
            Try adding more auxiliary primes */
            return 0;
        end if;
        if not IsEmpty(m) then
            M[j]:=Gcd(m); /*all traces in "m" must be 0 for "char" to be the right character*/
            j:=j+1;
           
        end if;
    end for;

    imprim:=1;
    for n in M do
        imprim:=imprim*n;
    end for;    
    return imprim;
end function; 

/*
Input: Two polynomials defining a hyperelliptic curve, conductor, auxiliary primes
Returns two integers [a,b]. The prime factors of a are those where the permutation 
action of G_Q on V_1 \oplus V_2 \oplus V_3 is possibly not contained in A_3. 
The prime factors of b are those primes where, if the action is contained in A_3,
then the action is trivial. 
*/
ImprimitiveThreeDecomp:=function(C,N,T);
    frobpolys:=ComputeFrobPolys(C,T);


    /*Phase 1: rule out the primes where the action is not contained in A_3 */
    chars:=Elements(DirichletGroup(N));

    M:=[];
    j:=1;
    for char in chars do
        m:=[];
        i:=1;
        for p in T do
            frobpoly:=frobpolys[p];
               
            _<c>:=PolynomialRing(Rationals());
            a5:=Coefficients(frobpoly)[6];    
            a4:=Coefficients(frobpoly)[5];
            a3:=Coefficients(frobpoly)[4];
            a2:=Coefficients(frobpoly)[3];
            a1:=Coefficients(frobpoly)[2];
               
            q1:=c^3 + (a3*a5-a5^2*a4-a2)*c^2 + (a4*p^3 - a5^2*p^3)*c - p^6;
            q2:=a5*c^3 - a1*c^2 + (a3*a5*p^3 - a4*a5*p^3)*c + p^6*a5;
            r_p:=Integers()!Resultant(q1,q2);
            if r_p ne 0 and char(p) eq -1 then
                m[i]:=Integers()!r_p;
                i:=i+1;
            end if;
        end for;
        if IsEmpty(m) and Conductor(char) ne 1 then
            /*There are no conditions on the primes for this specific character. 
              Try adding more auxiliary primes */
            return 0;
        end if;
        if not IsEmpty(m) then
            M[j]:=Gcd(m);
            j:=j+1;
        end if;
    end for;

    imprimquad:=1;
    for n in M do
        imprimquad:=imprimquad*n;
    end for;

    /*Phase 2: Assuming the action is contained in A_3, rule out primes where the 
    action is nontrivial. This is essentially the same test as the many-authored
    paper for imprimitivity, but with characters mapping to the cyclic group of 
    order 3 instead of order 2.*/

    _<z>:=PolynomialRing(Rationals());
    K<zeta>:=NumberField(z^2 + z + 1);
    chars:=Elements(DirichletGroup(N,K,zeta,3));

    M:=[];

    for char in chars do
     
        m:=[];
        
        i:=1;
        for p in T do
            frobpoly:=frobpolys[p];
            
            a_p:=Coefficients(frobpoly)[6];
            
            if a_p ne 0 and char(p) ne 1 then
                m[i]:=Integers()!a_p;
                i:=i+1;
                
            end if;
        end for;
          if IsEmpty(m) and Conductor(char) ne 1 then
            /*There are no conditions on the primes for this specific character. 
              Try adding more auxiliary primes */
            print "Phase 2 failed.";
            
            
            return 0;
        end if;
        if not IsEmpty(m) then
            M[j]:=Gcd(m);
            j:=j+1;
        end if;
    end for;

    imprim:=1;
    for n in M do
        imprim:=imprim*n;
    end for;

    return imprimquad* imprim;

end function;

/*
Input: Curve, auxiliary primes
Returns an integer whose prime factors are the possible cases where the geometric maximal subgroup 
of class 4 may possibly happen.
*/
MaximalSubgroupC4 := function(C, T)
    frobs:=ComputeFrobPolys(C,T);

    MM:=[];
    c:=1;
    
    for p in T do
        frobpoly:=frobs[p];
       
        
        M:=1;
        R:=Roots(frobpoly,ComplexField(1000));

        if Discriminant(frobpoly) ne 0 then
            for i in R do
                for j in R do
                    if j ne i then
                        for k in R do
                            if k ne i and k ne j then
                                M := M * (i[1]^2 - j[1]*k[1]);  
                            end if;
                        end for;
                    end if;
                end for;
            end for;
            MM[c]:=Integers()! Round(M);
            c:=c+1;
        end if;
    end for;
    return Gcd(MM);
end function;


TestC1andC2 := function(C,ell, T,frobs)
   
    for p in T do
       
        coeff:=Coefficients(frobs[p]);
        coeffp:=[];
        for i in [1..7] do
            coeffp[i]:=GF(ell) ! Integers()!coeff[i];
        end for;
        _<b>:=PolynomialRing(GF(ell));
        pol:=Polynomial(coeffp);
        
        ap:=Coefficient(pol,5);
        //pol,Factorization(pol);
        if IsIrreducible(pol) and not (ap eq 0) and not (ell eq p) then
            return 1, frobs[p];
        end if;
    end for;
    return 0;
end function;

TestC3:=function(C,ell,T,frobs)
    for p in T do
       
        coeff:=Coefficients(frobs[p]);
        coeffp:=[];
        for i in [1..7] do
            coeffp[i]:=GF(ell) ! Integers()!coeff[i];
        end for;
        _<b>:=PolynomialRing(GF(ell));
        pol:=Polynomial(coeffp);
        
        ap:=Coefficient(pol,5);
        if not (ap eq 0) and not (p eq ell) then
            roots:=Roots(pol, GF(ell));
            for alpha in roots do
                if not (alpha[2] mod 2 eq 0) then
                    return 1, Factorization(pol);
                end if;
            end for;
        end if;
    end for;
    return 0;
end function;

TestExceptionals := function(C,ell,T,frobs)
    for p in T do
       
        coeff:=Coefficients(frobs[p]);
        coeffp:=[];
        for i in [1..7] do
            coeffp[i]:=GF(ell) ! Integers()!coeff[i];
        end for;
        _<b>:=PolynomialRing(GF(ell));
        pol:=Polynomial(coeffp);
        
        
        if IsSeparable(pol) then
            t:=1;
            divs:= [1,2,3,4,5,6,7,8,10,12,13, 15];
            for d in divs do
                h:= b^(d * (ell-1) * 2) - 1;
                f:= Gcd(pol, h);
                if f eq pol then
                    t:= 0;
                end if;
            end for;
           
            if t eq 1 then
                return 1, pol;
            end if;

        end if;

        

    end for;
    return 0;

end function;

TestExceptionalLieType := function(C,T,frobs)
    leftover:=[2,3,5,7,11,13];
    ruledout := [];
    j:=1;

    for ell in leftover do
        for p in T do
       
            coeff:=Coefficients(frobs[p]);
            coeffp:=[];
            for i in [1..7] do
                coeffp[i]:=GF(ell) ! Integers()!coeff[i];
            end for;
            _<b>:=PolynomialRing(GF(ell));
            pol:=Polynomial(coeffp);
            if IsSeparable(pol) and not (ell in ruledout) then
                ord1 := ell * (ell - 1);
                ord2 := ell^2 - 1;
        
                f1:=b^ord1 - 1;
                f2:=b^ord2 - 1;

                if not (Gcd(pol, f1) eq pol) and not (Gcd(pol,f2) eq pol) then
                    ruledout[j]:=ell;
                    j:=j+1;
                end if;
            end if;

        end for;
    end for;
    return ruledout;
end function;



Red1:=ReducibleOneDim(C,T);

Red3:=ReducibleThreeDim(C,T);

Imp2:=ImprimitiveTwoDecomp(C,N,T);

C4:=MaximalSubgroupC4(C,T);

Imp3:= ImprimitiveThreeDecomp(C,N,T);





print "Reducible One-Dim: ", Red1;
if not Red1 eq 0 then
  PrimeDivisors(Red1);
end if;
print "Reducible Three-Dim: ", Red3;
if not Red3 eq 0 then
  PrimeDivisors(Red3);
end if;
print "Imprimitive 3+3: ", Imp2;
if not Imp2 eq 0 then
  PrimeDivisors(Imp2);
end if;

print "Imprimitive 2+2+2: ", Imp3;
if not Imp3 eq 0 then
  PrimeDivisors(Imp3);
end if;

print "Class C4: ", C4;
if not C4 eq 0 then
  PrimeDivisors(C4);
end if;



/*
j:=1;
for i in [1..200] do
    if IsPrime(i) and not (i in BadPrimes) then
        T[j]:=i;
        j:=j+1;
    end if;
end for;

frobs:=ComputeFrobPolys(C,T);

M:=1;
for ell in [1..2520*2+1] do
    if IsPrime(ell) then
        t1:=TestC1andC2(C,ell,T,frobs);
        t2:=TestC3(C,ell, T,frobs);
        t3:=TestExceptionals(C,ell, T,frobs);
        //ell;
        //t1,t2,t3;
        if t1 eq 0 or t2 eq 0 or t3 eq 0 then
            M:=M*ell;
        end if;
    end if;
end for;
print "Small prime exception or exceptional group: ", M, Factorization(M);
print "Exceptional of Lie Type ruled out for: ", TestExceptionalLieType(C, T,frobs);
*/
