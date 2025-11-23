# LaTeX diff helper

This repository provides a small PowerShell script `diff` that generates a
**marked-up LaTeX diff** between two Overleaf projects.

Given two `.zip` exports of your paper (old version and revised version), the
script creates a `diff.tex` file that highlights all changes. You can upload
`diff.tex` back to Overleaf and compile it to get a PDF with insertions and
deletions clearly marked.

---

## Prerequisites

- **Windows**
- **PowerShell**
- A LaTeX distribution with `latexdiff`, e.g.
  - [MiKTeX](https://miktex.org/)
  - [TeX Live](https://tug.org/texlive/)
- Two Overleaf source ZIPs:
  - one for the **old** version of the project
  - one for the **revised** version
- You know the name of the main `.tex` file (e.g. `main.tex`,
  `neurips_2025.tex`, etc.)

You can check that `latexdiff` is available by running:

```powershell
latexdiff --help

## Usage
