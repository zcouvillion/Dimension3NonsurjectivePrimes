load "genus 3/AuxiliaryFunctions.m"; //load functions regarding general polynomial arithmetic

_<x>:=PolynomialRing(Rationals());

ReducibleOneDim := function(frobpolys)

    /*
        Input: a list of Frobenius polynomials
        Output: an integer whose prime divisors are the possible one-dimensional cases (disregarding the primes of bad reduction)
    */

    eigen1list:=[]; // list of values ell needs to divide for G_ell to have 1 as an eigenvalue
    j:=1;
    for frob in frobpolys do
    
        p := PrimeDivisors(Coefficients(frob)[1])[1];    
        eigen1list[j]:= p*Integers()! Evaluate(p2520(frob),1);
        j:=j+1;

    end for;

    return Gcd(eigen1list);

end function;


//add a computed Hecke polynomial to a running list to save for further use
UpdateHeckeList := procedure(n,p,poly,~hecke_polys)
    hecke_polys[n,p]:=poly;
end procedure;


ReducibleTwoDim:= function(frobpolys,heckes,N:bound:=-1, flag:=-1, verb:= false)

    /*
    Input: frobpolys is a list of Frobenius polynomials, heckes is a list of precomputed Hecke polynomials indexed by level and prime, N is an integer which the conductor divides, (optional) bound is an upper-limit on the levels of newforms to examine, (optional) flag, when set to 0, tells the function to disregard precomputed Hecke polynomials, (optional) verb, when set to true, outputs more information on the screen
    Output: an integers whose prime factors are the possible two-dimensional cases (disregarding the bad primes). If this integer is 0, an error message will appear.
    */

    _<v>:=PolynomialRing(Rationals());
    gcd_product:=1;
    
    returned_heckes:=heckes; //prepare to return back the hecke polynomials that have already been computed
    
    for n in Divisors(N) do
        if verb eq true then
            print "current divisor: ",n;
        end if;
    
        if bound ne -1 and n gt bound then
            //skip this level if we set a bound limit and n exceeds the bound
            continue;
        end if;
        
        res:=[];
        i:=1;
        
        have_already:=true; //flag for whether or not we already have the Hecke polynomial for T_p acting on the new subspace of level n, for the primes p offered by the Frobenius polynomials
        
        if flag eq 0 then
            have_already:=false; //skip looking for precomputed Hecke polynomials
        end if;
        
        if flag eq -1 then
            for frob in frobpolys do
                p := PrimeDivisors(Coefficients(frob)[1])[1];
                if heckes[n][p] eq 0 then
                    have_already:=false; //no precomputed Hecke polynomial (T_p acting on level n) found, so we have to compute
                    break;
                end if;
            end for;
        end if;
        
        M:=0;
        S:=0;
        newforms:=0;
        
        if have_already eq true and verb eq true then
            print "Time save from recycling Hecke polynomials.";
        end if;
        
        if have_already eq false then
            //compute the Hecke polynomials by first calculating the new subspace using modular symbols
        
            M:=ModularSymbols(n,2,1);
            S:= CuspidalSubspace(M);
            if verb eq true then
                print "cuspforms computed, finding newforms";
            end if;
            newforms:= NewSubspace(S);
            if verb eq true then
                print "newforms computed";
            end if;
        end if;
        
        for frob in frobpolys do
            p := PrimeDivisors(Coefficients(frob)[1])[1];
            tracep:=TracePoly(frob,p); //compute a polynomial whose roots are all candidate Frobenius traces a_p on a two-dimensional subquotient
            
            
            heckep:=0;
            if flag eq 0 or heckes[n][p] eq 0 then
                heckep:=Parent(v)!HeckePolynomial(newforms,p); //compute the characteristic polynomial of T_p acting on the new subspace of level n
                if verb eq true then
                    print "hecke-poly computed";
                end if;
                if flag eq -1 then
                    returned_heckes[n][p]:=heckep; //store the Hecke polynomial for later use
                end if;
            else
                heckep:= heckes[n][p];
            end if;
            
            
            /*Check if the Hecke polynomial has a_p as a root, in which case a_p is an eigenvalue for T_p and so might come from an eigenform*/
            res[i]:= Integers()!Resultant(tracep, heckep);
            i:=i+1;
            
        end for;
        
        
        gcd_product:=Lcm(Gcd(res),gcd_product); //add all primes which may accomodate a level n newform
        if gcd_product eq 0 then
            /*unable to rule out level n newform. return failure and print an explanation*/
            print "Likely from a newform of level ",n,".";
            return 0, returned_heckes;
        end if;
    end for;
    
    if flag eq 0 then
        return gcd_product;
    end if;
    
    return gcd_product, returned_heckes;
end function;

