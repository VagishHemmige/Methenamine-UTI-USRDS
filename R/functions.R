# Purpose: reusable helper functions. Each takes its inputs as arguments.
# Needs: setup.R. Produces: functions only.

## ---- scale-values
scale_values <- function(values, multiplier) {
  values * multiplier
}
