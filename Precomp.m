_<a1,a2,a3,a4,a5,a6>:=PolynomialRing(Rationals(),6);
_<e_1,e_2,e_3,e_4,e_5,e_6>:=PolynomialRing(Rationals(),6);
_<t>:=PolynomialRing(Parent(a1));
_<x>:=PolynomialRing(Parent(e_1));

/* 
Compute C4 test polynomial
*/

/*
R:=[e_1,e_2,e_3,e_4,e_5,e_6];
M:=1;

for i in [1..6] do
    for j in [1..6] do
        if i ne j then
            for k in [j..6] do
                if k ne i and k ne j then
                    M:= M* (R[i]^2 - R[j]*R[k]);
                end if;
            end for;
        end if;
    end for;
end for;

*/


ComputeCharPoly:=function(e)
  f:=(t-a1^e)*(t-a2^e)*(t-a3^e)*(t-a4^e)*(t-a5^e)*(t-a6^e);

  g:=x^6;
  
  for i in [1..6] do
    time b,p:= IsSymmetric(Coefficients(f)[i],Parent(e_1));
    g:= g + p*x^(i-1);
  end for;
  return g;
end function;

ComputeCharPolyApprox := function(f,e,B)

    C:=ComplexField(B);
    r:=Roots(f,C);
    
    _<x>:=PolynomialRing(C);
    h:=1;
    
    for root in r do
        h:=h*(x - root[1]^e)^(root[2]);
    end for;
    
    c:=Coefficients(h);
    g:=0;
    _<y>:=PolynomialRing(Integers());
    
    for i in [1..#c] do
            coeff:=Integers()!Round(c[i]);
            g:=g + coeff *y^(i-1); 
    end for;

    return g;

end function;

