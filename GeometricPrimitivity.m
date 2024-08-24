_<e_1,e_2,e_3,e_4,e_5,e_6>:=PolynomialRing(Rationals(),6);
_<x>:=PolynomialRing(Parent(e_1));
_<y>:=PolynomialRing(Rationals());
_<a>:=PolynomialRing(Integers());

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
numberedp:= [];
numberedp[2]:= polys[1];
numberedp[3]:= polys[2];
numberedp[5]:= polys[3];
numberedp[7]:= polys[4];

/*Given a polynomial p, computes p^(e) (raising the roots to e) */
SpecializePoly:=function(p,e)
    g:=x^6;
    
    w:=Reverse(Prune(Coefficients(p)));
  
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
        coeffp1[i] := c;
        i:=i+1; 
    end for;
    i:=1;
    for c in coeff[2] do
        coeffp2[i] := GF(p)! c; 
        i:=i+1;
    end for;
    _<b>:=PolynomialRing(GF(p));

    q1:=Polynomial(coeffp1);
    q2:=Polynomial(coeffp2);

    Cp:=HyperellipticCurve([q1,q2]);
   
    frobpoly := y^6*Evaluate(Parent(y)!LPolynomial(Cp),1/y);
    frobpoly:=Parent(y)!frobpoly;

    frobpolys[p]:=frobpoly;

end for;

return frobpolys;
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
    for p in T do 
        frobpoly:=frobpolys[p];
        i:=1;
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
    
    for p in T do
        frobpoly:=frobpolys[p];
        i:=1;
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
        M[j]:=Gcd(m);
        j:=j+1;
    end if;
end for;

imprim:=1;
for n in M do
    imprim:=imprim*n;
end for;
    
return imprimquad, imprim;

end function;

/*Examples*/
ImprimitiveTwoDecomp([a^3+a^2+a,a^4+a^3+a^2+1],5911,[2,3,5,7,11,13,17]);
ImprimitiveThreeDecomp([a^3+a^2+a,a^4+a^3+a^2+1],5911,[2,3,5,7,11,13,17]);

