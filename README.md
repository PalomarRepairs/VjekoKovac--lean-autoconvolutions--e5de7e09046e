# Sharpness of the Martin–O’Bryant autoconvolution inequality

This Lean 4 project formalizes **Theorem 1** of Tonći Crmarić, Vjekoslav Kovač, and Jelena Rupčić. For every real $\varepsilon>0$ there exist $d\in\mathbb N_0$ and nonnegative real heights $p_0,\ldots,p_d$, at least one positive, such that

$$
f=\sum_{j=0}^d p_j\mathbf{1}_{[j,j+1)},\qquad
\frac{\|f*f\|_2^2}{\|f*f\|_1\,\|f*f\|_\infty}>1-\varepsilon.
$$

The convolution and all three norms use Lebesgue measure on the real line. The proof follows Section 2, choosing $q$, then $K$, then $n$. [Paper](https://arxiv.org/abs/2611.12685v1) · [Statement](Challenge.lean) · [Proof](Solution.lean)

## Open and check the proof

Install the Lean 4 extension in VS Code and follow its setup guide. Open the folder containing `lakefile.toml`. In its terminal, run the following commands. [Lean installation guide](https://lean-lang.org/install/)

```sh
lake exe cache get
lake build Challenge Solution Audit
lake env lean Audit.lean
```

The first command downloads compiled mathlib dependencies. The build checks the project with the pinned Lean version. The last command prints the theorem and the axioms on which its proof depends.

Read `Challenge.lean` first. `Fin (d + 1) → ℝ` gives one real coefficient for each integer from $0$ through $d$. The `sorry` at the end marks the theorem for Comparator to check. In `Solution.lean`, the theorem `Autoconvolutions.sharpness` supplies the proof. Use **F12** on `witness_ratio_lower` to see how the coefficient estimates give the lower bound for the Lebesgue norms. [Mathematical review](docs/review.md) · [Verification records](docs/verification.md) · [GitHub and Palomar instructions](docs/palomar.md)

## Credits

**Formalization authors.** Tonći Crmarić, Vjekoslav Kovač, and Jelena Rupčić. **Credit for the Lean formalization.** GPT-6 Astra. The proof reuses the authors’ earlier Lean development and mathlib, including its central-binomial recurrence, multinomial expansion, base-digit uniqueness, geometric series, and convolution integral. [Project metadata](formalization.yaml) · [Pinned mathlib source](https://github.com/leanprover-community/mathlib4/tree/56a005855ea17e0b0958f73ec801ae140b0a1679)

The separation of the statement and proof follows the lean-dfr project. The source-layout and Comparator scripts are adapted from the Apache-2.0 Palomar template. [lean-dfr](https://github.com/roos-j/lean-dfr) · [Palomar template](https://github.com/PalomarRegistry/PalomarTemplate/tree/2891de4c48955af824969a263d31b25e7a9a1406)
