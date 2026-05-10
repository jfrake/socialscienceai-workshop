# CLAUDE.md: Social Science AI workshop project

Read at the start of every Claude Code session in this project. Defines
the project context, data, statistical defaults, output conventions, and
anti-patterns.

## Project context

This is the workshop project for the four-day course on agentic coding
tools for empirical social science (socialscienceai.com). The exercises
work toward two research questions:

1. What predicts restaurant inspection scores in New York City?
2. Do restaurants improve after receiving a bad grade?

The data is the NYC Department of Health and Mental Hygiene (DOHMH)
restaurant inspection records, public on NYC Open Data. The raw data
has one row per violation per inspection visit; the workshop aggregates
to one row per restaurant per inspection, then to a restaurant-quarter
panel for the main analyses.

This is a teaching project. Privileging clarity, reproducibility, and
explicit verification over cleverness or speed is the right call almost
every time.

## Data

- **Source:** https://data.cityofnewyork.us/Health/DOHMH-New-York-City-Restaurant-Inspection-Results/43nn-pn8j
- **Raw file:** `data/raw/inspections_raw.csv` (downloaded on Day 1; treat as immutable)
- **Cleaned panel:** `data/processed/inspections_clean.csv` (built on Day 1; one row per camis x quarter)

### Key variables

- `camis`: restaurant identifier (string). The panel ID for clustering and fixed effects.
- `dba`: restaurant name (string). May be inconsistent across inspections; use the most recent value per camis.
- `boro`: borough (Manhattan, Brooklyn, Queens, Bronx, Staten Island).
- `cuisine_description`: categorical, roughly 80 levels.
- `inspection_date`: date of the inspection.
- `score`: inspection score (numeric, lower is better). Primary outcome.
- `grade`: letter grade (A, B, C, or missing). Missing grades are common and informative; do not drop them silently.
- `violation_code`, `violation_description`: what was flagged on a given visit.
- `critical_flag`: "Critical", "Not Critical", or "Not Applicable".
- `latitude`, `longitude`, `zipcode`, `nta`: location.

### Aggregation conventions

- Restaurant-inspection panel: one row per `camis x inspection_date`.
- Restaurant-quarter panel: one row per `camis x quarter`, taking the most recent inspection's score.
- Always create explicit count variables: `total_violation_count`, `critical_violation_count`.

## Statistical defaults (R primary; Python users adapt)

- Use `fixest::feols()` for all regressions. Never `lm()` for main results.
- Cluster standard errors at the restaurant level: `vcov = ~camis`.
- Default fixed effects when relevant: `cuisine_description` and `quarter`.
- Report N, R-squared, and number of clusters for every specification.
- Python equivalents: `linearmodels.PanelOLS` with `cluster_entity=True`, or `statsmodels` with cluster-robust SEs. Match the same conventions.

## Output conventions

- Tables: `modelsummary` package, exported as `.tex` to `output/tables/`. Encode formatting choices in CLAUDE.md or a custom skill so they are reproducible; never hand-edit the rendered output.
- Figures: `ggplot2` with `theme_minimal()`, 12pt body font, grayscale palette safe for print. Save both PDF and PNG to `output/figures/` at 300 DPI, 6.5 x 4.5 inches.
- File names: snake_case, descriptive, dated where appropriate (e.g., `regress_score_on_violations_2026_06.tex`).

## Verification

- After every transformation, assert row counts and uniqueness explicitly:
  ```r
  stopifnot(nrow(panel) == nrow(distinct(panel, camis, quarter)))
  ```
- Check missing-value patterns before any subsetting. Print counts before and after.
- Compare your numbers against the workshop answer key for the current exercise tier. If your N differs, investigate before moving on.

## Anti-patterns

- Never use `lm()` for main results.
- Never `na.omit()` or `drop_na()` without naming the variables in scope and the row count dropped.
- Never silently drop `grade` is missing rows; restaurants with numeric `score` but no letter grade are valid observations.
- Never `filter()` to subset before counting; count first, filter after, so the dropped count is visible.
- Never use `n()` in aggregation when you mean `n_distinct(violation_code)` (a single violation may span multiple raw rows).
- Never delete files in `data/raw/`. The raw data is downloaded once and treated as immutable.

## Workflow notes

- Use plan mode (Shift+Tab Tab) for any multi-step task. Review the plan before approving execution.
- Use `/clear` between unrelated tasks; long sessions push these conventions out of context and Claude starts ignoring them.
- The Day 2 trust-but-verify exercise plants two subtle bugs in a Claude-written script. Read carefully; the bugs are pedagogically chosen, not trivial.
- When formatting an output is harder than expected, encode the convention in this file or a custom skill rather than hand-editing the result.

## Where things live

```
.
├── CLAUDE.md              # this file
├── data/
│   ├── raw/               # immutable; downloaded on Day 1
│   └── processed/         # built from raw; safe to delete and regenerate
├── code/                  # analysis scripts
├── output/
│   ├── tables/            # .tex tables
│   └── figures/           # .pdf and .png
└── paper/                 # writeup if you compile one
```
