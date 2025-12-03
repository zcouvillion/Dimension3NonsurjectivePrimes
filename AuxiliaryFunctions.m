load "GenericPolynomials.m";

// index_power_polys[n] is the generic polynomial for P^(n) 

indexed_power_polys:= [];
indexed_power_polys[2]:= power_polys[1];
indexed_power_polys[3]:= power_polys[2];
indexed_power_polys[5]:= power_polys[3];
indexed_power_polys[7]:= power_polys[4];

ComputeCharPolyApprox := function(f,e,B)

    /*
        Input: f is a polynomial, e is an integer, and B is an integer (precision bound)
        Output: The polynomial f^(e) using a complex field
    */

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

Power_Poly:=function(p,e)

    /*
        Input: p is a degree 6 polynomial, e is an integer in {2,3,5,7}
        Output: the polynomial p^(e), using precomputed generic polynomials
    */

    g:=x^6;
    
    w:=Reverse(Prune(Coefficients(p)));

    /*sign discrepencies with expressing coefficients with elementary symmetric polynomials*/
    w[1]:= -w[1];
    w[3]:= -w[3];
    w[5]:= -w[5];
    
    for i in [1..6] do
        g:= g + Evaluate(Coefficients(indexed_power_polys[e])[i],w)*x^(i-1);
    end for;
    
    return g;
end function;

Iterated_Power_Poly := function(p,e,n)

    /*
        Input: p is a degree 6 polynomial, e is in {2,3,5,7}, and n is an integer
        Output: the polynomial p^(e^n)
    */

    q:=p; 
    for i in [1..n] do
        q:=Power_Poly(q,e);
    end for;
    return q;
end function;


p2520:=function(p)
    /*
        Input: p is a degree 6 polynomial
        Output: the polynomial p^(2520)
    */
    q:=p;
    q:=Iterated_Power_Poly(q,2,3);
    q:=Iterated_Power_Poly(q,3,2);
    q:=Iterated_Power_Poly(q,5,1);
    q:=Iterated_Power_Poly(q,7,1);
    return q;
end function;

TracePoly:= function(P,p)  
    /*
    Input: a polynomial P and a prime p
    Output: a polynomial with the roots consisting of all values of alpha + p/alpha, where alpha is a root of P
    Note: This code was copied from a snippet provided in Section 6.3 of [Zywina, An explicit Jacobian of dimension 3 with maximal Galois action].
*/

    K:=SplittingField(P); Pol<v>:=PolynomialRing(K);

    return &*[v-a : a in {r[1]+p/r[1]: r in Roots(Pol!P)}];
end function;

HeckeResultant := function(frobs, n: verb:=false)

/*
    Input: Frobenius polynomials and an integer n
    Output: The product of the following numbers: Norm(det(H_p - (alpha + p/alpha) ) ), where H_p is the p Hecke operator acting on the cuspidal subspace of level n, and alpha is a root of one of the irreducible factors of P_p
*/

    _<u>:=PolynomialRing(Rationals());

     M:=ModularSymbols(n,2,1);
     S:=CuspidalSubspace(M);
     
     if verb eq true then
         print "Computed cuspidal subspace";
     end if;

    gcd_list:=[];
    c:=0;

    for frob in frobs do
        p := PrimeDivisors(Coefficients(frob)[1])[1];
        
        if verb eq true then
            print "Computing Hecke operator:",p;
        end if;
        
        time H_p:=HeckeOperator(S,p);
        
        if verb eq true then
            print "Done";
        end if;
        
        num_rows := NumberOfRows(H_p);
        
        
        norm_div:=1;
    
        tr_pol:=Parent(u)! TracePoly(frob,p);
        
        if verb eq true then
            print "Plugging in matrix";
        end if;
        
        new_matrix:=Evaluate(tr_pol,H_p);
        
        if verb eq true then
            print "Computing determinant";
        end if;
        
        c:=c+1;
        gcd_list[c]:= p * Integers()! Determinant(new_matrix);
        
        if verb eq true then 
            print "Prime",p,"done";
        end if;
        
        /*
        factored_trace:=Factorization(tr_pol);
        
        for f in factored_trace do
            pol:=f[1];
            
            
            if Degree(pol) eq 1 then
                a_p:=Roots(pol)[1][1];
            else
                _<alpha>:=NumberField(pol);
                a_p := alpha;
            end if;
            
            a_p_matrix := ScalarMatrix(num_rows,a_p);
            
            if verb eq true then
                print "Computing determinant";
            end if;
            
            d:=Determinant(H_p - a_p_matrix);
            
            if verb eq true then 
                print "Computing norm";
            end if;
            
            norm_div:=norm_div*Norm(d);
            
        end for;
        
       
        
        if verb eq true then 
            print "Prime",p,"done";
        end if;
        
        c:=c+1;
        gcd_list[c]:=Integers()!(p*norm_div);
        
        */
        
    end for;
    
    return Gcd(gcd_list);

end function;
