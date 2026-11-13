<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->
[![Status](https://img.shields.io/badge/status-planning-yellow)](#)
[![Methods](https://img.shields.io/badge/methods-under_development-blue)](#)
[![Not for Citation](https://img.shields.io/badge/use-not_for_citation-lightgrey)](#)
<!-- [![License](https://img.shields.io/badge/license-MIT-lightgrey)](LICENSE.md) -->
<!-- badges: end -->

# Methenamine and recurrent UTI after kidney transplantation

The goal of this study is to compare starting methenamine hippurate, starting antibiotic prophylaxis, or starting neither for recurrent urinary tract infection after kidney transplantation, and to describe how these treatments and vaginal estrogen are used. It will use the United States Renal Data System (USRDS) with linked Medicare Parts A, B and D claims.

This is a planning repository: there is no active IRB approval, no data are in use, and the analysis plan is a draft.

The full analysis website, which explains the code step by step, is available at:
https://vagishhemmige.github.io/Methenamine-UTI-USRDS/

## Documentation

- [`analysis-plan.md`](analysis-plan.md): what the analysis is meant to do
- `ARCHITECTURE.md`: how the code is organized (written once there is analysis code)
- [`AGENTS.md`](AGENTS.md): how to work in this repository
- [Issues](https://github.com/VagishHemmige/Methenamine-UTI-USRDS/issues): open decisions and known gaps

## Running the analysis

Run `R/main.R` from the project root. For now it runs only the starter's synthetic example. The analysis will require authorized access to the USRDS files, located through the [{usRds}](https://vagishhemmige.github.io/usRds/) package.

<!-- Results: add only when the figures and tables are cleared for public release. -->