ReducibleTwoDimGamma1:= function(frobs,N)

    /*
    Input: Frobenius polynomials and an integer divisible by the conductor
    Output: An integer divisible by all primes which could accomodate a two-dimensional subquotient whose determinant character is not the cyclotomic character (disregarding primes of bad reduction)
    */

    resultants:=[];
    
    N_2:=N;
    
    if N mod 2 eq 0 then
        N_2:=8*N; //extra precaution to handle a quadratic character wildly ramified at 2
    end if;
    /*
    If the determinant character is not the cyclotomic character, it will be off by a nontrivial quadratic character. For each frobenius polynomial P_p, construct an integer resultants[p mod N_2] divisible by all primes where the image of Frob_p under this quadratic character could be nontrivial.
        
    */
    
    
    for frob in frobs do
    
         p := PrimeDivisors(Coefficients(frob)[1])[1];
    
        if N_2 mod p eq 0 then
            continue;
        end if;
        
        ind:= p mod N_2;
        
        res:=Integers()! Resultant(frob, x^2 - p);
        //if Frob_p is nontrivial under the quadratic character, then ell must divide res
        
        if IsDefined(resultants,ind) eq false then
            resultants[ind] := p*res;
        else 
            resultants[ind] := p*Gcd(resultants[ind], res);
        end if;
    
    end for;
    
    U,phi:=MultiplicativeGroup(Integers(N_2));
    list:=[];
    c:=1;
    M:=1;
    
    //verify that we actually supplied enough primes p to generate (Z/N_2 Z)*, and then return the product of the resultants computed above.
    
    for i in [1..N_2] do
        
        if IsDefined(resultants,i) eq true then
                if resultants[i] ne 0 then
                    list[c]:=Inverse(phi)(i);
                    c:=c+1;
                    M:=M*resultants[i];
                end if;
                
                H:=sub<U|list>;
                if U eq H then
                    return M;
                end if;
                
        end if;
        
    end for;

    return 0;

end function;

ReducibleRelatedTwoDim:= function(frobs)

    /*
    Input: Frobenius polynomials
    Output: An integer divisible by all primes ell which can accomodate a pair of two-dimensional subquotients which are dual to each other (disregarding primes of bad reduction)
*/

    val_list_1:=[];
    val_list_p:=[];
    
    c:=0;
    
    res_list_1 :=[];
    res_list_2 :=[];
    
    _<c0,c1,c2,c3,d0,d1,d2,d3>:=PolynomialRing(Rationals(),8);
        
        //define a generic formula for the resultant of two cubic polynomials in terms of the coefficients
        
        res_33 := -c0^3*d3^3 + c0^2*c1*d2*d3^2 + 2*c0^2*c2*d1*d3^2 - c0^2*c2*d2^2*d3 + 3*c0^2*c3*d0*d3^2 - 3*c0^2*c3*d1*d2*d3 + c0^2*c3*d2^3 - 
    c0*c1^2*d1*d3^2 - 3*c0*c1*c2*d0*d3^2 + c0*c1*c2*d1*d2*d3 + c0*c1*c3*d0*d2*d3 + 2*c0*c1*c3*d1^2*d3 - c0*c1*c3*d1*d2^2 + 
    2*c0*c2^2*d0*d2*d3 - c0*c2^2*d1^2*d3 - c0*c2*c3*d0*d1*d3 - 2*c0*c2*c3*d0*d2^2 + c0*c2*c3*d1^2*d2 - 3*c0*c3^2*d0^2*d3 + 
    3*c0*c3^2*d0*d1*d2 - c0*c3^2*d1^3 + c1^3*d0*d3^2 - c1^2*c2*d0*d2*d3 - 2*c1^2*c3*d0*d1*d3 + c1^2*c3*d0*d2^2 + c1*c2^2*d0*d1*d3 + 
    3*c1*c2*c3*d0^2*d3 - c1*c2*c3*d0*d1*d2 - 2*c1*c3^2*d0^2*d2 + c1*c3^2*d0*d1^2 - c2^3*d0^2*d3 + c2^2*c3*d0^2*d2 - c2*c3^2*d0^2*d1 + 
    c3^3*d0^3;
    
     _<u>:=PolynomialRing(Rationals());
    
    for frob in frobs do
      
         p := PrimeDivisors(Coefficients(frob)[1])[1];
        
        
        new_pol:=p2520(frob);
        coeffs:=Coefficients(new_pol);
        a5:=coeffs[6];
        a4:=coeffs[5];
        a3:=coeffs[4];
        
        
        pol_1:= -u^2*p^5040 - u^2*p^2520 - u^2 - u*p^2520*a5 - u*a5 + p^5040 + p^2520 + 1 - a4;
        pol_2:= u^3*p^5040 + u^3*p^2520 + u^2*p^2520*a5 + u*p^7560 - u*p^5040 - u*p^2520 + u + p^5040*a5 + a5 - a3;

        c_1:=Coefficients(pol_1);
        c_2:=Coefficients(pol_2);
        
        //produce an integer catching all primes where the determinant character is unramified at ell
        res_1:=Integers()!Evaluate(res_33, [c_1[1],c_1[2],c_1[3],0, c_2[1],c_2[2],c_2[3],c_2[4] ]);
        
        
        pol_1:= -3*u^2 - 2*u*a5 + p^5040 + 2*p^2520 - a4;
        pol_2:= 2*u^3 + u^2*a5 + u*p^5040 - u*p^2520 + p^5040*a5 + p^2520*a5 - a3;
        
        
        c_1:=Coefficients(pol_1);
        c_2:=Coefficients(pol_2);
        
        //produce an integer catching all primes where the determinant character is ramified at ell
        res_2:= Integers()! Evaluate(res_33, [c_1[1],c_1[2],c_1[3],0, c_2[1],c_2[2],c_2[3],c_2[4] ]);
        
        c:=c+1;
        res_list_1[c]:=res_1;
        res_list_2[c]:=res_2;
        
     end for;
    
     return Gcd(res_list_1) * Gcd(res_list_2);
        
