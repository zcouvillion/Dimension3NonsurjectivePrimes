load "GenericPolynomials.m";
_<x>:=PolynomialRing(Rationals());


/*index_power_polys[n] is the generic polynomial for P^(n)*/
indexed_power_polys:= [];
indexed_power_polys[2]:= power_polys[1];
indexed_power_polys[3]:= power_polys[2];
indexed_power_polys[5]:= power_polys[3];
indexed_power_polys[7]:= power_polys[4];

/*Given a degree 6 polynomial f, an integer e, and a precision bound B, computes f^(e)*/
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

/*Given a degree 6 polynomial p, computes p^(e) (raising the roots to e) (only works for precomputed) */
Power_Poly:=function(p,e)
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

/*
Given a degree 6 polynomial p, computes p^(e^n) (raising the roots to e^n)
*/
Iterated_Power_Poly := function(p,e,n)
    q:=p; 
    for i in [1..n] do
        q:=Power_Poly(q,e);
    end for;
    return q;
end function;

/* 
Given a degree 6 polynomial p, computes p^(2520) (raising the roots to 2520)
*/
p2520:=function(p)
    q:=p;
    q:=Iterated_Power_Poly(q,2,3);
    q:=Iterated_Power_Poly(q,3,2);
    q:=Iterated_Power_Poly(q,5,1);
    q:=Iterated_Power_Poly(q,7,1);
    return q;
end function;

/*Given a degree 6 polynomial p, computes p^(e) for any e, using the complex field and a precision bound B*/
Power_Poly_Analytic := function(p,e,B)

    C:=ComplexField(B);
    r:=Roots(p,C);
    
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

/* 
Input: Two polynomials defining a hyperelliptic curve, auxiliary primes
Returns list of frobenius polynomials for the given auxiliary primes, indexed by each prime
*/
Frob_Polys_Hyperelliptic:= function(C,T)
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
   
        _<t>:=PolynomialRing(Integers());
        frobpoly := t^6*Evaluate(Parent(t)!LPolynomial(Cp),1/t);
        frobpoly:=Parent(t)!frobpoly;

        frobpolys[p]:=frobpoly;


    end for;

    return frobpolys;
end function;

FrobPolysGeneral:= function(C,T)
    frobpolys:=[];
    _<t>:=PolynomialRing(Integers());
    for p in T do
        
        Cp := BaseChange(C, GF(p));
        pol:=Parent(t)!LPolynomial(Cp);
        frobpoly:=t^6 * Evaluate(pol,1/t);
        frobpolys[p]:=Parent(t)!frobpoly;
    end for;
    
    return frobpolys;
end function;

/*Given a hyperelliptic curve C and bound B, computes auxiliary primes that are not bad for C less than the bound*/
AuxiliaryPrimes:=function(C,B: N:=0 )

    T:=[];
    i:=1;
    
    bad:=[];
    
    if N eq 0 then
        curve:=HyperellipticCurve(C);
        bad:=BadPrimes(curve);
    else 
        bad:=PrimeDivisors(N);
    end if;
    
    
    for p in [1..B] do
        if IsPrime(p) and not (p in bad) then
            T[i]:=p;
            i:=i+1;
        end if;
    end for;

    return T;

end function;

/*
Input: Frobenius polynomials, auxiliary primes
Returns an integer whose prime factors are the possible one-dimensional cases
*/
ReducibleOneDim := function(frobpolys,T)

    eigen1list:=[]; /*list of values ell needs to divide for G_ell to have 1 as an eigenvalue*/
    j:=1;
    for p in T do
    
        eigen1list[j]:= p*Integers()! Evaluate(p2520(frobpolys[p]),1);
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
ReducibleTwoDim:= function(frobpolys,T,N)
    _<v>:=PolynomialRing(Rationals());
    gcd_product:=1;
    
    for n in Divisors(N) do
        res:=[];
        i:=1;
        M:=ModularSymbols(n,2,1);
        S:= CuspidalSubspace(M);
        N:= NewSubspace(S);
        
        for p in T do
            tracep:=TracePoly(frobpolys[p],p);
            heckep:=Parent(v)!HeckePolynomial(N,p);
            /*Check if the Hecke polynomial has a_p as a root, in which case a_p is an eigenvalue for T_p and so might come from an eigenform*/
            res[i]:= Integers()!Resultant(tracep, heckep);
            i:=i+1;
            
        end for;
        
        
        gcd_product:=Lcm(Gcd(res),gcd_product);
        if gcd_product eq 0 then
            print "Likely from a newform of level ",n,".";
            return 0;
        end if;
    end for;
    return gcd_product;
