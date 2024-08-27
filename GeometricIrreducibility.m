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

/*
Input: Two polynomials defining a hyperelliptic curve, auxiliary primes
Returns an integer whose prime factors are the possible one-dimensional cases
*/
ReducibleOneDim := function(C,T)

    frobpolys:=ComputeFrobPolys(C,T);

    eigen1list:=[]; /*list of values for P_p(1), where p runs through auxiliary primes*/
    j:=1;
    for p in T do
    
        eigen1list[j]:=Evaluate(p2520(frobpolys[p]),1);
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

/*Example*/
ReducibleOneDim([a^3+a^2+a,a^4+a^3+a^2+1],[2,3,5]);
ReducibleTwoDim([a^3+a^2+a,a^4+a^3+a^2+1],5911,[2,3]);
ReducibleThreeDim([a^3+a^2+a,a^4+a^3+a^2+1],[2,3,5]);
