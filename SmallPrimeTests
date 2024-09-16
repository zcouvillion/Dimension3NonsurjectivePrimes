_<a>:=PolynomialRing(Integers());
_<y>:=PolynomialRing(Rationals());

C:=[a^3+a^2+a,a^4+a^3+a^2+1];
BadPrimes:=[23,257];

T:=[];
j:=1;
for i in [1..20] do
    if IsPrime(i) and not (i in BadPrimes) then
        T[j]:=i;
        j:=j+1;
    end if;
end for;




/* 
Input: Curve, auxiliary primes
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

frobs:=ComputeFrobPolys(C,T);

TestC1andC2 := function(C,ell, T)
   
    for p in T do
       
        coeff:=Coefficients(frobs[p]);
        coeffp:=[];
        for i in [1..7] do
            coeffp[i]:=GF(ell) ! Integers()!coeff[i];
        end for;
        _<b>:=PolynomialRing(GF(ell));
        pol:=Polynomial(coeffp);
        
        ap:=Coefficient(pol,5);
        if IsIrreducible(pol) and not (ap eq 0) and not (ell eq p) then
            return true, frobs[p];
        end if;
    end for;
    return false;
end function;

TestC3:=function(C,ell,T)
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
                    return true, Factorization(pol);
                end if;
            end for;
        end if;
    end for;
    return false;
end function;

TestExceptionals := function(C,ell,T)
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
                return pol;
            end if;

        end if;

        

    end for;
    return 0;

end function;

ExceptionalLieType := function(C,T)
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

ExceptionalLieType(C,T);