end function;

/*Input: Frobenius polynomials, auxiliary primes
Returns and integer whose prime factors are the possible three-dimensional cases
*/
ReducibleThreeDim:= function(frobpolys,T)

    res1 := []; /*quantity that must be 0 for tame inertia weight e=0 case, one for each auxiliary prime*/
    res2 := []; /*quantity that must be 0 for tame inertia weight e=1 case, one for each auxiliary prime*/
    i:=1;
    for p in T do
        _<u>:=PolynomialRing(Integers());
        poly:=p2520(frobpolys[p]);
        a5:=Integers()!Coefficients(poly)[6];
        a4:=Integers()!Coefficients(poly)[5];
        a3:=Integers()!Coefficients(poly)[4];
       
       
        q1:=p^2520*u + (-u - a5) + u*(-u - a5)-a4;
        q2:=-(p^2520*+p^(2520*2)+u^2*p^2520+(-u-a5)^2) - a3;
       
        /*Compute resultant of the polynomials above*/
        c1:=Coefficient(q1,2);
        c2:=Coefficient(q1,1);
        c3:=Coefficient(q1,0);
       
        d1:=Coefficient(q2,2);
        d2:=Coefficient(q2,1);
        d3:=Coefficient(q2,0);    
       
       
        res1[i]:=c1^2*d3^2 - c1*c2*d2*d3 - 2*c1*c3*d1*d3 + c1*c3*d2^2 + c2^2*d1*d3 - c2*c3*d1*d2 + c3^2*d1^2;
        res1[i]:=Integers()! res1[i];
        
        //res1[i]:=Integers()!Resultant(q1,q2);

        q1:=-a5*u - a5*p^2520 - u^2*p^2520 - u*p^5040 + u - a4;
        q2:=-a5^2*p^2520 - 2*a5*u * p^5040 - u^2 * p^7560 - u^2 - p^5040 - p^2520 - a3;
        
        
        /*Compute resultant of polynomials above*/
        c1:=Coefficient(q1,2);
        c2:=Coefficient(q1,1);
        c3:=Coefficient(q1,0);
       
        d1:=Coefficient(q2,2);
        d2:=Coefficient(q2,1);
        d3:=Coefficient(q2,0);    
       
        res2[i]:=c1^2*d3^2 - c1*c2*d2*d3 - 2*c1*c3*d1*d3 + c1*c3*d2^2 + c2^2*d1*d3 - c2*c3*d1*d2 + c3^2*d1^2;
        res2[i]:=Integers()! res2[i];
        
        //res2[i]:=Integers()!Resultant(q1,q2);
        
        i:=i+1;
    end for; 

    
    M1:=Gcd(res1);
    M2:=Gcd(res2);

    return M1*M2;
    

end function;

/*The following is essentially the algorithm of the many-authored genus 2 paper
for dealing with an imprimitive composition into two subspaces.
*/
ImprimitiveTwoDecomp:= function(frobpolys,T, N)

    chars:=Elements(DirichletGroup(N)); //create candidate characters that could describe the permutation action of G_Q


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
Returns integer whose prime factors of are those where the permutation 
action of G_Q on V_1 \oplus V_2 \oplus V_3 may be possible
*/
ImprimitiveThreeDecomp:=function(frobpolys,T,N);
    

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
              print "Phase 1 failed";
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
Input: Frobenius polynomials, auxiliary primes, precision bound
Returns an integer whose prime factors are the possible cases where the geometric maximal subgroup 
of class 4 may possibly happen.
*/
MaximalSubgroupC4 := function(frobs, T, B)
  
    MM:=[];
    c:=1;
    
    for p in T do
        frobpoly:=frobs[p];
       
        
        M:=1;
        R:=Roots(frobpoly,ComplexField(B));

        if Discriminant(frobpoly) ne 0 then
            for i in [1..6] do
                for j in [1..6] do
                    if j ne i then
                        for k in [j..6] do
                            if k ne i and k ne j then
                                M := M * (R[i][1]^2 - R[j][1]*R[k][1]);  
                            end if;
                        end for;
                    end if;
                end for;
            end for;
            MM[c]:=Integers()! Round(M);
            c:=c+1;
        end if;
    end for;
    if IsEmpty(MM) then
        return 0;
    end if;
    
    return Gcd(MM);
end function;

/*Tries to rule out C1 and C2 for a specific prime by finding an irreducible polynomial with trace 0*/
TestC1andC2 := function(ell, frobs,T)
   
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
            return 0, frobs[p];
        end if;
    end for;
    return 1;
