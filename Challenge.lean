module

public import Mathlib.MeasureTheory.Function.LpSeminorm.Defs
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Lebesgue.Basic

@[expose] public section

open MeasureTheory
open scoped ENNReal BigOperators

namespace Autoconvolutions

/-- On the cell `[j,j+1)` use the real coefficient `p j`. Outside the
union of the cells the sum is zero. The indices range from zero through d. -/
noncomputable def step (d : ℕ) (p : Fin (d + 1) → ℝ) (x : ℝ) : ℝ :=
  ∑ j, (Set.Ico (j.val : ℝ) ((j.val : ℝ) + 1)).indicator (fun _ => p j) x

/-- The additive autoconvolution on the real line with Lebesgue measure. -/
noncomputable def auto (f : ℝ → ℝ) (x : ℝ) : ℝ :=
  ∫ t : ℝ, f t * f (x - t) ∂volume

/-- The square of the L² norm of the autoconvolution divided by the product
of its L¹ norm and its essential-supremum norm, all for Lebesgue measure. -/
noncomputable def ratio (f : ℝ → ℝ) : ℝ :=
  (eLpNorm (auto f) 2 volume).toReal ^ 2 /
    ((eLpNorm (auto f) 1 volume).toReal * (eLpNorm (auto f) ∞ volume).toReal)

/-- Theorem 1 of Crmarić, Kovač and Rupčić. For each positive real tolerance
there is a nonzero, nonnegative step function on consecutive integer unit
cells whose autoconvolution ratio is strictly greater than one minus the
tolerance. The Lᵖ spaces in the statement use Lebesgue measure on ℝ. -/
theorem sharpness (ε : ℝ) (hε : 0 < ε) :
    ∃ (d : ℕ) (p : Fin (d + 1) → ℝ),
      (∀ j, 0 ≤ p j) ∧ (∃ j, 0 < p j) ∧
      1 - ε < ratio (step d p) := by
  sorry

end Autoconvolutions
