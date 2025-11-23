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
```
---

## Usage
- **Export both versions from Overleaf as ZIP files**
- **Place the script diff and the two ZIP files in the same folder**
  
```C:\Users\you\Desktop\latex-diff\
    diff
    paper_old.zip
    paper_rev.zip
```

- **Open PowerShell in that folder and (for this session only) allow script
execution:**

```Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass```

- **Run the script, specifying:**
-OldZip – old version ZIP file

-NewZip – revised version ZIP file

-MainTex – main LaTeX file inside the project

- **Example:**
```
.\diff -OldZip "paper_old.zip" -NewZip "paper_rev.zip" -MainTex "neurips_2025.tex"
```

- **After it finishes, you will get a folder:**
```diff_output/
    diff.tex
    (optionally diff.pdf if a local LaTeX engine is installed)
```

- **Getting the marked-up PDF**
- Open your revised Overleaf project.
- Upload diff_output/diff.tex to the project.
- Set diff.tex as the main file in Overleaf.(just click this file is ok)
- Recompile.

The resulting PDF is a marked-up version of your paper showing all changes
between the old and revised LaTeX sources.