end function;

ReducibleThreeDim:= function(frobpolys)

    /*
    Input: Frobenius polynomial
    Output: integer whose prime factors are the possible three-dimensional cases (disregarding primes of bad reduction)
    */

    res1 := []; /*quantity that must be 0 for tame inertia weight e=0 case, one for each auxiliary prime*/
    res2 := []; /*quantity that must be 0 for tame inertia weight e=1 case, one for each auxiliary prime*/
    i:=1;
    for frob in frobpolys do
     p := PrimeDivisors(Coefficients(frob)[1])[1];
        _<u>:=PolynomialRing(Integers());
        poly:=p2520(frob);
        a5:=Integers()!Coefficients(poly)[6];
        a4:=Integers()!Coefficients(poly)[5];
        a3:=Integers()!Coefficients(poly)[4];
       
       
        q1:=p^2520*u + (-u - a5) + u*(-u - a5)-a4;
        q2:=-(p^2520+p^(2520*2)+u^2*p^2520+(-u-a5)^2) - a3;
       
        /*Compute resultant of the polynomials above*/
        c1:=Coefficient(q1,2);
        c2:=Coefficient(q1,1);
        c3:=Coefficient(q1,0);
       
        d1:=Coefficient(q2,2);
        d2:=Coefficient(q2,1);
        d3:=Coefficient(q2,0);    
       
       //seems faster to use generic functions for the resultant
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

ImprimitiveTwoDecomp:= function(frobpolys, N)

/*
    Input: Frobenius polynomials, conductor
    Output: a number divisible by all primes which could accomodate an imprimitive 3+3-decomposition (disregarding primes of bad reduction and the primes 2,3)
*/

    N_2:=N;
    
    //take the extra precaution of possible wild ramification at 2 for the permutation representation
    if N mod 2 eq 0 then
        N_2:=8*N;
    end if;

    chars:=Elements(DirichletGroup(N_2)); //create candidate characters that could describe the permutation action of G_Q


    M:=[]; /*M[j] is a quantity that must be 0 if the jth Dirichlet character in our list governs our representation*/
    j:=1;
    for char in chars do
        m:=[];

        //populate "m=[]" with all traces governed by char
        i:=1;
        for frob in frobpolys do 
            frobpoly:=frob;
             p := PrimeDivisors(Coefficients(frob)[1])[1];
            
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
            M[j]:=Gcd(m); /*all traces in m must be 0 for char to be the right character*/
            j:=j+1;
           
        end if;
    end for;

    imprim:=1;
    for n in M do
        imprim:=imprim*n;
    end for;    
    return imprim;
end function; 

ImprimitiveThreeDecomp:=function(frobpolys,N);

    /*
        Input: Frobenius polynomials, integer divisible by conductor
        Output: integer whose prime factors of are those where the mod ell image stablizes a 2+2+2-decomposition imprimitively (disregarding primes of bad reduction and 2,3,5,7)
*/

    N_2:=N;
    N_3:=N;
    
    //take the extra precaution of possible wild ramification at 2 and 3 for permutation representations
    
    if N mod 3 eq 0 then
        N_3:=9*N;
    end if;
    
    if N mod 2 eq 0 then
        N_2:=8*N;
    end if;

    /*Phase 1: rule out the primes where the permutation action is not contained in A_3 */
    
    chars:=Elements(DirichletGroup(N_2));

    M:=[];
    j:=1;
    for char in chars do
        m:=[];
        i:=1;
        for frob in frobpolys do
            frobpoly:=frob;
             p := PrimeDivisors(Coefficients(frob)[1])[1];
               
            _<c>:=PolynomialRing(Rationals());
            a5:=Coefficients(frobpoly)[6];    
            a4:=Coefficients(frobpoly)[5];
            a3:=Coefficients(frobpoly)[4];
            a2:=Coefficients(frobpoly)[3];
            a1:=Coefficients(frobpoly)[2];
               
            q1:=c^3 + (a3*a5-a5^2*a4-a2)*c^2 + (a4*p^3 - a5^2*p^3)*c - p^6;
            q2:=a5*c^3 - a1*c^2 + (a3*a5*p^3 - a4*a5*p^3)*c + p^6*a5;
            
            //construct an integer whose prime divisors are those which could accomodate not being contained in A_3
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
            return 0, char;
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
    action is nontrivial. To do this, go through all order 3 level N_3 Dirichlet characters and rule them out one by one.*/

    _<z>:=PolynomialRing(Rationals());
    K<zeta>:=NumberField(z^2 + z + 1);
    chars:=Elements(DirichletGroup(N_3,K,zeta,3)); //create possible cyclic order 3 characters describing the permutation action on three composition factors

    M:=[];

    for char in chars do
     
        m:=[];
        
        i:=1;
        for frob in frobpolys do
            frobpoly:=frob;
             p := PrimeDivisors(Coefficients(frob)[1])[1];
            
            a_p:=Coefficients(frobpoly)[6];
            
            if a_p ne 0 and char(p) ne 1 then
                //trace of Frobenius is nonzero, and so imposes a nontrivial congruence condition
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

