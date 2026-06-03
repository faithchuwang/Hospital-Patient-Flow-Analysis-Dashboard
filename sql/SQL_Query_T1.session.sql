--creation of tables

-- Create Patients table
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,  
    age INT,                     
    sex VARCHAR(10)              
);

-- Create Admissions table
CREATE TABLE admissions (
    admission_id INT PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    admission_datetime TIMESTAMP,
    discharge_datetime TIMESTAMP,
    admission_type VARCHAR(50),
    department VARCHAR(100),
    discharge_disposition VARCHAR(50)
);

-- Create Diagnosis table
CREATE TABLE diagnosis (
    diagnosis_id INT PRIMARY KEY,
    admission_id INT REFERENCES admissions(admission_id),
    icd10_code VARCHAR(10)
);

--data was imported using postgres' import function

--confirming data import
SELECT *
    FROM admissions;

SELECT *
    FROM diagnosis;

SELECT *
    FROM patients;
--all clear!

--1.How many patients are admitted to the hospital each day? 

--in date order
SELECT 
    DATE (admission_datetime) admission_day,
    Count (patient_id) no_of_admission
FROM admissions
GROUP BY admission_day
ORDER BY admission_day ASC;

--2.What is the overall average length of stay (LOS) for admitted patients?
--discharge - admission as los

--using epoch to get results in hours or days instead of intervals

SELECT
    avg (discharge_datetime - admission_datetime) avg_los_interval,
    ROUND(AVG(EXTRACT(EPOCH FROM (discharge_datetime - admission_datetime))/86400),2) AS avg_los_days,
    ROUND(AVG(EXTRACT(EPOCH FROM (discharge_datetime - admission_datetime))/3600),2) AS avg_los_hours
FROM admissions; 

--3.How does average length of stay vary by department?
--average los by group by dept 

SELECT
    department,
    ROUND(AVG(EXTRACT(EPOCH FROM (discharge_datetime - admission_datetime))/86400),2) AS avg_los_days
FROM admissions
GROUP BY department
ORDER BY avg_los_days;

--4.How are admissions distributed by admission type ?
--count admission_id, group by admission type

SELECT 
    admission_type,
    COUNT(*) AS admission_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM admissions
GROUP BY admission_type
ORDER BY admission_count DESC;

--5.Which admission type is associated with the longest average length of stay?
--average los, group by admission type, desc order

SELECT
   admission_type,
   ROUND(AVG(EXTRACT(EPOCH FROM (discharge_datetime - admission_datetime))/86400),2) AS avg_los_days
FROM admissions
GROUP BY admission_type
ORDER BY avg_los_days DESC
LIMIT 1; 

--6.How do discharge dispositions break down across all admissions? 
--count admissions_id, group by discharge disposition

SELECT
    discharge_disposition,
    Count(admission_id) admission_count,
    ROUND(COUNT(admission_id) * 100.00 / (SELECT COUNT(*) FROM admissions),2) percentage
FROM admissions
GROUP BY discharge_disposition
ORDER BY admission_count;

--7.Do certain discharge dispositions correspond to longer hospital stays?
--average los by discharge disposition

SELECT
    discharge_disposition,
    ROUND(AVG(EXTRACT(EPOCH FROM (discharge_datetime - admission_datetime))/86400),2) AS avg_los_days
FROM admissions
GROUP BY discharge_disposition
ORDER BY avg_los_days;

--8. At what hours of the day do most admissions occur?
--admissions_id count by extract (Hour from datetime)

SELECT
    EXTRACT(HOUR FROM admission_datetime) Hour_of_day,
    COUNT(admission_id) admission_count   
FROM admissions
GROUP BY Hour_of_day
ORDER BY admission_count DESC;

--9. Are there specific days of the week with consistently higher admissions?(DOW: 0= Sunday, 6 = Saturday)
--count admissions_id by group by dow

SELECT
    EXTRACT(DOW FROM admission_datetime) week_day,
    TO_CHAR (admission_datetime, 'Day') day_name,
    COUNT(admission_id) admission_count
FROM admissions
GROUP BY week_day, day_name
ORDER BY admission_count DESC;

