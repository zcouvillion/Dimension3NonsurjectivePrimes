This is an implementation of the algorithm in [].

The file ```Dimension3Nonsurjective.m``` defines the function ```NonsurjectivePrimes```, which takes as input a collection of Frobenius polynomials and integer divisible by the conductor of a dimension 3 principally polarized abelian variety and outputs a finite list of primes ell containing all such that the mod ell representation is not surjective. See ```Examples.m``` for example uses.

<ins>Instructions:</ins>

**Input**: Run ```NonsurjectivePrimes(frobs, N) ``` where ```frobs``` is a list of Frobenius polynomials and ```N``` is an integer divisible by the conductor of the abelian variety

**Note**: We recommend running ```NonsurjectivePrimes(frobs,N: skip_two_four := true) ``` if N > 100 000 (see Warning below if using this setting).

**Output**: 
* If successful, returns [0, S, E, H], where the first entry 0 is a success flag, S is a finite set of primes containing all primes where the mod ell image is surjective **(see Warning below)**, E is a list such that, if ell is in S, then E[ell] is list of all possible explanations for nonsurjectivity for the mod ell representation, H is a list of Hecke polynomials which were computed throughout the process, where H[n,p] is the characteristic polynomial of T_p acting on the new subspace of level n cusp forms (this list is useful if one wants to recycle Hecke polynomials for repeated applications).
* If unsuccessful, returns [1,1,1,H].



There are also optional parameters:

1. hecke_polys[][] is a list of precomputed Hecke polynomials indexed by prime and level, which can be useful if recycling Hecke polynomials for computations involving many abelian varieties

2. hecke_flag:=true signals to the function that precomputed Hecke polynomials will be used

3. semistable_primes:=[] is a collection of bad primes which are known to be semistable

4. transvection_support is a number whose prime divisors contain all where the mod ell image may fail to contain a transvection

5. skip_two_four:=true to skip checking for 2+4-decomposition

6. serre_bound is an integer to bound the levels of modular forms examined
   
7. hyperelliptic_jacobian := true if it is known the abelian variety is the Jacobian of a hyperelliptic curve for some optimizations on the conductor for the Serre's conjecture step

8. use_hecke_poly:=false signals to use an alternate algorithm for the two-dimensional case which uses the Hecke operator matrix without computing its characteristic polynomial

9. serres_conjecture_frobs is the number of Frobenius polynomials to use in the Serre's conjecture step

10. skip_two_dim:=true to disregard the two-dimensional case altogether

11. serre_conductor is an integer to override the conductor used for the Serre's conjecture step; this parameter is useful when doing optimizations related to cluster pictures of hyperelliptic curves

**Warning: If skip_two_four is set to true, then primes where there is a pair of self-dual irreducible subrepresentations of dimensions 2 and 4 is not ruled out. If serre_bound is set to some positive number, then irreducible two-dimensional subquotients coming from newforms of level greater than serre_bound are not ruled out.**


