# Hospital Patient Flow Analysis & Dashboard

## Project Overview

This project analyzes hospital patient flow data to identify operational bottlenecks affecting patient throughput, discharge efficiency, and hospital capacity management. Using SQL, PostgreSQL, and Power BI, the analysis investigates admission trends, length of stay (LOS), discharge pathways, department workload, and timing patterns to uncover where congestion occurs within the hospital system.

The project was completed as part of a healthcare operational analytics case study focused on transforming raw hospital data into actionable insights for leadership decision-making.

---

# Business Problem

Hospital leadership observed signs of patient flow inefficiency, including overcrowding, prolonged stays, and discharge delays. The objective of this analysis was to determine:

* Where patient pressure enters the hospital
* Which departments experience the highest strain
* What factors contribute to prolonged bed occupancy
* Where the primary operational bottleneck exists
* How patient flow patterns impact hospital capacity

---

# Tools & Technologies

* PostgreSQL
* SQL
* VS Code
* pgAdmin
* Power BI
* Excel / Power Query

---

# Dataset Structure

The project uses three relational hospital operational tables:

## patients

* patient_id
* age
* sex

## admissions

* admission_id
* patient_id
* admission_datetime
* discharge_datetime
* admission_type
* department
* discharge_disposition

## diagnosis

* diagnosis_id
* admission_id
* icd10_code

---

# Key Business Questions

The analysis explored:

1. Daily patient admission trends
2. Average length of stay (LOS)
3. LOS variation by department
4. Admission type distribution
5. Admission types associated with longest LOS
6. Discharge disposition breakdown
7. Relationship between discharge type and LOS
8. Peak admission hours
9. Day-of-week admission trends
10. Departments with highest admission volume
11. Relationship between age and LOS
12. Whether older patients are more likely to require rehab/skilled nursing
13. Most common diagnoses associated with admissions
14. Diagnoses linked to longer hospital stays
15. Identification of the hospital's primary patient flow bottleneck

---

# Key Findings

* Emergency admissions accounted for the majority of hospital inflow, creating continuous operational pressure.
* Patient admissions followed a bi-modal timing pattern, with peak pressure occurring during early morning and evening periods.
* Average length of stay remained relatively consistent across departments, diagnoses, and age groups.
* Orthopedics, Pediatrics, Surgery, OB/GYN, and ICU handled the highest admission volumes.
* Older patients were significantly more likely to require discharge to rehabilitation or skilled nursing facilities.
* The strongest operational bottleneck was identified at the discharge stage rather than during treatment.

---

# Main Bottleneck Identified

The analysis revealed that the hospital's biggest patient flow bottleneck occurs during discharge transitions to post-acute care facilities such as rehabilitation and skilled nursing centers.

While the hospital manages high and steady patient inflow effectively, delays in discharge coordination reduce bed turnover and create sustained congestion across departments. The bottleneck is therefore driven more by operational workflow inefficiencies and external discharge dependencies than by clinical complexity itself.

---

# Dashboard & Storytelling

The SQL analysis was translated into a Power BI dashboard designed for non-technical hospital leadership.

Dashboard sections include:

* Patient Inflow Overview
* Admission Type Analysis
* Length of Stay Analysis
* Discharge Outcomes
* Timing & Peak Pressure
* Bottleneck Synthesis

---

# Repository Structure

```text
hospital-patient-flow-analysis/
│
├── README.md
├── SQL_Query_T1.session.sql
├── Query_output_T1.xlsx
├── Insights.pdf
├── Team_1 Report.pdf
├── Hospital_Patient_Flow.pbix
│
├── images/
│   ├── dashboard.png
│   ├── admission_analysis.png
│   └── los_analysis.png
│
└── docs/
    └── project_brief.pdf
```

---

# Author

Healthcare Data Analysis Team 1

---

# Project St
