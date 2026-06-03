# Hospital Patient Flow — Operational Analysis & Dashboard

A healthcare analytics project investigating patient flow patterns across a hospital system
using relational SQL data, covering admission volume, length of stay, discharge outcomes,
and operational bottlenecks. Built as part of the DataVerse Africa Healthcare Analytics
Internship Program — Cohort 4.0.

---

## Table of Contents
- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools](#tools)
- [Data Cleaning](#data-cleaning)
- [Data Analysis](#data-analysis)
- [Dashboard Preview](#dashboard-preview)
- [Results/Findings](#resultsfindings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)

---

## Project Overview
This project simulates a real-world hospital operations analytics assignment completed
as a team of four analysts. Acting as Junior Healthcare Data Analysts, the objectives were to:
- Investigate patient admissions and discharge data across three relational database tables
- Answer 15 specific business questions using SQL to identify pressure points in patient flow
- Build an interactive Power BI dashboard translating SQL findings into leadership-ready visuals
- Deliver a one-page executive summary communicating insights to a non-technical audience

The analysis answers four core leadership questions:
- Where is pressure entering the hospital, which routes, departments, or patient types?
- How long are patients staying, and does that vary in ways that signal inefficiency?
- Where are patients getting stuck between admission and discharge?
- When does congestion most likely occur, by hour, by day, or by pattern?

---

## Data Sources
- **Dataset:** Hospital Operational Database (3 relational tables)
- **Records:** 5,000 patient admissions
- **Tables:** `patients`, `admissions`, `diagnoses`
- **Fields covered:** Patient demographics, admission type, department, admission and discharge
  datetimes, discharge disposition, and ICD-10 diagnosis codes

---

## Tools
- **PostgreSQL (via Visual Studio Code)** — SQL querying and relational data analysis
- **Power BI Desktop** — Interactive dashboard and data visualisation
- **Microsoft Word** — Executive summary and project documentation

---

## Data Cleaning
The dataset was relatively clean on arrival. Pre-analysis validation confirmed structural
integrity across all three tables before querying began.

| Check Performed | Outcome |
|---|---|
| Primary and foreign key relationships | Confirmed intact across all three tables |
| Null values in key fields | No significant nulls identified |
| Datetime format consistency | admission_datetime and discharge_datetime formatted consistently |
| Duplicate records | No duplicate admissions detected |
| LOS calculation validation | Discharge minus admission datetime validated before use |

---

## Data Analysis
**Week 4 — SQL Operational Analysis**

Fifteen business questions were investigated and interpreted for a non-technical audience:

| # | Business Question | Key Finding |
|---|---|---|
| 1 | Daily admission volume | 10–18 admissions per day; intermittent peaks above 20 |
| 2 | Overall average LOS | 4.03 days |
| 3 | LOS by department | Range: 3.9–4.2 days; Pediatrics, Surgery, Orthopedics highest |
| 4 | Admission type distribution | Emergency 55.1%, Elective 29.56%, Urgent 15.34% |
| 5 | Admission type with longest LOS | Urgent — 4.3 days average |
| 6 | Discharge disposition breakdown | Home 71.24%, Rehab 15.68%, Skilled Nursing 10.38%, Expired 2.7% |
| 7 | Discharge disposition vs. LOS | LOS nearly identical across all disposition types (~4 days) |
| 8 | Peak admission hours | Bi-modal: 5 AM peak and 7–8 PM evening cluster |
| 9 | Day-of-week admission patterns | Sunday highest (737); Saturday lowest (697) |
| 10 | Top 5 departments by volume | Orthopedics (895), Pediatrics (884), Surgery (814), OB/GYN (809), ICU (807) |
| 11 | Age vs. length of stay | No consistent increase with age; younger adults show slightly higher LOS |
| 12 | Older patients and discharge destination | Older patients significantly more likely to discharge to rehab or skilled nursing |
| 13 | Most common diagnoses | Gastroenteritis (771), Type II Diabetes (737), UTI (734), Hypertension (708) |
| 14 | Diagnoses with longest LOS | LOS relatively uniform across diagnoses — systemic, not condition-driven |
| 15 | Primary bottleneck | Discharge planning — particularly for patients requiring post-acute care transitions |

**Week 5 — Power BI Dashboard**

A 2-page interactive Power BI dashboard was built directly from the Week 4 SQL queries:
- **Overview Page:** Admission trends, weekday patterns, admission type distribution,
  LOS by admission type, discharge disposition breakdown
- **Diagnosis Page:** Admissions and LOS by diagnosis, patient counts by shift,
  age group and department filters

---

## Dashboard Preview

### Overview Page
<img width="1221" height="685" alt="Overview" src="https://github.com/user-attachments/assets/6ec62c50-6ad0-4301-9f2e-62425f576c19" />


### Diagnosis Page
<img width="1224" height="682" alt="Diagnosis" src="https://github.com/user-attachments/assets/9763a702-d777-402f-be92-7c2015da66a1" />

---

## Results/Findings
1. Daily admissions are **stable but not predictable** — periodic surges above 20 admissions
   create intermittent pressure on staffing, triage, and bed availability
2. The average LOS of **4.03 days is nearly identical across all departments, diagnoses,
   and discharge outcomes** — suggesting LOS is driven by standardized processes,
   not clinical complexity
3. **Emergency admissions account for 55.1%** of all inflow, making hospital demand
   predominantly unplanned and reactive
4. **Urgent admissions carry the highest LOS (4.3 days)** despite being the smallest
   admission group — they disproportionately affect bed occupancy
5. **26% of patients require post-acute care** on discharge — this external dependency
   is the hospital's primary source of discharge delay and the main bottleneck in patient flow
6. **Admissions peak at 5 AM and 7–8 PM**, aligned with shift transitions rather than
   traditional daytime hours — current staffing schedules may not reflect actual demand
7. **Orthopedics and Pediatrics** experience the highest admission volumes and represent
   the most concentrated departmental pressure points

---

## Recommendations
1. Prioritize discharge planning reform — strengthen coordination with rehabilitation
   and skilled nursing facilities to reduce transition delays
2. Align staffing schedules with actual peak admission times (early morning and evening)
   rather than traditional shift patterns
3. Develop contingency protocols for high-volume surge days, particularly Sundays
   and Thursdays when admissions trend higher
4. Review urgent admission pathways to understand why this group consistently
   yields the longest stays despite lower volume
5. Monitor Orthopedics and Pediatrics capacity closely given their consistently
   elevated admission volumes

---

## Limitations
- Analysis covers a single operational database snapshot — longitudinal trends
  cannot be fully assessed
- LOS uniformity across all patient groups warrants clinical validation before
  using these findings for policy decisions
- Discharge disposition data reflects recorded outcomes only — actual transfer
  timelines to post-acute facilities are not captured in this dataset
- ICD-10 codes were not mapped to plain language diagnosis names in this dataset,
  limiting the interpretability of the diagnosis analysis for non-clinical audiences
- The team was unable to collaborate simultaneously on the Power BI dashboard
  due to Power BI Desktop's single-user limitation — dashboard was built by one
  team member with group input via review sessions
