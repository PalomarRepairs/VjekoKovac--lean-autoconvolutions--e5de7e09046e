# Publish Theorem 1

1. Extract the ZIP. Open the folder containing `lakefile.toml` and run the checks in the README. Review the statement and its correspondence with the paper. [README](../README.md) · [Statement and proof review](review.md) · [Verification](verification.md)
2. Create an empty public GitHub repository. From the folder containing `lakefile.toml`, use the commands below, replacing the repository URL with your own. Copy the full SHA printed by the last command.

   ```sh
   git init -b main
   git add .
   git commit -m "Formalize Theorem 1 on autoconvolution sharpness"
   git remote add origin https://github.com/YOUR-ACCOUNT/YOUR-REPOSITORY.git
   git push -u origin main
   git rev-parse HEAD
   ```

3. In the repository’s **Actions** tab, select **Palomar mechanical preflight** and **Run workflow**. Choose your relationship to the project. Check that the run uses the SHA you copied and its mechanical report says `pass`. [Pinned verifier](https://github.com/PalomarRegistry/PalomarSubmission/tree/14aa8d6b3c2f14a8540605e37144560b9a00e7e7)
4. In the submission form, enter the public `owner/repository` and the full commit SHA. Use the repository root, `comparator.json`, and `formalization.yaml`. Leave the existing Palomar ID blank for a new entry. Complete the GitHub write-access check and save the status link. Read the registry’s review before selecting **Register**. [Submission form](https://submit.palomar-registry.org/) · [Palomar instructions](https://palomar-registry.org/how-to-submit)