--10.Which departments experience the highest admission volume? (Top 5 is sufficient so that the signal isn’t weakened)
--count admission_id, group by dept, order by admission count, limit 5

SELECT
    department,
    COUNT(admission_id) admission_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM admissions
GROUP BY department
ORDER BY admission_count DESC
LIMIT 5;

--11. How does patient age relate to length of stay? (Should I give you hint 🤔?)
--create age bins, select age bins, group by average los

SELECT 
     CASE 
        WHEN p.age IS NULL THEN 'Unknown'
        WHEN p.age < 18 THEN 'Pediatrics'
        WHEN age BETWEEN 18 AND 34 THEN 'Young Adult'
        WHEN age BETWEEN 35 AND 59 THEN 'Adult'
        ELSE '60+ (Older)'
    END AS age_group,
    ROUND(AVG(EXTRACT(EPOCH FROM (discharge_datetime - admission_datetime))/86400),2) AS avg_los_days
FROM admissions a
JOIN patients p ON p.patient_id = a.patient_id
GROUP BY age_group
ORDER BY age_group, avg_los_days DESC;

--12 Are older patients more likely to be discharged to rehab or skilled nursing?
--select age bins, where in age > 60, group by discharge disposition

--disposition for old in comparison with other age groups
SELECT 
    CASE 
        WHEN p.age IS NULL THEN 'Unknown'
        WHEN p.age < 18 THEN 'Pediatrics'
        WHEN age BETWEEN 18 AND 34 THEN 'Young Adult'
        WHEN age BETWEEN 35 AND 59 THEN 'Adult'
        ELSE '60+ (Older)'
    END AS age_group,
    a.discharge_disposition,
    COUNT(p.patient_id) AS patient_count
FROM admissions a
JOIN patients p ON p.patient_id = a.patient_id
WHERE discharge_disposition IN ('Skilled Nursing', 'Rehab') AND p.age > 60
GROUP BY age_group, a.discharge_disposition
ORDER BY age_group, patient_count DESC;

--13. Which diagnoses are most commonly associated with hospital admissions?
--count admission_id, group by icd code, order desc

--with icd meaning
SELECT
    CASE 
        WHEN d.icd10_code = 'O80' THEN 'Normal delivery'
        WHEN d.icd10_code = 'E11' THEN 'Type II Diabetes'
        WHEN d.icd10_code = 'I10' THEN 'Hypertension'
        WHEN d.icd10_code = 'K35' THEN 'Appendicitis'
        WHEN d.icd10_code = 'N39' THEN 'UTI'
        WHEN d.icd10_code = 'J18' THEN 'Pneumonia'
        WHEN d.icd10_code = 'A09' THEN 'Gastroenteritis'
        ELSE 'Other'
    END AS diagnosis_name,
    COUNT(a.admission_id) patient_count,
    d.icd10_code
FROM admissions a
JOIN diagnosis d ON a.admission_id = d.admission_id
GROUP BY d.icd10_code
ORDER BY patient_count;

--14. Do certain diagnoses result in longer average hospital stays?
--average los, group by icd diagnosis

--with icd meanings
SELECT
    d.icd10_code,
    CASE 
        WHEN d.icd10_code = 'O80' THEN 'Normal delivery'
        WHEN d.icd10_code = 'E11' THEN 'Type II Diabetes'
        WHEN d.icd10_code = 'I10' THEN 'Hypertension'
        WHEN d.icd10_code = 'K35' THEN 'Appendicitis'
        WHEN d.icd10_code = 'N39' THEN 'UTI'
        WHEN d.icd10_code = 'J18' THEN 'Pneumonia'
        WHEN d.icd10_code = 'A09' THEN 'Gastroenteritis'
        ELSE 'Other'
    END AS diagnosis_name,
    ROUND(AVG(EXTRACT(EPOCH FROM (discharge_datetime - admission_datetime))/86400),2) AS avg_los_days
FROM admissions a
JOIN diagnosis d  ON a.admission_id = d.admission_id
GROUP BY d.icd10_code
ORDER BY avg_los_days;
