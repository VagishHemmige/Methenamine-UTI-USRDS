# Purpose: synthetic demonstration of a definitive analysis step.
# Needs: demonstration_multiplier (setup.R), scale_values() (functions.R).
# Produces: demonstration_summary. Uses no data and writes no files.

## ---- create-synthetic-input
demonstration_values <- c(2, 4, 6)

## ---- compute-summary
demonstration_summary <- mean(scale_values(demonstration_values, demonstration_multiplier))
