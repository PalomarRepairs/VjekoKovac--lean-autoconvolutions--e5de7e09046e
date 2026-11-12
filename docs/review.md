# Independent AI review of Theorem 1

An AI reviewer working separately from the proof editor compared the uploaded TeX (ratio on lines 55–56, Theorem 1 on lines 92–96, proof in Section 2) with `Challenge.lean` and traced the proof in `Solution.lean`. This is a source and mathematical review. The checking transcripts record the machine-verification results.

| Reviewed input | SHA-256 |
| --- | --- |
| `autoconvolutions(1).tex` | `96319ff70039895b649471d7577abad14ba14b7f694ea85100ad181bb2a40677` |
| `Challenge.lean` | `330a0910f4593b49810d46ab9343f75b0b738695290f4256c350248b60ccc664` |
| `Solution.lean` | `e49b881d84b575b7f14703e1372e29d75e0f966c84b9380febcd5b0d689c40c8` |

## Statement

| Manuscript | Lean |
| --- | --- |
| Every real $\varepsilon>0$ admits a nonnegative integer $d$ and real coefficients $p_0,\ldots,p_d\ge 0$, at least one positive. | `sharpness` takes `(ε : ℝ) (hε : 0 < ε)`. Its witnesses are `d : ℕ` and `p : Fin (d + 1) → ℝ` with `(∀ j, 0 ≤ p j) ∧ (∃ j, 0 < p j)`. |
| $f$ has value $p_j$ on $[j,j+1)$ and is zero elsewhere on $\mathbb R$. | `step d p` sums `Set.Ico` indicators. A positive coefficient gives a positive function on a whole unit interval. |
| For $g(x)=\int_{\mathbb R}f(t)f(x-t)\,dt$, the strict conclusion is $1-\varepsilon<\lVert g\rVert_2^2/(\lVert g\rVert_1\lVert g\rVert_\infty)$. | `auto` integrates against Lebesgue `volume`. `ratio` uses `eLpNorm` at $2,1,\infty$ with the essential supremum at $\infty$. `sharpness` concludes `1 - ε < ratio (step d p)`. |

The challenge defines all three operations independently. Their declaration blocks match `Definitions.lean` exactly, and the theorem signatures in `Challenge.lean` and `Solution.lean` agree. The finite step function belongs to $L^1\cap L^2$ by `step_memLp`. For its autoconvolution, `auto_step_memLp` gives finiteness of the norms converted to real numbers. The mass identity uses mathlib’s `integral_convolution`. The denominator is positive by `auto_step_L1` (the mass is $(\sum_j p_j)^2$) and `auto_step_Linf_pos`.

## Proof

1. For a polynomial $F$ with actual degree $d$, Lean takes its full coefficient vector through degree $d$. At the knot $k+1$ the autoconvolution equals $[z^k]F^2$, with linear interpolation between knots. Thus $s+1$ successive coefficients of height $H$ contribute $sH^2$ to the squared $L^2$ norm.
2. The flat-polynomial identity `P_flat` gives $\sum_{i=0}^sP_iP_{s-i}=1+z+\cdots+z^s$, with $P_i(1)=1$. For integers $0<K<n$, $r>b\ge8n^3$, the proof takes $D=4n+1$, $U=\sum_{j=1}^r z^{D^{2j-1}}$, $V=\sum_{j=1}^b z^{D^{2j}}$, and $F=\sum_{i=0}^K U^{n-i}V^{n+i}P_i$. Lean uses mathlib’s `Nat.succ_mul_centralBinom_succ` for the central binomial coefficient recurrence and `Nat.ofDigits_inj_of_len_eq` for uniqueness of the higher digits. The digit bound separates the coefficient blocks even after adding offsets $0\le h\le s\le2K$.
3. Set $q=b/r$, $A_s=(2n-s)!(2n+s)!$, and $N_s=\binom r{2n-s}\binom b{2n+s}$. For $0\le s\le K$ the choices of distinct digits supply $N_s$ disjoint plateaus of length $s$ and height $A_s$. The counting estimate gives $N_sA_s\ge(1-1/n)(rb)^{2n}q^s$. The global height cap is $A_{2K}$ and the mass is $F(1)^2$. Combining these gives `witness_ratio_lower` in `Autoconvolutions/Main.lean` for this polynomial.

   $$
   \mathfrak R(f_F)\ \ge\ (1-1/n)\frac{A_0}{A_{2K}}
   \frac{\sum_{s=0}^K s q^s}{(\sum_{i=0}^K q^i)^2}.
   $$

4. `Solution.lean` first chooses $q=m/(m+1)>1-\varepsilon$ with $m\ge1$. The quotient of geometric sums tends to $q$ by mathlib’s `hasSum_coe_mul_geometric_of_norm_lt_one` and `hasSum_geometric_of_lt_one`, so a sufficiently large $K$ makes it strictly greater than $1-\varepsilon$. With $K$ fixed, $A_0/A_{2K}\to1$ as $n\to\infty$, allowing $n>K$ with the full lower bound still strictly greater than $1-\varepsilon$. Taking $b=8mn^3$ and $r=8(m+1)n^3$ realizes the selected $q$ exactly. The coefficient vector of $F$ is nonnegative and $F(1)>0$ supplies its required positive entry.

A second independent AI reviewer followed the README from the Challenge to the finite estimate in the proof and checked the local links. The Comparator and axiom audit each select the single declaration `Autoconvolutions.sharpness`. The compiled proof’s dependency tree contains all 139 author-named declarations in its 18 local modules, including the theorem itself.
