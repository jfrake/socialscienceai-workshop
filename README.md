# Social Science AI workshop: Codespace fallback

Cloud development environment for the four-day workshop on agentic coding tools for empirical social science researchers.

This is the **fallback environment** for participants whose laptops cannot run Claude Code locally (IT-managed machines, install failures, etc.). Everything you need to follow along is pre-installed.

## Open this in a Codespace

Click the green **Code** button at the top of the GitHub repo and select **Codespaces > Create codespace on main**.

Or use this one-click URL: <https://codespaces.new/jfrake/socialscienceai-workshop>

Setup takes about three minutes the first time, while R packages install. Subsequent launches are fast.

## What is pre-installed

- **Claude Code** (CLI; authenticate on first use)
- **R** with: `fixest`, `modelsummary`, `ggplot2`, `data.table`, `dplyr`, `tidyr`, `readr`, `scales`, `lubridate`
- **Python 3.12** with: `pandas`, `statsmodels`, `linearmodels`, `seaborn`, `matplotlib`, `pyarrow`

The workshop dataset is downloaded on Day 1 as the first hands-on task, using Claude Code itself.

A workshop project [`CLAUDE.md`](./CLAUDE.md) lives at the root of this repo. Claude Code reads it at the start of every session and uses it to apply the workshop's conventions: variable names, statistical defaults, output formatting, and anti-patterns. Look at it once before Day 1 so you know what is in scope.

## First-time Claude Code authentication

In a Codespace, Claude Code cannot open your browser for you (it is running on a remote machine). Instead:

1. Open the integrated terminal: View > Terminal
2. Type `claude` and press Enter
3. Claude Code prints a URL and a one-time code
4. Open the URL in your local browser, paste the code, and authorize
5. Return to the terminal once authorized

You only do this once per Codespace.

## Workshop site

<https://socialscienceai.com> for schedule, materials, slides, and resources.
