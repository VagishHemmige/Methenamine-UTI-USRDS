# Implementation notes: methenamine/UTI study

These two sections were §12 and §14 of the analysis plan draft of 26 October 2026. The R analysis workflow keeps implementation out of the plan, so they are held here until code is written. Then the Santos pipeline becomes input to `ARCHITECTURE.md` and the code, and each `usRds` dependency becomes an issue in `usRds` linked from a study issue (see `AGENTS.md`). Scientific choices from these sections stay in the plan: the positive-patient-pay question is plan §5.6, and the grace period is plan §5.4.

## Implementation reference: the Santos CMV-prophylaxis SAS pipeline

The SAS code used for Santos et al. [@santos2016] provides tested logic for several components and should be ported to `usRds` rather than rewritten from scratch:

- **Part D enrollment spans** from `PDENROL` monthly contract IDs: months whose contract ID begins with `H`, `R`, `S` or `E` counted as enrolled; spans restart after two consecutive non-enrolled months; years with duplicate records resolved by most months covered; span end extended to end of month. (Under L3, `H`/`R` contract months are MA-PD and must not count as FFS-observable; this plan requires `MPAB` concurrently.)
- **PDE cleaning:** exclude non-oral dosage forms by `GCDF_DESC` where relevant; require positive patient pay, quantity and days supply (whether to keep the patient-pay requirement is open: plan §5.6); collapse same-day fills of the same drug by summing quantity and days supply.
- **Daily dose:** strength parsed from `STR` × quantity ÷ days supply, with drug-specific prophylactic vs. treatment thresholds.
- **Continuous-use episodes:** carried-over supply with a new episode when the deficit exceeds 15 days; episode end truncated at study end.
- **Follow-up end:** minimum of Medicare end, Part D end, retransplant, other organ transplant and death, with the censoring reason recorded.
- **Immunosuppression:** induction and maintenance agents from the UNOS-derived immunosuppression file (`TXIRUNOS`) with drug-code groupings.

## `usRds` dependencies

This analysis cannot proceed until `usRds` supports the items below. Each should be an issue in `usRds`, linked from a study-specific issue here (see `AGENTS.md`). Observations are from `usRds` commit `e7ac385`.

| # | Need | Current state |
|---|---|---|
| U1 | Part D file registry for `PDE` and `PDENROL` by year, including split files | `.map_USRDS_files()` recognizes the "ESRD PartD" directory. `data-raw/DATASET.R` reads `File lists for functions/PDE.xlsx`, which is not in the repository. |
| U2 | `get_PDE()`: extract drug events by generic or brand name pattern and/or NDC list, years and IDs, returning standard columns with parsed dates | Absent |
| U3 | Part D enrollment spans from monthly contract IDs, with contract-type classification, gap tolerance, and monthly low-income subsidy and dual-eligibility flags; same interface as `verify_medicare_primary()` (lookback check plus span end for censoring) | Absent |
| U4 | Combined A/B/D eligibility: intersection of `MPAB` spans and Part D spans | `verify_medicare_primary()` covers A/B only |
| U5 | Drug episode builder: same-day collapse, daily dose from strength, carried-over supply, grace periods, inpatient-day extension | Absent |
| U6 | Versioned drug reference lists (NDC ↔ ingredient, dosage form, single-agent vs. combination) | Absent |
| U7 | Inpatient diagnosis position (principal vs. secondary), discharge date and claim key from `get_IN_ICD()` | Returns `USRDS_ID`, `CODE`, `CLM_FROM`, `HCFASAF` only; no `CLM_THRU`, diagnosis position or claim key. SAS branches of `get_IN_ICD()`/`get_PS_ICD()` drop `HCFASAF`. |
| U8 | Encounter grouping for physician/supplier lines and stays (shared with the cryptococcosis study) | Noted in sibling-repo `AGENTS.md` |
| U9 | Part B drug claims (antibiotics, immunosuppressants) by HCPCS; confirm which SAF holds DMEPOS claims | `get_PS_HCPCS()`/`get_IN_HCPCS()` exist; DMEPOS location unverified |
