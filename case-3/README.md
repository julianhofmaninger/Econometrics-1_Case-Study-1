# 📊 Econometrics Case Study — Econometrics I (Case Study 3)

## 📌 Overview
This repository contains the third case study developed for the module **Econometrics I** at **Vienna University of Economics and Business**.  
The project applies econometric methods to analyze labor market mobility, specifically the determinants of employer changes among Austrian workers.

**Authors:** Tsz Lam Hung, Daniel Diederichs and Julian Hofmaninger  
**Instructor:** Univ.Prof. David Preinerstorfer, Ph.D  
**Term:** Winter Term 2025/2026   

---

## 🎯 Research Objective
The aim of this case study is to investigate how frequently Austrian workers change employers and which factors influence this decision.

In particular, we analyze how demographic characteristics, occupational status, employment history, and wage categories affect the number of employer changes between 1986 and 1998.

The dependent variable of interest is the count of employer changes (`nchange`).

---

## 📚 Dataset
**File:** `change.csv`  
**Observations:** 2,222 non-self-employed workers  
**Time Period:** 1986–1998  

### Variables Used in the Analysis:
- `nchange` — Number of employer changes between 1986 and 1998  
- `gender` — Indicator variable (1 = female, 0 = male)  
- `occupation` — Indicator variable (1 = white collar, 0 = blue collar)  
- `age` — Age in 1986 (in years)  
- `periodsincome` — Number of years with registered positive income  
- `medianwage` — Wage category (1 = lowest quintile, 5 = highest quintile)  

Since income is measured in categories, dummy variables are introduced for the wage categories in the regression analysis.

---

## 🧠 Methodology
Summarize the econometric methods used:
- Descriptive Statistics
- Multiple OLS Regression
  - Modeling Quadratic Terms
  - Modeling Interaction Effects
- Model Comparison
- Residual Diagnostics