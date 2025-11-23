Param(
    [Parameter(Mandatory = $true)]
    [string]$OldZip,
    [Parameter(Mandatory = $true)]
    [string]$NewZip,
    [Parameter(Mandatory = $true)]
    [string]$MainTex
)

Write-Host "=== LaTeXDiff helper script (Windows PowerShell) ==="

# 1. Check latexdiff
$latexdiffPath = Get-Command latexdiff -ErrorAction SilentlyContinue
if (-not $latexdiffPath) {
    Write-Host "ERROR: 'latexdiff' not found. Please install a TeX distribution (e.g., MiKTeX / TeX Live) and ensure 'latexdiff' is in PATH." -ForegroundColor Red
    exit 1
}

# 2. Clean directories
Remove-Item -Recurse -Force old,new,diff_output -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path old | Out-Null
New-Item -ItemType Directory -Path new | Out-Null
New-Item -ItemType Directory -Path diff_output | Out-Null

# 3. Unzip projects
Write-Host "Unzipping ZIP files ..."
Expand-Archive -LiteralPath $OldZip -DestinationPath old -Force
Expand-Archive -LiteralPath $NewZip -DestinationPath new -Force

# 4. Find main tex file
Write-Host "Searching for main file: $MainTex ..."
$oldMain = Get-ChildItem -Path old -Recurse -Filter $MainTex | Select-Object -First 1
$newMain = Get-ChildItem -Path new -Recurse -Filter $MainTex | Select-Object -First 1

if (-not $oldMain -or -not $newMain) {
    Write-Host "ERROR: Could not find $MainTex in 'old' or 'new' directories." -ForegroundColor Red
    exit 1
}

Write-Host "Old version main file: $($oldMain.FullName)"
Write-Host "New version main file: $($newMain.FullName)"

# 5. Run latexdiff via cmd.exe to avoid encoding issues
Write-Host "Running latexdiff --flatten ..."
$oldPath  = $oldMain.FullName
$newPath  = $newMain.FullName
$diffDir  = (Resolve-Path diff_output).Path
$diffPath = Join-Path $diffDir "diff.tex"

# Build a command string for cmd.exe
$cmd = "latexdiff --flatten `"$oldPath`" `"$newPath`" > `"$diffPath`""
cmd.exe /c $cmd

Write-Host "Diff file generated: $diffPath"

# 6. Optional: try to compile diff.tex locally
Set-Location $diffDir
$xelatex = Get-Command xelatex -ErrorAction SilentlyContinue
if ($xelatex) {
    Write-Host "Running xelatex on diff.tex ..."
    & xelatex -interaction=nonstopmode diff.tex > $null 2>&1
    Write-Host "If compilation succeeds, you can open diff_output\diff.pdf locally."
} else {
    Write-Host "xelatex not found; skip local compilation."
}

Write-Host "All done. You can upload diff_output\diff.tex to Overleaf."
