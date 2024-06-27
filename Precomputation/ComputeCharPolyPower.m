_<a1,a2,a3,a4,a5,a6>:=PolynomialRing(Rationals(),6);
_<e_1,e_2,e_3,e_4,e_5,e_6>:=PolynomialRing(Rationals(),6);
_<t>:=PolynomialRing(Parent(a1));
_<x>:=PolynomialRing(Parent(e_1));

ComputeCharPoly:=function(e)
f:=(t-a1^e)*(t-a2^e)*(t-a3^e)*(t-a4^e)*(t-a5^e)*(t-a6^e);

g:=x^6;

for i in [1..6] do
b,p:= IsSymmetric(Coefficients(f)[i],Parent(e_1));
g:= g + p*x^(i-1);
end for;
return g;
end function;

polys := [];
polys[1]:=ComputeCharPoly(2);
polys[2]:=ComputeCharPoly(3);
polys[3]:=ComputeCharPoly(5);
polys[4]:=ComputeCharPoly(7);

polys;