MaximalSubgroupC4 := function(frobs, B)

/*
Input: Frobenius polynomials, precision bound
Output: an integer whose prime factors are the possible cases where a low-rank maximal subgroup may occur, uses the complex field to write down high-degree relations between the roots
*/
  
    MM:=[];
    c:=1;
    
    for frob in frobs do
        frobpoly:=frob;
       
        
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

TestC1andC2 := function(ell, frobs)
/*
    Input: prime ell, Frobenius polynomials
    Output: either 0 and a Frobenius polynomial which is irreducible mod ell with nonzero trace mod ell, or 1 and a  list [a1,a2,a3], where a_i = 0 if an i-dimensional subquotient can be ruled out for ell
*/
   
   one_dim := 0;
   two_dim := 0;
   three_dim := 0;
   
    for frob in frobs do
       p := PrimeDivisors(Coefficients(frob)[1])[1];
       if p eq ell then
           continue;
       end if;
        coeff:=Coefficients(frob);
        coeffp:=[];
        for i in [1..7] do
            coeffp[i]:=GF(ell) ! Integers()!coeff[i];
        end for;
        _<b>:=PolynomialRing(GF(ell));
        pol:=Polynomial(coeffp);
        
        ap:=Coefficient(pol,5);
        if IsIrreducible(pol) and not (ap eq 0) and not (ell eq p) then
            return 0, frob;
        end if;
        
        fact_pol := Factorization(pol);
        
        count_1 :=0;
        count_2 :=0;
       
        for fact in fact_pol do
                if Degree(fact[1]) eq 1 then
                    count_1 := count_1 + fact[2];
                end if;
                if Degree(fact[1]) eq 2 then
                    count_2 := count_2 + fact[2];
                end if;
                if Degree(fact[1]) gt 3 then
                    //an irreducible factors of degree greater than 3, so we can rule out a three-dimensional subquotient
                    three_dim := 1;
                end if;
        end for;
        
        if count_1 eq 0 then
            //no linear factors, so we can rule out a one-dimensional subquotient
            one_dim := 1;
        end if;
        if count_2 eq 0 and count_1 lt 2 then
            //no two-dimensional factors, and less than 2 linear factors, so we can rule out a two-dimensional subquotient
            two_dim := 1;
        end if;
        
        
    end for;
    return 1, [one_dim,two_dim,three_dim];
end function;

TestC3:=function(ell,frobs)
/*
    Input: prime ell and Frobenius polynomials
    Output: either 0 and a Frobenius polynomial which has nonzero trace mod ell and a F_ell rational root of multiplicity 1 (intended to rule out geometrically imprimitive but imprimitive over F_ell), or returns 1 if such a polynomial is not found
*/

    for frob in frobs do
       p := PrimeDivisors(Coefficients(frob)[1])[1];
       if p eq ell then
           continue;
       end if;
        coeff:=Coefficients(frob);
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

ExceptionalList := function(frobs)

/*
    Input: Frobenius polynomials
    Output: a number divisible by primes ell where the mod ell image may be contained in an exceptional subgroup
*/

    divs:= [20,26,28,32,48]; //all elements of the exceptionals have order dividing one of these numbers when viewed in PGSp(6,ell)
    
    disc_list:=[];
    i:=1;
    
    for frob in frobs do
        C:=1;
        for d in divs do
            g:=ComputeCharPolyApprox(frob,d,1000);
            disc:=Discriminant(g);
            C:=C*disc;
        end for;
        disc_list[i]:=C;
        i:=i+1;
    end for;
    
    return Gcd(disc_list);

end function;

