"""Run Audit.lean and enforce the published axiom policy on every reported result."""

import json
from pathlib import Path
import re
import subprocess
import sys


def main():
    root = Path(__file__).resolve().parents[1]
    config = json.loads((root / "comparator.json").read_text(encoding="utf-8"))
    allowed = set(config["permitted_axioms"])
    if not allowed <= {"propext", "Classical.choice", "Quot.sound"}:
        raise SystemExit("Comparator config exceeds the project's axiom policy")

    audit = (root / "Audit.lean").read_text(encoding="utf-8")
    expected = set(re.findall(r"^#print axioms (\S+)\s*$", audit, re.MULTILINE))
    if not expected or not set(config["theorem_names"]) <= expected:
        raise SystemExit("Audit.lean must report every Comparator target")

    command = ["lake", "env", "lean", "Audit.lean"]
    print("$ " + " ".join(command), flush=True)
    run = subprocess.run(command, cwd=root, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                         encoding="utf-8")
    sys.stdout.write(run.stdout)
    run.check_returncode()
    reports = {}
    for line in run.stdout.splitlines():
        result = re.fullmatch(r"'([^']+)' depends on axioms: \[([^\]]*)\]", line)
        if result:
            reports[result[1]] = set(result[2].split(", ")) if result[2] else set()
        independent = re.fullmatch(r"'([^']+)' does not depend on any axioms", line)
        if independent:
            reports[independent[1]] = set()

    for name in sorted(expected):
        if name not in reports:
            raise SystemExit(f"Missing axiom report for {name}")
        extra = reports[name] - allowed
        if extra:
            raise SystemExit(f"{name} uses forbidden axioms: {', '.join(sorted(extra))}")
    print("Axiom policy passed for " + ", ".join(sorted(expected)) + ".")


if __name__ == "__main__":
    main()
