# Verification of Theorem 1

The target is `Autoconvolutions.sharpness`. The independently reviewed `Challenge.lean` defines the step function, autoconvolution, and ratio. Its single `sorry` marks the statement for comparison. `Solution.lean` imports the proof modules separately.

## Run the checks

Run these commands from the folder containing `lakefile.toml`. The Comparator command needs Linux with Bubblewrap. The GitHub workflow supplies a Linux runner.

```sh
lake exe cache get
lake build Challenge Solution Audit
python3 scripts/check-axioms.py
bash scripts/verify-comparator.sh
```

## Local records

- **Clean build.** Lean 4.35.0 and Lake 5.0.0-src+eb6cafb built every project proof module from source, using cached dependencies at the pinned revisions. The mathlib commit is `56a005855ea17e0b0958f73ec801ae140b0a1679`. The input manifest records SHA-256 hashes of all 21 Lean files, the toolchain pin, the Lake configuration and lockfile, and the Comparator configuration. [Build output](../checks/build.txt) · [Input hashes](../checks/proof-inputs.sha256)
- **Axiom audit.** Lean printed `'Autoconvolutions.sharpness' depends on axioms: [propext, Classical.choice, Quot.sound]`. The inequalities in the proof, including the alphabet-size condition $8n^3\le b<r$, are proved symbolically. Tactics such as `positivity` and `omega` produce proof terms checked by Lean’s kernel. [Audit command and output](../checks/axioms.txt)
- **Lean Comparator.** In an isolated Linux guest with Bubblewrap 0.12.0, Comparator rebuilt the Challenge and Solution from the same hashed sources. Lean’s default kernel, NanoDa, and con-ron accepted the solution. Comparator reported `Your solution is okay!` and exited with status 0. [Command, configuration, and console output](../checks/comparator.txt)
- **Metadata.** The v0.4 schema and the pinned Palomar intake parsers accepted the metadata and single-target configuration. [Validation command and output](../checks/metadata.txt)

The mathematical and readability reviews recorded here were performed by AI reviewers. Human sign-off, a GitHub-hosted run, and Palomar registration remain pending. [Mathematical review](review.md) · [Publication instructions](palomar.md)
