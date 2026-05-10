#!/usr/bin/env bash
# Codespace post-create setup for the Social Science AI workshop.
# Installs Claude Code, the R packages used in live demos, and the Python
# packages used in breakouts.

set -euo pipefail

echo "::: Installing Claude Code :::"
curl -fsSL https://claude.ai/install.sh | bash

echo "::: Installing R packages (this takes about 3 minutes) :::"
sudo R --no-save <<'EOF'
options(repos = c(CRAN = "https://cloud.r-project.org"))
pkgs <- c(
  "fixest", "modelsummary", "ggplot2", "data.table",
  "dplyr", "tidyr", "readr", "scales", "lubridate"
)
install.packages(pkgs, Ncpus = 4)
EOF

echo "::: Installing Python packages :::"
pip install --user --no-cache-dir \
  pandas \
  statsmodels \
  linearmodels \
  seaborn \
  matplotlib \
  pyarrow

echo ""
echo "::: Setup complete :::"
echo ""
echo "To start Claude Code:"
echo "  1. Open a terminal (View > Terminal)"
echo "  2. Type:  claude"
echo "  3. Follow the URL it prints to authenticate in your local browser"
echo ""