TestExceptionals := function(ell,frobs)
    /*
        Input: prime ell, Frobenius polynomials
        Output: either 0 and a Frobenius polynomial whose associated element in PGSp(ell,6) has order contradicting being contained in an exceptional subgroup, or 1 if such a polynomial cannot be found
    */
    
    K:=GF(ell);
    for frob in frobs do
            
            
            divs:= [20,26,28,32,48];
            
            pass:=1;
            
            for d in divs do
                
                
                g:=ComputeCharPolyApprox(frob, d, 1000);
                
                coeff:=Coefficients(g);
                coeffp:=[];
                for i in [1..7] do
                    coeffp[i]:=K ! Integers()!coeff[i];
                end for;
                _<b>:=PolynomialRing(K);
                pol:=Polynomial(coeffp);
                
                r:=Roots(pol, K);
                if #r eq 1 and #Factorization(pol) eq 1 then
                    pass:=0;
                end if;
                
        
            end for;
            
            if pass eq 1 then
                return 0, pol;
                
            end if;
            
    end for;
    
    return 1;

end function;

TestExceptionalLieType := function(frobs)
/* 
    Input: Frobenius polynomials
    Output: an integer supported on the primes in {2,3,5,7,11,13} where the Galois image may be contained in a low-rank Lie type exceptional subgroup
*/
    leftover:=[2,3,5,7,11,13];
    ruledout := 2*3*5*7*11*13;
    j:=1;

    for ell in leftover do
        
        for frob in frobs do
            
            coeff:=Coefficients(frob);
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

/*
    Input: prime ell, a data string, data string to be added
    Output: an updated data log for a prime explaining possible explanations for nonsurjectivity
*/

    revised:=exp;
    if IsDefined(revised,ell) then
        revised[ell] := revised[ell] cat " | " cat s;
    else 
        revised[ell]:=s;
    end if;

    return revised;

end function;

LowerConductor:= function(N_old, semistableprimes: extra:=1, is_hyperelliptic:=false)

/*
    Input: Conductor, a list of primes where the abelian variety is known to be semistable, (optional) a factor the user would like to remove from the conductor should the user have additional information going in, (optional) a flag informing whether or not the abelian variety is the Jacobian of a hyperelliptic curve
    Output: An integer dividing N_old, intended to be the upper-limit of levels appearing in the Serre's conjecture step
*/

    N_new := 1;
    
    P:=PrimeDivisors(N_old);
        
    
    for p in P do
        e:=Valuation(N_old, p);
        if p in semistableprimes and p ne 2 then
            N_new := N_new * p;
        elif p gt 7 and e gt 2 and is_hyperelliptic eq true then
            N_new := N_new * p^2; //hyperelliptic curves are tamely ramified at primes greater than 7
        else 
            N_new := N_new * p^e;
        end if;
        
    end for;

    return Integers()!(N_new/extra);

end function;



SanityCheck := function(ell, frobs)

/*
    Input: prime ell, frobenius polynomials
    Output: a list [a_1,a_2,a_3] so that, if a_i = 0, then the Aschbacher class C_i has been ruled out for the mod ell representation
*/

     C1_pass:=-1; //flag for confirming reducibility
     C2_pass:=-1; //flag for confirming primitivity
     C3_pass:=-1; //flag for confirming geometric imprimitivity if the preceding two flags are activated
     
     for poly in frobs do
        p := PrimeDivisors(Coefficients(poly)[1])[1];
        if p eq ell then
            continue;
        end if;
        
        coeff:=Coefficients(poly);
        coeffp:=[];
        for i in [1..7] do
            coeffp[i]:=GF(ell) ! Integers()!coeff[i];
        end for;
        _<b>:=PolynomialRing(GF(ell));
        pol:=Polynomial(coeffp);
       
        ap:=Coefficient(pol,5);
       
        if IsIrreducible(pol) then
            C1_pass := 0;
            if ap ne 0 then
                C2_pass := 0;
            end if;
        end if;
       
       
        if not (ap eq 0)  then
            roots:=Roots(pol, GF(ell));
            for alpha in roots do
                if  alpha[2] eq 1 then
                    C3_pass := 0;
                end if;
            end for;
        end if;
        
        if C1_pass eq 0 and C2_pass eq 0 and C3_pass eq 0 then
            return 0,0,0;
        end if;
        
    end for;
    
    return C1_pass, C2_pass, C3_pass;
    
end function;

