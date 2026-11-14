# Analysis plan: Methenamine hippurate, antibiotic prophylaxis, and vaginal estrogen for recurrent urinary tract infection after kidney transplantation using USRDS

**Status:** Draft; not yet adopted. Reconciles the 2019 Montefiore protocol (v1.3, 5 October 2019) and the later Aim 2 proposal text with the known limitations of USRDS Medicare data. Open points are marked "Open" where they occur, each linked to its decision issue; dependent code waits until the issue is settled. Code examples are illustrative; final code lists require clinical review.

## Scope and reporting framework

This document is the authoritative specification of the study's scientific objectives, population, definitions, estimands and statistical methods. `ARCHITECTURE.md` documents the implementation, `AGENTS.md` the working conventions, and GitHub Issues the open decisions and implementation status. Neither file supersedes this plan.

Reporting will follow STROBE and RECORD [@vonelm2007strobe; @benchimol2015record]. The comparative analyses are specified as emulations of target trials [@hernan2016target] and will also follow TARGET [@cashin2025target]. The [reporting map](#12-reporting-map) links each checklist item to a section of this plan.

## 1. Objective

Single-center studies report fewer UTIs after methenamine initiation in kidney transplant recipients [@hollyer2019; @sweiss2022; @quinterocardona2020]. These were pre/post or uncontrolled comparisons. Prophylaxis is started when UTI frequency peaks, so a subsequent decline is expected from regression to the mean alone. In non-transplant women with recurrent UTI, a randomized trial found methenamine noninferior to daily antibiotic prophylaxis [@harding2022altar; @king2024altarcea]. No randomized evidence exists in kidney transplant recipients.

**Aim 1 (descriptive pharmacoepidemiology).** Among kidney transplant recipients with Medicare Parts A, B and D, describe annual use of methenamine, prophylactic-dose antibiotics and vaginal estrogen from 2006 through the last complete claims year, overall and by transplant center, and before vs. after publication of the ALTAR trial (March 2022).

**Aim 2 (primary comparative effectiveness).** Among recipients who meet a claims-based recurrent-UTI definition, estimate the effect of initiating (a) methenamine, (b) prophylactic-dose antibiotics, or (c) neither within 30 days, on the 12-month number of treated UTI episodes and on UTI hospitalization.

**Aim 3 (secondary).** Estimate the effect of initiating vaginal estrogen vs. not among women with recurrent UTI ([§8.3](#83-vaginal-estrogen-trial-aim-3)).

**Aim 4 (descriptive).** Reproduce the 2019 pre/post analysis with an explicit regression-to-the-mean reference ([§8.4](#84-prepost-with-a-regression-to-the-mean-reference-aim-4)).

These are observational estimates subject to residual confounding by indication; [§9](#9-sensitivity-analyses) lists the safeguards and [§3.2](#32-usrds-data-limitations-and-how-this-plan-handles-them) the data limitations.

**Out of scope.** Phenotyping (autoencoders), individualized treatment rules (Q-learning, targeted learning) and cost-effectiveness from the Aim 2 text are deferred to a follow-on study. They depend on a validated version of the cohort, exposure and outcome definitions here and on adequate numbers within subgroups.

## 2. Design

Aims 2 and 3 are emulations of target trials of initiation strategies among recipients who meet a recurrent-UTI definition, analyzed by clone–censor–weight [@hernan2016target; @maringe2020]. The target-trial protocol and how the emulation achieves each component are in [Appendix A](#appendix-a-target-trial-protocol). Aims 1 and 4 are descriptive.

### 2.1 Relation to the 2019 protocol

| 2019 protocol / Aim 2 element | This plan |
|---|---|
| Pre/post Poisson regression with clustering as primary | Retained as a **descriptive** secondary analysis with a matched non-initiator reference that quantifies regression to the mean ([§8.4](#84-prepost-with-a-regression-to-the-mean-reference-aim-4)) |
| Comparative analyses "if sufficiently powered" | **Primary**: target trial emulation of initiation strategies among recipients meeting a recurrent-UTI definition ([§4](#4-study-population)–[§8](#8-statistical-analysis), [Appendix A](#appendix-a-target-trial-protocol)) |
| Methenamine and topical estrogen analyzed together | Methenamine vs. antibiotic prophylaxis vs. neither is the primary question; vaginal estrogen is a separate trial in women ([§8.3](#83-vaginal-estrogen-trial-aim-3)) |
| Suppressive antibiotics as a group | Prophylactic-dose antibiotics defined by dose and supply, with TMP-SMX given for *Pneumocystis* prophylaxis handled explicitly ([§5.3](#53-prophylactic-dose-antibiotics)) |
| Autoencoder phenotypes, Q-learning, cost-effectiveness | Deferred to a later study that builds on this cohort ([§1](#1-objective)) |
| Claims 2006–2014/2017 | All Part D years available in the analyzed release (Part D begins 2006) |

## 3. Data source

### 3.1 Files and observation

**Files:** Core (patients, payer history, death, residence, facility), transplant files, institutional (inpatient and outpatient) and physician/supplier claims, Part D drug events (`PDE`) and Part D enrollment (`PDENROL`) for each available year from 2006. Skilled nursing, home health and hospice claims are not used for outcome ascertainment.

**Eligible observation time** for a person is the set of days on which all of the following hold: on or after a kidney transplant; Medicare FFS primary Parts A and B (`MPAB`); enrolled in a stand-alone Part D plan per L3; before the administrative end date (L13); and alive.

**Lookback:** 365 days of continuous eligible observation before time zero, used for eligibility, recurrent-UTI ascertainment, new-user status and covariates.

### 3.2 USRDS data limitations and how this plan handles them

This section is binding: definitions elsewhere in the plan are written to respect it. Confirm every item against the Researcher's Guide and appendices for the **specific release analyzed** [@usrds2025guide].

| # | Limitation | Consequence | Handling in this plan |
|---|---|---|---|
| L1 | Claims exist only for **Medicare fee-for-service** periods. Medicare Advantage, Medicare-secondary-payer periods (including the employer coordination period), other insurance and uninsured periods produce no or incomplete claims. ESRD beneficiaries could newly enroll in Medicare Advantage from 2021, so the FFS share shrinks in recent years. | Missing UTIs, antibiotics and covariates outside FFS primary periods; selection toward FFS beneficiaries in recent years. | Require Medicare FFS primary Parts A and B (`MPAB`) for the entire lookback and censor at loss of `MPAB` ([§3.1](#31-files-and-observation)). Report the FFS share by calendar year. Broader `MPAB`+`MPO` as a sensitivity analysis. |
| L2 | ESRD-based Medicare entitlement ends **36 months after a functioning transplant** for beneficiaries who are not ≥65 or disabled. | Recurrent UTI often arises years after transplant; later-onset recurrent UTI is observable only among recipients who keep Medicare (older, disabled, graft failure). Follow-up is truncated for others. | Describe the cohort by basis of Medicare entitlement and time since transplant. Treat coverage loss as censoring and model it with inverse-probability-of-censoring weights ([§8.2](#82-primary-analysis-aim-2)). State the restricted generalizability explicitly; do not present results as representing all recipients. |
| L3 | **Part D enrollment** is separate from A/B and recorded monthly (`PDENROL` contract IDs). Months with MA-PD contracts have drug events but no FFS medical claims. Beneficiaries with retiree drug subsidy or other drug coverage have no PDE records. | Drug exposure is unobservable outside stand-alone Part D months; MA-PD months would yield drugs without outcomes. | Require continuous Part D enrollment, defined from monthly contract IDs, *and* `MPAB` on the same days. Allow at most one missing month inside a span (as in the Santos pipeline [@santos2016]); verify the contract-type codes for each release. |
| L4 | PDE records **dispensings paid through Part D**. Cash purchases, discount-generic programs, samples, VA and other-payer fills do not appear. Inexpensive generics (nitrofurantoin, TMP-SMX, cephalexin, methenamine) are the most likely to be bought outside the plan. | Exposure misclassification, possibly differential by drug; under-ascertainment of treated outpatient UTIs. | Report fills per covered person-year by drug and year as a plausibility check. Sensitivity analysis restricting to low-income-subsidy enrollees (cost sharing near zero, so out-of-plan purchase is less likely). Interpret absolute UTI rates cautiously; prioritize the hospitalization outcome, which does not depend on PDE. |
| L5 | PDE shows **dispensing, not ingestion or indication**. Unfilled prescriptions are invisible. Prophylaxis vs. treatment must be inferred from drug, dose and supply. | Misclassification of prophylactic vs. treatment courses. | Dose and supply rules for prophylaxis ([§5.3](#53-prophylactic-dose-antibiotics)); continuous-use episodes with prespecified grace periods ([§5.4](#54-continuous-use-episodes-per-protocol-analyses)); sensitivity analyses varying the rules. |
| L6 | **Drugs given during inpatient stays** are bundled into Part A and absent from PDE; some outpatient parenteral antibiotics appear only as HCPCS J-codes on Part B claims. | Treatment for hospitalized UTIs is not seen in PDE; a supply appears to "run out" during a stay. | Inpatient UTI episodes are identified from institutional claims, not drug data. Extend outpatient supply by the length of overlapping inpatient stays. Include Part B antibiotic HCPCS codes for outpatient treatment. |
| L7 | **Immunosuppressants** for recipients whose transplant Medicare covered are billed largely under **Part B** (HCPCS J75xx), not Part D; the Part B immunosuppressive drug benefit began in 2023. | Immunosuppression is incompletely seen in PDE alone. | Ascertain maintenance immunosuppression from Part B HCPCS and PDE together, and from transplant-file induction and discharge regimens. Verify which claim files carry Part B drug claims in the release. |
| L8 | The prescriber is an encrypted ID (`PRSCRBRUSRD_ID`); **prescriber specialty is not available** in PDE. | Cannot attribute initiation to urology, nephrology or infectious diseases. | Use urology and infectious-disease visits from physician/supplier specialty codes as covariates. Prescriber ID may support clustering and a prescriber-preference instrument ([§9](#9-sensitivity-analyses)). |
| L9 | **No laboratory or microbiology data**: no urine cultures, organisms, susceptibility or creatinine. Asymptomatic bacteriuria cannot be distinguished from symptomatic infection. Resistance codes (e.g., ICD-10-CM Z16) exist only after October 2015 and are under-coded. | UTI case definitions are imperfect; surveillance intensity varies by center. | Outpatient UTI requires a diagnosis **plus** antibiotic treatment ([§7.1](#71-treated-uti-episode-primary-building-block)). Adjust for patient-level and center-level urine-culture billing ([§5.5](#55-surveillance-intensity)). Resistance outcomes are exploratory, ICD-10 era only. |
| L10 | **UTI diagnosis codes** are nonspecific and can reflect rule-out encounters. | Outcome misclassification. | Require treatment for outpatient episodes; collapse codes within 14 days into one episode; report the inpatient principal-diagnosis outcome separately. |
| L11 | **Urologic risk factors** (neurogenic bladder, reflux, stents, self-catheterization, prostatic disease) are inconsistently coded. | Residual confounding by indication. | Use them as covariates where coded; add a negative-control outcome ([§9](#9-sensitivity-analyses)). |
| L12 | Clinical transplant detail comes from transplant registration and follow-up forms (OPTN/UNOS-derived); post-transplant rejection treatment, immunosuppression changes and estimated GFR are incomplete. | Imperfect adjustment for net immunosuppression and graft function. | Use graft failure and retransplant dates from USRDS; rejection treatment from claims (e.g., thymoglobulin HCPCS) as a time-varying covariate where feasible. |
| L13 | **Data currency differs by file**: claims, Part D and death dates have different end dates in each release. | Apparent loss to follow-up near the end of data. | Define an administrative end of follow-up as the earliest complete date across the claims, PDE and enrollment files used; mortality ascertainment is not equated with claims availability. |
| L14 | **ICD-9-CM to ICD-10-CM** transition on 1 October 2015. | Discontinuities in coded conditions. | Era-specific code lists; outpatient/professional claims follow service date and inpatient claims follow discharge date [@cms2015transition]. Calendar period is a covariate; era-specific sensitivity estimates. |
| L15 | Unapproved **methenamine combination products** (with methylene blue, phenyl salicylate and others; marketed for urinary symptom relief) may appear under methenamine generic names. | Misclassification of symptomatic analgesic use as prophylaxis. | Classify by NDC and generic name into single-agent methenamine hippurate, methenamine mandelate, and combination products; only single-agent products define exposure. |
| L16 | **Small cells.** DUA disclosure rules. | Suppression of counts 1–10 and complementary cells. | Applied to all tables, figures and text; may limit center- and subgroup-level reporting ([§10](#10-disclosure-control)). |

### 3.3 Prior use of these data

Preliminary work in an earlier release, with Part D claims for 2006–2014, found enough transplant recipients with Part D who filled methenamine or vaginal estrogen to proceed.

## 4. Study population

Adult (≥18 at transplant) kidney recipients with a functioning graft and eligible observation time ([§3.1](#31-files-and-observation)) who meet the criteria below.

**Time since transplant.** Time zero is ≥180 days after the most recent kidney transplant. **Open:** [#1](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues/1) 180 days vs. 90 days.

**Recurrent UTI.** ≥2 treated UTI episodes ([§7.1](#71-treated-uti-episode-primary-building-block)) within 180 days, or ≥3 within 365 days, with the qualifying episode on or after day 180 post-transplant. Episodes before the most recent transplant do not count.

**New user.** No fill of methenamine or prophylactic-dose antibiotic in the 365-day lookback. Recipients receiving TMP-SMX at *Pneumocystis* prophylaxis dosing at time zero are eligible; that exposure is a baseline covariate. **Open:** [#2](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues/2) alternatively exclude, or restrict to recipients ≥12 months post-transplant when PJP prophylaxis has usually stopped.

**Exclusions at time zero.** Dialysis or graft failure, pregnancy codes in the prior 280 days, chronic indwelling catheter or nephrostomy codes (sensitivity: include).

**Repeated eligibility.** The primary analysis uses each recipient's first qualifying time zero. A sequential-trials sensitivity analysis uses every eligible qualifying episode, with robust variance by person.

## 5. Exposure and time zero

### 5.1 Methenamine
Single-agent methenamine hippurate or methenamine mandelate, identified by NDC and generic name (L15). Combination urinary analgesic products do not count.

### 5.2 Vaginal estrogen
Estradiol vaginal cream, tablets/inserts and low-dose ring, and conjugated estrogens vaginal cream. Systemic-dose vaginal rings (estradiol acetate) and oral/transdermal estrogens are excluded from exposure and recorded as covariates.

### 5.3 Prophylactic-dose antibiotics
An initiating fill with days supply ≥28 and a daily dose in the prophylactic range, for example nitrofurantoin ≤100 mg/day, cephalexin ≤500 mg/day, trimethoprim 100 mg/day, fosfomycin every 7–10 days, or TMP-SMX given as prophylaxis outside the PJP context. Daily dose = strength × quantity ÷ days supply, after collapsing same-day fills ([§5.6](#56-dispensing-records)). Initiation is classified from the first fill alone; later duration is not used to assign arms, because that would use future information.

**Open:** [#3](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues/3) final drug list and dose thresholds; whether TMP-SMX can ever count as UTI prophylaxis given identical PJP dosing.

### 5.4 Continuous-use episodes (per-protocol analyses)
Consecutive fills of the same agent form an episode when the gap after accounting for carried-over supply is ≤30 days. Supply is extended by overlapping inpatient days (L6). Discontinuation = episode end + grace period. Switching between strategies is a protocol deviation.

**Open:** [#4](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues/4) grace period of 15 days as in Santos et al. [@santos2016], or 30 days.

### 5.5 Surveillance intensity
Patient level: number of urine culture claims (e.g., CPT 87086, 87088) in the lookback. Center level: mean annual urine cultures per recipient among Part D-covered recipients without a UTI diagnosis, by transplant center and year, as proposed in the Aim 2 text.

### 5.6 Dispensing records
Exclude non-oral dosage forms where relevant; require positive quantity and days supply; collapse same-day fills of the same drug by summing quantity and days supply. Strength is parsed from the drug record, with drug-specific prophylactic vs. treatment thresholds ([§5.3](#53-prophylactic-dose-antibiotics)).

**Open:** [#5](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues/5) whether to also require positive patient pay, as the Santos pipeline did [@santos2016]; that filter excludes $0 low-income-subsidy fills and is proposed to be dropped.

### 5.7 Time zero
The end date of the qualifying (second or third) treated UTI episode, on which the recurrent-UTI criterion ([§4](#4-study-population)) is met.

### 5.8 Covariates
Measured at or before time zero unless noted: age, sex, race and ethnicity, calendar period, time since transplant, donor type, retransplant, diabetes, primary cause of kidney failure (including urologic), coded urologic abnormalities, prior UTI episode count and hospitalizations, prior resistant-organism code (ICD-10 era), prior *C. difficile*, immunosuppression class (L7), recent rejection treatment, TMP-SMX at PJP dosing, recent urology and infectious-disease visits, patient and center urine-culture intensity, low-income subsidy and dual eligibility, transplant center region. Time-varying covariates for weights: interim UTI episodes and hospitalization.

## 6. Comparators

Strategies, each started within 30 days of time zero: (A) start methenamine; (B) start prophylactic-dose antibiotics; (C) start neither. The A vs. B contrast is an active comparison of two prophylaxis decisions made at the same clinical juncture, reducing confounding by indication relative to A vs. C. Assignment is emulated by cloning each eligible person into all three strategies at time zero ([§8.2](#82-primary-analysis-aim-2)); there is no matching.

## 7. Outcomes

### 7.1 Treated UTI episode (primary building block)

**Inpatient.** An inpatient stay with a UTI or pyelonephritis code in the principal position (sensitivity: any position).

**Outpatient.** An outpatient institutional or physician/supplier encounter with a UTI code (cystitis, pyelonephritis, UTI site unspecified, catheter-associated UTI) and a treatment-dose antibiotic fill or Part B antibiotic administration from day −3 to +5. Prophylaxis-dose fills do not count. **Open:** [#6](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues/6) the treatment window.

**Episodes.** Codes and treatment within 14 days are one episode; the episode date is its first code.

### 7.2 Primary outcome
Number of treated UTI episodes within 12 months after the 30-day grace period ends, summarized as the mean cumulative count with death as a competing event [@ghosh2000].

**Open:** [#7](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues/7) whether the count starts at time zero or after the grace period; starting at time zero is preferred for the intention-to-initiate contrast.

### 7.3 Secondary outcomes
UTI hospitalization (principal diagnosis); urosepsis or bacteremia with a urinary source; days of treatment-dose antibiotic supply; *Clostridioides difficile* infection; all-cause hospitalization; graft failure; death; Medicare payments (via [{usRds}](https://vagishhemmige.github.io/usRds/) cost functions, inflation-adjusted). Exploratory: fluconazole-treated candidiasis; resistant-organism codes (ICD-10 era only).

### 7.4 Follow-up and censoring
Follow-up runs 12 months from time zero, until the outcome count horizon, death, graft failure, retransplant, loss of eligible observation ([§3.1](#31-files-and-observation)), or the administrative end date (L13), with the censoring reason recorded.

## 8. Statistical analysis

### 8.1 Descriptive analysis (Aim 1)
Annual period prevalence of each exposure per 1,000 Part D-covered recipient-years, by calendar year and center; interrupted time-series description around March 2022 (descriptive, not causal).

### 8.2 Primary analysis (Aim 2)

1. **Clone–censor–weight.** Each eligible person is cloned into all three strategies at time zero. A clone is censored when its observed treatment deviates from its strategy (for example, a strategy C clone that fills methenamine on day 12). Censoring is modeled with pooled logistic regression on baseline and time-varying covariates ([§5.8](#58-covariates)), giving stabilized inverse-probability-of-censoring weights [@maringe2020]. Censoring at loss of eligible observation (L1–L3) is weighted in the same framework.
2. **Estimands.** Weighted mean cumulative counts and 12-month risks of UTI hospitalization by strategy. Contrasts: A vs. C (does methenamine reduce UTIs compared with no prophylaxis?) and A vs. B (how does it compare with antibiotic prophylaxis?). Report rate ratios and differences with bootstrap 95% CIs (resampling persons).
3. **Per-protocol.** Additionally censor at discontinuation or switching ([§5.4](#54-continuous-use-episodes-per-protocol-analyses)) with time-varying weights.
4. **Diagnostics.** Weight distribution and truncation (1st/99th percentile as sensitivity), covariate balance after weighting, positivity by center and period.
5. **Sample size.** Determined by available data; contrasts are not described as formally powered. Report precision.

### 8.3 Vaginal estrogen trial (Aim 3)
Same machinery as Aim 2, restricted to women aged ≥50 (menopause proxy) meeting [§4](#4-study-population). Strategies: initiate vaginal estrogen within 30 days vs. not. Initiation of methenamine or antibiotic prophylaxis during follow-up is a time-varying covariate in the censoring weights for the per-protocol analysis; it is not a deviation in the intention-to-initiate analysis.

**Open:** [#8](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues/8) the age threshold.

### 8.4 Pre/post with a regression-to-the-mean reference (Aim 4)
Among methenamine initiators, compare treated UTI episode rates in the 12 months before and after initiation (Poisson or negative binomial with person-level clustering, as in the 2019 protocol). Repeat the identical calculation among eligible non-initiators anchored at the same qualifying-episode definition and matched on prior UTI count, time since transplant and calendar year. The difference between the two before/after ratios is the descriptive quantity of interest. Report this analysis as illustrating regression to the mean, not as a causal effect.

### 8.5 Effect modification and subgroups
Prespecified subgroups: sex, age ≥65, diabetes, time since transplant (<2 vs ≥2 years), urologic primary disease, ICD era.

### 8.6 Multiplicity
**Open:** [#10](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues/10) not yet specified.

### 8.7 Missing data
**Open:** [#11](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues/11) not yet specified.

### 8.8 Software
R, with USRDS files accessed through {usRds}. Record the {usRds} version or commit and the USRDS release for every result.

## 9. Sensitivity analyses

1. **Negative-control outcome.** An outcome that methenamine should not affect but that shares healthcare-contact pathways [@lipsitch2010]. A non-null estimate flags residual confounding. **Open:** [#9](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues/9) the outcome; candidates are herpes zoster and hip fracture.
2. **Quantitative bias analysis** for exposure misclassification from out-of-plan fills (L4), using the low-income-subsidy restriction as an anchor.
3. **Instrumental variable (exploratory).** Center- or prescriber-level methenamine preference in the prior calendar year, as suggested in the 2019 protocol; report the instrument's strength and assumptions explicitly.
4. **Analyses named elsewhere in this plan:** broader `MPAB`+`MPO` coverage (L1); restriction to low-income-subsidy enrollees (L4); varied prophylaxis and grace-period rules (L5, [§5.4](#54-continuous-use-episodes-per-protocol-analyses)); era-specific estimates (L14); including recipients with chronic catheter or nephrostomy codes and sequential trials using every qualifying episode ([§4](#4-study-population)); inpatient UTI in any diagnosis position ([§7.1](#71-treated-uti-episode-primary-building-block)); weight truncation ([§8.2](#82-primary-analysis-aim-2)).

## 10. Disclosure control
Governed by the USRDS data use agreement. Public code and code lists may be shared; restricted patient-level data may not. Suppress counts 1–10 and values derivable from complementary cells in all tables, figures and text; this may limit center- and subgroup-level reporting (L16).

## 11. Limitations to address in reporting
Restricted generalizability to recipients who keep Medicare FFS and Part D (L1–L3); residual confounding by indication (L11); exposure and outcome misclassification from dispensing-only data, out-of-plan fills and the absence of laboratory data (L4, L5, L9, L10).

## 12. Reporting map

| Checklist item | Topic | Plan section |
|---|---|---|
| STROBE 2 | Background and rationale | [1](#1-objective) |
| STROBE 3 | Objectives | [1](#1-objective) |
| STROBE 4 | Study design | [2](#2-design), [Appendix A](#appendix-a-target-trial-protocol) |
| STROBE 5 | Setting, dates, follow-up | [3.1](#31-files-and-observation), [7.4](#74-follow-up-and-censoring) |
| STROBE 6 / RECORD 6.1–6.3 | Eligibility, selection codes and algorithms, validation, linkage | [3.1](#31-files-and-observation), [4](#4-study-population) |
| STROBE 7 / RECORD 7.1 | Variables and code lists | [5](#5-exposure-and-time-zero), [7](#7-outcomes) |
| STROBE 8 | Data sources and measurement | [3](#3-data-source) |
| STROBE 9 | Bias | [6](#6-comparators), [9](#9-sensitivity-analyses), [11](#11-limitations-to-address-in-reporting) |
| STROBE 10 | Study size | [8.2](#82-primary-analysis-aim-2) |
| STROBE 11 | Quantitative variables | [5](#5-exposure-and-time-zero), [7](#7-outcomes) |
| STROBE 12 / RECORD 12.1–12.3 | Statistical methods, data access, cleaning, linkage | [3.3](#33-prior-use-of-these-data), [5.6](#56-dispensing-records), [8](#8-statistical-analysis), [9](#9-sensitivity-analyses) |
| TARGET | Target-trial protocol and emulation (item numbers to be checked against the statement) | [Appendix A](#appendix-a-target-trial-protocol) |

## References
References are stored in `references.bib`.

## Appendix A: Target-trial protocol

Aim 2. Aim 3 uses the same protocol with the population and strategies in [§8.3](#83-vaginal-estrogen-trial-aim-3).

| Component | Target trial | Emulation |
|---|---|---|
| Eligibility | Adult (≥18 at transplant) kidney recipients with a functioning graft, [≥180 days]{.pending} after the most recent kidney transplant, with recurrent UTI, no prophylaxis in the past 365 days | [§4](#4-study-population) |
| Strategies | (A) start methenamine within 30 days; (B) start prophylactic-dose antibiotics within 30 days; (C) start neither within 30 days | [§5](#5-exposure-and-time-zero), [§6](#6-comparators) |
| Assignment | Randomized | Clone–censor–weight at time zero [@maringe2020] |
| Time zero | Date recurrent-UTI criterion is met | End date of the qualifying (second or third) treated UTI episode ([§5.7](#57-time-zero)) |
| Follow-up | 12 months | Until outcome count horizon, death, graft failure, retransplant, loss of eligible observation, or administrative end ([§7.4](#74-follow-up-and-censoring)) |
| Outcomes | [§7](#7-outcomes) | [§7](#7-outcomes) |
| Causal contrasts | Intention-to-initiate (observational analogue of ITT given initiation) and per-protocol | [§8.2](#82-primary-analysis-aim-2) |
| Analysis plan | Comparison of outcome by assigned strategy | Weighted estimators in [§8.2](#82-primary-analysis-aim-2) |