end function;

/*For a specific prime, tries to rule out C3 by finding a polynomial with rational root of multiplicity 1  */
/*For a 3 + 3 (or 2+2+2 decomposition), any rational eigenvalue in one component appears in another, so multiplicity at least 2 (resp 3) */
TestC3:=function(ell,frobs,T)
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
                if  alpha[2] eq 1 then
                    return 0, Factorization(pol);
                end if;
            end for;
        end if;
    end for;
    return 1;
end function;

/*Given auxiliary primes and frobenius polynomials, computes a number whose prime divisors are those where the image 
may be exceptional
*/
ExceptionalList := function(frobs,T)
    divs:= [7,8,10,12,13, 15]; //all elements of the exceptionals have order dividing one of these numbers
    disc_list:=[];
    i:=1;
    
    for p in T do
        C:=1;
        for d in divs do
            g:=ComputeCharPolyApprox(frobs[p],d,1000);
            disc:=Discriminant(g);
            C:=C*disc;
        end for;
        disc_list[i]:=C;
        i:=i+1;
    end for;
    
    return Gcd(disc_list);

end function;

/*For a specific prime, tries to rule out exceptional by examining P_p^(d), where d is a possible order*/
TestExceptionals := function(ell,frobs,T)
    K:=GF(ell);
    for p in T do
            
            
            divs:= [7,8,10,12,13, 15];
            
            pass:=1;
            
            for d in divs do
                
                
                g:=ComputeCharPolyApprox(frobs[p], d, 1000);
                
                coeff:=Coefficients(g);
                coeffp:=[];
                for i in [1..7] do
                    coeffp[i]:=K ! Integers()!coeff[i];
                end for;
                _<b>:=PolynomialRing(K);
                pol:=Polynomial(coeffp);
                
                r:=Roots(pol, K);
                if #r eq 1 then
                    pass:=0;
                end if;
                
        
            end for;
            
            if pass eq 1 then
                return 0, pol;
                
            end if;
            
    end for;
    
    return 1;

end function;
/*Tries to rule out the exceptional Lie type (GL(2,ell)) case whereever it is possible*/
TestExceptionalLieType := function(frobs,T)
    leftover:=[2,3,5,7,11,13];
    ruledout := 2*3*5*7*11*13;
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
            if IsSeparable(pol)  then
                ord1 := ell * (ell - 1);
                ord2 := ell^2 - 1;
        
                f1:=b^ord1 - 1;
                f2:=b^ord2 - 1;

                if not (Gcd(pol, f1) eq pol) and not (Gcd(pol,f2) eq pol) then
                    ruledout:= Integers()!(ruledout/ell);
                    break;
                end if;
            end if;

        end for;
    end for;
    return ruledout;
end function;

WriteExplanation:= function(ell, exp, s)

    revised:=exp;
    if IsDefined(revised,ell) then
        revised[ell] := revised[ell] cat " | " cat s;
    else 
        revised[ell]:=s;
    end if;

return revised;

end function;

/*for semistable primes, set the exponent to 1. for nonsemistable but tame primes, set the exponent to 2*/
LowerConductor:= function(N_old, semistableprimes)

    N_new := 1;
    
    P:=PrimeDivisors(N_old);
        
    
    for p in P do
        e:=Valuation(N_old, p);
        if p in semistableprimes and p ne 2 then
            N_new := N_new * p;
        elif p gt 7 and e gt 2 then
            N_new := N_new * p^2;
        else 
            N_new := N_new * p^e;
        end if;
        
    end for;

    return N_new;

end function;

/*Tests for transvection using appendix of the C. Hall paper*/
TransvectionTest:=function(C,N)
    P:=PrimeDivisors(N);
    f:= 4*C[1] + C[2]^2;
    coeff:=Coefficients(f);

    for p in P do
        coeffp:=[];
        i:=1;
        for c in coeff do
            coeffp[i] := GF(p)! c;
            i:=i+1; 
        end for;
        f_p := Polynomial(coeffp);
        
        fact:=Factorization(f_p);
    
        double_root_count:=0;
        for factor in fact do
            if factor[2] gt 2 then
                continue;
            end if;
            if factor[2] eq 2 then
                double_root_count:= double_root_count + 1;
            end if;
        end for;
        
        if double_root_count eq 1 then
            return true, p;
        end if;
    
    end for;
    
    return false, 1;
end function;