RuleOutMod2 := function(frobs)
    G := [];
    G[1] := [65,73,85,107,127];
    G[2] := [65,85,93,99,107,119];
    G[3] := [65,85,107,119];
    G[4] := [65,85,127];
    G[5] := [65,85,107,127];
    G[6] := [65,85,99,119];
    G[7] := [65,85,93,99,119,127];
    G[8] := [65,73,85,99,107,119];
    
    ruled_out := [-1,-1,-1,-1,-1,-1,-1,-1];
    R:=PolynomialRing(GF(2));
    frobs_2:=[R!pol: pol in frobs];
    
    for pol in frobs_2 do
    
        coeffs:=Coefficients(pol);                 
        val:=0;                                    
        for i in [1..#coeffs] do      
            a:=0;
            if coeffs[i] eq 1 then
                a:=1;
            end if;
            val := val + a * 2^(i-1);
        end for; 
        
        for i in [1..8] do
            if val notin G[i] then
                ruled_out[i] := 0;
            end if;
        end for;
        
        if ruled_out eq [0,0,0,0,0,0,0,0] then
            return 0;
        end if;
    
    end for;
    
    return -1;
    
end function;

RuleOutMod3 := function(frobs)
    G := [];
    G[1] := [757,784,847,874,910,976,1030,1066,1120,1183,1222,1249,1312,1339,1456];
    G[2] := [730,757,784,820,910,1030,1066,1120,1183,1249,1312,1339,1456];
    G[3] := [757,784,937,964,1030,1066,1156,1183,1249,1312,1402,1456];
    G[4] := [730,757,784,820,847,874,910,976,1030,1066,1120,1183,1210,1222,1249,1312,1339,1429,1456];
    G[5] := [730,757,784,820,910,1030,1066,1120,1183,1249,1312,1339,1456];
    G[6] := [730,757,784,820,910,937,964,1030,1066,1156,1183,1249,1312,1402,1456];
    G[7] := [730,757,784,937,964,1003,1093,1156,1276,1366,1402];
    G[8] := [730,757,784,820,910,1003,1030,1066,1093,1120,1183,1249,1276,1312,1339,1366,1456];
    G[9] := [730,757,784,976,1222];
    G[10] := [730,757,784,937,964,1093,1156,1366,1402];
    G[11] := [730,757,784,937,964,1093,1156,1366,1402];
    
    ruled_out := [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
    R:=PolynomialRing(GF(3));
    frobs_3:=[R!pol: pol in frobs];
    
    for pol in frobs_3 do
    
        coeffs:=Coefficients(pol);                 
        val:=0;                                    
        for i in [1..#coeffs] do      
            a:=0;
            if coeffs[i] eq 1 then
                a:=1;
            end if;
            if coeffs[i] eq 2 then
                a:=2;
            end if;
            val := val + a * 3^(i-1);
        end for; 
        
        for i in [1..11] do
            if val notin G[i] then
                ruled_out[i] := 0;
            end if;
        end for;
        
        if ruled_out eq [0,0,0,0,0,0,0,0,0,0,0] then
            return 0;
        end if;
    
    end for;
    
    return -1;
end function;


NonsurjectivePrimes:=function(frobs, N: hecke_polys:=[* *] , hecke_flag := false , semistable_primes := [], transvection_support := 0, skip_two_four:=false, serre_bound:=-1, hyperelliptic_jacobian := false, use_hecke_poly := true, serres_conjecture_frobs:=3, skip_two_dim:=false)

/*
Input: frobs is a list of Frobenius polynomials associated to a dimension 3 principally polarized abelian variety, N is an integer divisible by the conductor, (optional) hecke_polys is a list of precomputed Hecke polynomials indexed by prime and level, (optional) hecke_flag if set to true signals to the function that precomputed Hecke polynomials will be used, (optional) semistable_primes is a collection of bad primes which are known to be semistable, (optional) transvection_support is a number whose prime divisors contain all where the mod ell image may fail to contain a transvection, (optional) skip_two_four flag to skip checking for 2+4-decomposition, (optional) serre_bound to bound the levels of modular forms examined, (optional) set hyperelliptic_jacobian to true if it is known the abelian variety is the Jacobian of a hyperelliptic curve for some optimizations on the conductor for the Serre's conjecture step, (optional) setting use_hecke_poly to false uses an alternate algorithm for the two-dimensional case which uses the Hecke operator matrix without computing its characteristic polynomial, (optional) serres_conjecture_frobs is the number of Frobenius polynomials to use in the Serre's conjecture step, (optional) set skip_two_dim:=true to disregard the two-dimensional case

Output: If successful, returns [0, S, E, H], where the first entry 0 is a success flag, S is a finite set of primes containing all primes where the mod ell image is surjective *(see Warning below), E is a list such that, if ell is in S, then E[ell] is a possible explanation for nonsurjectivity, H is a list of Hecke polynomials which were computed throughout the process, where H[n,p] is the characteristic polynomial of T_p acting on the new subspace of level n cusp forms.

Warning: If skip_two_four is set to true, then primes where there is a pair of self-dual irreducible subrepresentations of dimensions 2 and 4 is not ruled out. If serre_bound is set to some positive number, then irreducible two-dimensional subquotients coming from newforms of level greater than serre_bound are not ruled out. 

Practicality: If the conductor of the abelian variety is high, it may not be computationally feasible to run this algorithm without setting skip_two_four to true (see Warning above if using this setting).
*/
    
    //unless otherwise indicated, consider newforms of level up to N
    if serre_bound eq -1 then
        serre_bound := N;
    end if;

    //if no precomputed Hecke polynomials provided, start a new list
    if hecke_flag eq false then

        hecke_polys:=[* *];
        for i in [1..serre_bound] do
            hecke_polys[i]:=[* *];
            for j in [1..100] do
                hecke_polys[i][j]:=0;
            end for;
        end for;
    end if;

    sus_primes:= 2; //2 is always added as a possible nonsurjective prime.
    explanations:=[""];
    
    explanations:=WriteExplanation(2,explanations, "Ruling out 2 not supported yet");

    bad_primes:=PrimeDivisors(N);
    
    S_prod:=3*5*7*N;
    
    //Initialize a set of primes to be checked separately; this always includes the bad primes.
    S:=PrimeDivisors(S_prod);

    onedim:=ReducibleOneDim(frobs); //integer supported at primes which may have one-dimensional subquotient
    if onedim eq 0 then
        print "One-dimensional subrep could not be ruled out for any prime.";
        return 1,1,1, hecke_polys;
    end if;
    
    twodim:=1; //integer supported at primes which may have two-dimensional subquotient
    
    if skip_two_dim eq false then
    
        N_0 := LowerConductor(N, semistable_primes: is_hyperelliptic:= hyperelliptic_jacobian); //use the semistable primes to lower hypothetical Artin conductors of two-dimensional subquotients

        serre_conj_pols := [frobs[i]: i in [1..serres_conjecture_frobs]];

        if skip_two_four eq false then
            // run the full test for two-dimensional subquotients
            if use_hecke_poly eq true then
              twodim, hecke_polys:=ReducibleTwoDim(serre_conj_pols,hecke_polys,N_0:bound:=serre_bound);
            else  

              for n_0 in Divisors(N_0) do 
                  if n_0 gt serre_bound or n_0 eq 1 then
                      continue;
                  end if;

                  skip_flag:=false;

                  for n_1 in Divisors(N_0) do
                      if n_1 ne n_0 and n_1 le serre_bound and n_1 mod n_0 eq 0 then
                          skip_flag := true;
                          break;
                      end if;
                  end for;

                  if skip_flag eq true then
                      continue;
                  end if;

                  twodim := twodim* HeckeResultant(serre_conj_pols,n_0);
              end for;

           end if;
        else
            // only look for conductors up to level N^(1/3)
             if use_hecke_poly eq true then
              twodim, hecke_polys:=ReducibleTwoDim(serre_conj_pols,hecke_polys,N_0:bound:=N^(1/3)); 
             else
                  for n_0 in Divisors(N_0) do 
                  //print n_0, serre_bound, N^(1/3);
                  if n_0 gt Min(serre_bound, N^(1/3)) or n_0 eq 1 then
                      continue;
                  end if;

                  skip_flag := false;

                  for n_1 in Divisors(N_0) do
                      if n_1 ne n_0 and n_1 le Min(serre_bound,N^(1/3) ) and n_1 mod n_0 eq 0 then
                          skip_flag := true;
                          break;
                      end if;
                  end for;

                  if skip_flag eq true then

                      continue;
                  end if;

                  twodim := twodim* HeckeResultant(serre_conj_pols,n_0);
              end for;
             end if;

             twodim := twodim * ReducibleRelatedTwoDim(frobs);
        end if;

        twodim := twodim * ReducibleTwoDimGamma1(frobs,N); //add primes where a two-dimensional subquotient may have non-cyclotomic determinant character
        
    end if;

        if twodim eq 0 then
            print "Two-dimensional subrep could not be ruled out for any prime.";
            return 1,1,1, hecke_polys;
        end if;

          threedim:=ReducibleThreeDim(frobs); //integer supported at primes which may have three-dimensional subquotient
        if threedim eq 0 then
            print "Three-dimensional subrep could not be ruled out for any prime.";
            return 1,1,1, hecke_polys;
        end if;
    
    
    
    imprim2:=ImprimitiveTwoDecomp(frobs,N); //integer supported at primes where there may be an imprimitive 3+3 decomposition
    if imprim2 eq 0 then
        print "Imprimitive 3+3 could not be ruled out for any prime.";
        return 1,1,1, hecke_polys;
    end if;
        
    imprim3:=ImprimitiveThreeDecomp(frobs,N); //integer supported at primes where there may be an imprimitive 2+2+2 decomposition
        
    if imprim3 eq 0 then
         print "Imprimitive 2+2+2 could not be ruled out for any prime.";
         return 1,1,1, hecke_polys;
    end if;
     
    imageC4:=MaximalSubgroupC4(frobs,1000); //integer supported at primes where the image may be contained in a low-rank geometric group
    if imageC4 eq 0 then
        print "C4 image could not be ruled out for any prime.";
        return 1,1,1, hecke_polys;
    end if;
    
    
    possible_geom := onedim*twodim*threedim*imprim2*imprim3*imageC4*S_prod; //integer supported at all primes where the mod ell image may be contained in a geometric maximal subgroup
    
    /*
        For the finitely many primes filtered out so far which may fail to be surjective due to containment in a geometric maximal subgroup, run through them one-by-one to try and prove surjectivity. If these tests fail, record an explanation.
    */
    
    for ell in PrimeDivisors(possible_geom) do
           if ell eq 2 then
               continue;
           end if;
           
           C12_flag, extra_data := TestC1andC2(ell,frobs);
           C3_flag := TestC3(ell,frobs);
        if C12_flag eq 1 then
            sus_primes:=sus_primes*ell;
            explained := false;
            if extra_data[1] eq 0 then
                  explanations:=WriteExplanation(ell,explanations, "Possible One-Dim Subquotient");
                  explained:=true;
            end if;
            if extra_data[2] eq 0  then
                  if extra_data[1] eq 0 then
                      continue;
                  end if;
            
                  explanations:=WriteExplanation(ell,explanations, "Possible Two-Dim Subquotient");
                   explained:=true;
            end if;
            if extra_data[3] eq 0  then
                  explanations:=WriteExplanation(ell,explanations, "Possible Three-Dim Subquotient");
                   explained:=true;
            end if;
            if imprim2 mod ell eq 0 then
                  explanations:=WriteExplanation(ell,explanations, "Possible Imprimitive 3+3");
                   explained:=true;
            end if;
            if imprim3 mod ell eq 0 then
                  explanations:=WriteExplanation(ell,explanations, "Possible Imprimitive 2+2+2");
                   explained:=true;
            end if;
            
            if explained eq false then
                explanations:=WriteExplanation(ell,explanations, "Possible Imprimitive");
            end if;
            
        end if;
        
        if C12_flag ne 1 and C3_flag eq 1 then
            explanations:=WriteExplanation(ell,explanations, "Possible geometrically imprimitive");
        end if;
        
    end for;
    for ell in PrimeDivisors(imageC4) do
          if ell eq 2 then
              continue;
          end if;
          sus_primes:=sus_primes*ell;
          explanations:=WriteExplanation(ell,explanations, "Low-rank geometric");
    end for;
    
  
        exceptionalLie:=TestExceptionalLieType(frobs);
        for ell in PrimeDivisors(exceptionalLie) do
              if ell eq 2 then
                  continue;
              end if;
              if transvection_support mod ell ne 0 then
                  continue;
              end if;
              sus_primes:=sus_primes*ell;
              explanations:=WriteExplanation(ell,explanations, "Possible exceptional Lie Type");
        end for;
    
    /*
        If we are provided data about transvection, only check for exceptional subgroups at primes without a transvection.
    */
        
    if transvection_support eq 0 then
    
        exceptional_product := ExceptionalList(frobs); //an integer supported at primes which may have image contained in an exceptional
        if exceptional_product eq 0 then
            print "Error with exceptional groups";
            return 1,1,1,hecke_polys;
        end if;
        possible_exceptionals:=PrimeDivisors(exceptional_product);
        
        /*for the finitely many primes filtered out above, test each for containment in an exceptional subgroup*/
        
        for ell in possible_exceptionals do
            if ell eq 2 then
                continue;
            end if;
            if ell le 2^8*3^3*5^2*7 then //skip primes which are already too large to accomodate exceptionals
                if TestExceptionals(ell,frobs) eq 1 then
                    sus_primes:=sus_primes*ell;
                    explanations:=WriteExplanation(ell,explanations, "Possible Exceptional");
                end if;
            end if;
        end for;
    else
        for ell in PrimeDivisors(transvection_support) do
             if ell le 2^8*3^3*5^2*7 then
                if TestExceptionals(ell,frobs) eq 1 then
                    sus_primes:=sus_primes*ell;
                    explanations:=WriteExplanation(ell,explanations, "Possible Exceptional");
                end if;
             end if;
        end for;
    end if;
    
    //Finally, check ell = 2 and ell = 3 separately
    
    e_2:=Valuation(sus_primes,2);
    e_3:=Valuation(sus_primes,3);
    
    if RuleOutMod2(frobs) eq 0 then
        sus_primes:= Integers()!(sus_primes / (2^e_2));
        explanations[2]:="";
    else
        sus_primes:=sus_primes*2;
        explanations[2] := "Characteristic polynomials consistent with being contained in a maximal subgroup of GSp(6,2)";
    end if;
    
    if RuleOutMod3(frobs) eq 0 then
        sus_primes:= Integers()!(sus_primes / (3^e_3));
        explanations[3]:="";
    else
        sus_primes:=sus_primes*3;
        explanations[3] := "Characteristic polynomials consistent with being contained in a maximal subgroup of GSp(6,3)";
    end if;
    
return 0, PrimeDivisors(sus_primes), explanations, hecke_polys;

end function;
