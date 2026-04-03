# 🚗 Vehicle Data Intelligence & Validation Dashboard

## 📌 Project Overview
This project focuses on building a **data validation and business intelligence system** using SQL and Power BI. It identifies data quality issues, performs transformations, and delivers actionable insights through an interactive dashboard.

![Dashboard](https://github.com/ilurisriganesh/Vehicle-Data-Intelligence-Validation-Dashboard/blob/main/Vehicle%20data%20dashboard%20with%20city%20view.png)

---

## 🛠️ Tech Stack
- PostgreSQL (SQL)
- Power BI
- DAX
- Excel/CSV

---

## 🧱 Project Workflow

### 🔹 Step 1: Data Creation (SQL)
- Created vehicle dataset with attributes like:
  - brand, model, price, mileage, fuel type

### 🔹 Step 2: Data Validation (SQL View)
- Built validation logic using CASE statements

### 🔹 Step 3: Data Cleaning (Power BI + DAX)
- Converted text values like 'NULL' to blanks
- Created clean numeric columns

### 🔹 Step 4: KPI Development
- Avg Vehicle Price
- Total Vehicles
- Total Errors
- Error %

### 🔹 Step 5: Dashboard Creation
- Interactive visuals
- Data quality monitoring
- Business insights
  
---
# Vehicle-Data-Intelligence-Validation-Dashboard

"Focused on SQL-based vehicle data validation and analysis"

## Project Overview

**Project Title**: Vehicle-Data-Intelligence-Validation-Dashboard
**Level**: Intermediate
This project demonstrates the implementation of a vehicle data intelligence and validation dashboard using MySQL. It includes creating and managing vehicle data tables, performing CRUD operations, data validation, and generating business insights. The goal is to showcase skills in database design, validation, and analysis.

## Objectives

1. **Set up Vehicle Data Database**: Create and populate the database with tables for vehicle details.
2. **Data Validation**: Identify and fix issues such as invalid mileage, negative price, and missing fuel type.
3. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on vehicle data.
4. **Business Insights**: Generate insights like average price by brand or vehicle type, fuel type distribution, and top mileage vehicles.
5. **Error Summary Dashboard**: Build a validation report to quickly identify data issues.

## Project Structure

### 1. Database Setup

```sql
-- STEP 1: Create Database
CREATE DATABASE vehicle_project;

-- STEP 2: Create Table
CREATE TABLE vehicle_data (
    vehicle_id INT PRIMARY KEY,
    brand VARCHAR(50),
    model VARCHAR(50),
    year INT,
    fuel_type VARCHAR(20),
    engine_cc INT,
    mileage_kmpl DECIMAL(5,2),
    price_lakh DECIMAL(10,2),
    transmission VARCHAR(20),
    vehicle_type VARCHAR(20),
    country VARCHAR(50)
);

-- STEP 3: Insert Data
INSERT INTO vehicle_data VALUES
(1,'Toyota','Fortuner',2022,'Diesel',2755,10.5,35.0,'Automatic','SUV','India'),
(2,'Hyundai','i20',2021,'Petrol',1197,20.0,8.5,'Manual','Hatchback','India'),
(3,'Honda','City',2020,'Petrol',1498,18.4,12.0,'Automatic','Sedan','India'),
(4,'Tesla','Model 3',2023,'Electric',0,0,60.0,'Automatic','Sedan','USA'),
(5,'Ford','EcoSport',2019,'Diesel',1498,22.5,9.0,'Manual','SUV','India'),
(6,'BMW','X5',2022,'Petrol',2998,12.0,75.0,'Automatic','SUV','Germany'),
(7,'Maruti','Swift',2021,'Petrol',1197,23.0,6.5,'Manual','Hatchback','India'),
(8,'Audi','A6',2023,'Petrol',1984,14.0,65.0,'Automatic','Sedan','Germany'),
(9,'Kia','Seltos',2022,'Diesel',1493,19.0,15.0,'Manual','SUV','India'),
(10,'Mahindra','Thar',2023,'Diesel',2184,15.2,14.0,'Manual','SUV','India'),
(11,'Hyundai','Creta',2022,'Petrol',1497,17.0,13.5,'Automatic','SUV','India'),
(12,'Toyota','Glanza',2021,'Petrol',1197,22.3,7.5,'Manual','Hatchback','India'),
(13,'Honda','Amaze',2020,'Diesel',1498,24.7,8.0,'Manual','Sedan','India'),
(14,'FakeBrand','X',2022,'Petrol',1500,150.0,-5.0,'Manual','SUV','India'),
(15,'Unknown','Y',2021,NULL,1200,NULL,10.0,'Manual','Sedan','India');

-- STEP 4: View Data
SELECT * FROM vehicle_data;
```

### 2. Basic Queries

```sql
-- Select all SUVs
SELECT * FROM vehicle_data WHERE vehicle_type = 'SUV';

-- Average price by brand
SELECT brand, AVG(price_lakh) AS avg_price FROM vehicle_data GROUP BY brand;

-- Top 5 expensive vehicles
SELECT * FROM vehicle_data ORDER BY price_lakh DESC LIMIT 5;
```

### 3. Data Validation Queries

```sql
-- Invalid mileage
SELECT * FROM vehicle_data WHERE mileage_kmpl > 50 OR mileage_kmpl IS NULL;

-- Negative price
SELECT * FROM vehicle_data WHERE price_lakh < 0;

-- Missing fuel type
SELECT * FROM vehicle_data WHERE fuel_type IS NULL;
```

### 4. Validation View & Error Summary

```sql
CREATE VIEW vehicle_data_validation AS
SELECT
    vehicle_id, brand, model,
    CASE WHEN mileage_kmpl IS NULL OR mileage_kmpl > 50 THEN 'Invalid Mileage' ELSE 'OK' END AS mileage_check,
    CASE WHEN price_lakh < 0 THEN 'Invalid Price' ELSE 'OK' END AS price_check,
    CASE WHEN fuel_type IS NULL THEN 'Missing Fuel Type' ELSE 'OK' END AS fuel_check
FROM vehicle_data;

SELECT * FROM vehicle_data_validation;

-- Error summary
SELECT mileage_check, price_check, fuel_check, COUNT(*) AS total_issues
FROM vehicle_data_validation
GROUP BY mileage_check, price_check, fuel_check;
```

### 5. Cleaning Data

```sql
-- Fix negative price
UPDATE vehicle_data SET price_lakh = NULL WHERE price_lakh < 0;

-- Fix invalid mileage
UPDATE vehicle_data SET mileage_kmpl = NULL WHERE mileage_kmpl > 50;
```

### 6. Business Insights

```sql
-- Average price by vehicle type
SELECT vehicle_type, AVG(price_lakh) AS avg_price FROM vehicle_data GROUP BY vehicle_type;

-- Fuel type distribution
SELECT fuel_type, COUNT(*) FROM vehicle_data GROUP BY fuel_type;

-- Best mileage cars
SELECT brand, model, mileage_kmpl FROM vehicle_data ORDER BY mileage_kmpl DESC;

-- Count by vehicle type
SELECT vehicle_type, COUNT(*) AS total FROM vehicle_data GROUP BY vehicle_type;
```

### 7. Duplicate Detection

```sql
SELECT brand, model, COUNT(*) FROM vehicle_data GROUP BY brand, model HAVING COUNT(*) > 1;
```

## Mistakes Solved

1. Invalid mileage values > 50 were set to NULL.
2. Negative price values were corrected to NULL.
3. Missing fuel types were identified.
4. Validation dashboard created to track data issues.

## Power BI Insights

* Connect MySQL vehicle database to Power BI.
* Visualize average price by brand and vehicle type.
* Highlight vehicles with invalid data.
* Build dashboards for SUV counts, fuel type distribution, and mileage comparisons.

---

## 📊 Key KPIs
- Average Vehicle Price
- Total Vehicles
- Error Count
- Error %
- Data Status (Clean / Needs Attention / Critical)

---

## 📈 Insights
- Identified data inconsistencies
- Highlighted error-prone records
- Enabled decision-making using clean data

---

## 🚀 Conclusion
This project demonstrates **end-to-end data operations**, including SQL processing, data validation, and Power BI reporting.