NonsurjectivePrimes:=function(frobs,T, N: semistable_primes := [], has_transvection:=false, skip_two_dim:=false)

    sus_primes:= 1;
    explanations:=[""];

    bad_primes:=PrimeDivisors(N);
    S:=PrimeDivisors(2*3*5*7*N);

    p1:=T[1];
    p2:=T[2];

    time onedim:=ReducibleOneDim(frobs,T);
    if onedim eq 0 then
        print "One-dimensional subrep could not be ruled out for any prime.";
        return 1,1,1;
    end if;
    
    twodim:=1;
    if skip_two_dim eq false then
        N_0 := LowerConductor(N, semistable_primes);
        print "Conductor used for Serre's conjecture: ", N_0;
        time twodim:=ReducibleTwoDim(frobs,[p1,p2],N_0);
    end if;
    
    
    if twodim eq 0 and skip_two_dim eq false then
        print "Two-dimensional subrep could not be ruled out for any prime.";
        return 1,1,1;
    end if;
    
    time threedim:=ReducibleThreeDim(frobs,T);
    if threedim eq 0 then
        print "Three-dimensional subrep could not be ruled out for any prime.";
        return 1,1,1;
    end if;
    
    imprim1:=1;
    imprim2:=1;
    
    if #semistable_primes ne #bad_primes then
    
        time imprim2:=ImprimitiveTwoDecomp(frobs,T,N);
         if imprim2 eq 0 then
            print "Imprimitive 3+3 could not be ruled out for any prime.";
            return 1,1,1;
        end if;
        time imprim3:=ImprimitiveThreeDecomp(frobs,T,N);
         if imprim3 eq 0 then
            print "Imprimitive 2+2+2 could not be ruled out for any prime.";
            return 1,1,1;
        end if;
    
    end if;
    imageC4:=1;
    
    if has_transvection eq false then
        
        time imageC4:=MaximalSubgroupC4(frobs,T,1000);
        if imageC4 eq 0 then
            print "C4 image could not be ruled out for any prime.";
            return 1,1,1;
        end if;
    end if;
    
    C12:= 1;
    C3:=1;
    
    for ell in S do
        C12:=C12*ell^(TestC1andC2(ell,frobs,T));
        C3:=C3*ell^(TestC3(ell,frobs,T));
    end for;
    
    for ell in PrimeDivisors(C12) do
        sus_primes := sus_primes * ell;
        explanations:=WriteExplanation(ell,explanations, "Failed C1/C2 test");
    end for;
    for ell in PrimeDivisors(C3) do
        sus_primes := sus_primes * ell;
        explanations:=WriteExplanation(ell,explanations, "Failed C3 test");
    end for;
    
    possible_C123 := onedim*twodim*threedim*imprim2*imprim3*imageC4;
    for ell in PrimeDivisors(possible_C123) do
        if TestC1andC2(ell,frobs,T) eq 1 then
            sus_primes:=sus_primes*ell;
            if onedim mod ell eq 0 then
                  explanations:=WriteExplanation(ell,explanations, "Possible One-Dim Subquotient");
            end if;
            if twodim mod ell eq 0 then
                  explanations:=WriteExplanation(ell,explanations, "Possible Two-Dim Subquotient");
            end if;
            if threedim mod ell eq 0 then
                  explanations:=WriteExplanation(ell,explanations, "Possible Three-Dim Subquotient");
            end if;
            if imprim2 mod ell eq 0 then
                  explanations:=WriteExplanation(ell,explanations, "Possible Imprimitive 3+3");
            end if;
            if imprim3 mod ell eq 0 then
                  explanations:=WriteExplanation(ell,explanations, "Possible Imprimitive 2+2+2");
            end if;
        end if;
    end for;
    for ell in PrimeDivisors(imageC4) do
          sus_primes:=sus_primes*ell;
          explanations:=WriteExplanation(ell,explanations, "Possible C4 image");
    end for;
    
    if has_transvection eq false then
        exceptionalLie:=TestExceptionalLieType(frobs,T);
        for ell in PrimeDivisors(exceptionalLie) do
              sus_primes:=sus_primes*ell;
              explanations:=WriteExplanation(ell,explanations, "Possible Exceptional Lie Type");
        end for;
    
    
        possible_exceptionals:=PrimeDivisors(ExceptionalList(frobs,T));
        for ell in possible_exceptionals do
            if ell le 2^8*3^3*5^2*7 then
                if TestExceptionals(ell,frobs,T) eq 1 then
                    sus_primes:=sus_primes*ell;
                    explanations:=WriteExplanation(ell,explanations, "Possible Exceptional");
                end if;
            end if;
        end for;
    end if;
return 0, PrimeDivisors(sus_primes), explanations;

end function;
