# LaTeXDiff Helper Script (Windows + Overleaf)

This repository provides a small PowerShell script to generate a **marked-up LaTeX diff** between two Overleaf projects.

Given:

- an “old” version of the paper (ZIP exported from Overleaf), and  
- a “revised” version (another ZIP),

the script will:

1. Unzip both projects.
2. Locate the main LaTeX file in each project.
3. Run `latexdiff --flatten` on them.
4. Produce `diff_output/diff.tex`, which can be compiled into a PDF with insertions and deletions highlighted.

This is useful when journals or conferences ask for a “tracked changes” or “marked-up” version of a LaTeX manuscript.

---

## Requirements

- Windows
- A TeX distribution that includes `latexdiff`, for example:
  - [MiKTeX](https://miktex.org/)
  - [TeX Live](https://tug.org/texlive/)
- PowerShell (comes with modern Windows by default)

After installing MiKTeX or TeX Live, verify that `latexdiff` is available:

```powershell
latexdiff --help
