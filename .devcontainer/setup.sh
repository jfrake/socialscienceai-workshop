#!/usr/bin/env bash
# Codespace post-create setup for the Social Science AI workshop.
# Installs Claude Code, the R packages used in live demos, and the Python
# packages used in breakouts.
#
# R packages are installed from Posit Public Package Manager so we get
# precompiled Linux binaries (Ubuntu 22.04 jammy) instead of building
# from source. This drops total R install time from ~10 min to ~2 min.

set -euo pipefail

echo ""
echo "==================================================================="
echo "  Social Science AI workshop: Codespace setup"
echo "==================================================================="
echo ""

echo "[1/3] Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash
echo "      done."
echo ""

echo "[2/3] Installing R packages (about 2 min via precompiled binaries)..."
sudo R --no-save <<'EOF'
# Use Posit Public Package Manager for precompiled Ubuntu jammy binaries.
# This requires the HTTPUserAgent header to identify the platform; without
# it, P3M falls back to source packages.
options(
  repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/jammy/latest"),
  HTTPUserAgent = sprintf(
    "R/%s R (%s)",
    getRversion(),
    paste(getRversion(), R.version$platform, R.version$arch, R.version$os)
  )
)
pkgs <- c(
  "fixest", "modelsummary", "ggplot2", "data.table",
  "dplyr", "tidyr", "readr", "scales", "lubridate"
)
install.packages(pkgs, Ncpus = 2)
quit(status = 0, save = "no")
EOF
echo "      done."
echo ""

echo "[3/3] Installing Python packages..."
pip install --user --no-cache-dir \
  pandas \
  statsmodels \
  linearmodels \
  seaborn \
  matplotlib \
  pyarrow
echo "      done."
echo ""

echo "==================================================================="
echo "  Setup complete."
echo "==================================================================="
echo ""
echo "  To start Claude Code:"
echo "    1. Open a terminal: View > Terminal"
echo "    2. Type:  claude"
echo "    3. Follow the URL it prints to authenticate in your browser"
echo ""
