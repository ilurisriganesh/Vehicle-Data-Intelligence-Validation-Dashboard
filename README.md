# 🚗 Vehicle Data Intelligence & Validation Dashboard

## 📌 Project Overview

This project implements an end-to-end **data validation and business intelligence pipeline** using SQL and Power BI. It focuses on identifying data quality issues, performing data transformations, and delivering actionable insights through an interactive dashboard.

![Dashboard](https://github.com/ilurisriganesh/Vehicle-Data-Intelligence-Validation-Dashboard/blob/main/Vehicle%20data%20dashboard%20with%20city%20view.png)

---

## 🛠️ Tech Stack

* **Database:** PostgreSQL / MySQL
* **Visualization:** Power BI
* **Languages:** SQL, DAX
* **Tools:** Excel (CSV), GitHub

---

## 🧱 Architecture & Workflow

### 🔹 1. Data Ingestion & Schema Design

* Designed a structured relational schema for vehicle attributes
* Created and populated tables with multi-dimensional data (brand, price, mileage, fuel type, etc.)

### 🔹 2. Data Validation Layer (SQL)

* Implemented validation logic using `CASE` statements
* Built a reusable **validation view** to flag data quality issues:

  * Invalid mileage
  * Negative pricing
  * Missing fuel types

### 🔹 3. Data Cleaning & Transformation (Power BI)

* Addressed data type inconsistencies (Text → Numeric)
* Handled invalid entries such as `"NULL"` and blank values
* Created derived columns using DAX for clean analytical modeling

### 🔹 4. KPI Engineering

* Developed business-critical KPIs:

  * Average Vehicle Price
  * Total Vehicles
  * Total Errors
  * Error Percentage
  * Data Quality Status

### 🔹 5. Visualization & Dashboarding

* Built an interactive dashboard for:

  * Data quality monitoring
  * Business insights generation
  * Stakeholder-friendly reporting

---

## 🗄️ Database Implementation

### 📍 Database & Table Creation

```sql
CREATE DATABASE vehicle_project;

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
```

### 📍 Sample Data Insertion

```sql
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
```

---

## 🔍 Data Validation Layer

### 📍 Validation View

```sql
CREATE VIEW vehicle_data_validation AS
SELECT
    vehicle_id, brand, model,
    CASE 
        WHEN mileage_kmpl IS NULL OR mileage_kmpl > 50 THEN 'Invalid Mileage' 
        ELSE 'OK' 
    END AS mileage_check,
    CASE 
        WHEN price_lakh < 0 THEN 'Invalid Price' 
        ELSE 'OK' 
    END AS price_check,
    CASE 
        WHEN fuel_type IS NULL THEN 'Missing Fuel Type' 
        ELSE 'OK' 
    END AS fuel_check
FROM vehicle_data;
```

### 📍 Error Aggregation

```sql
SELECT mileage_check, price_check, fuel_check, COUNT(*) AS total_issues
FROM vehicle_data_validation
GROUP BY mileage_check, price_check, fuel_check;
```

---

## 🧹 Data Cleaning (SQL Layer)

```sql
UPDATE vehicle_data 
SET price_lakh = NULL 
WHERE price_lakh < 0;

UPDATE vehicle_data 
SET mileage_kmpl = NULL 
WHERE mileage_kmpl > 50;
```

---

## 📊 Power BI – Data Modeling & KPIs

### 📍 Data Cleaning (DAX)

```DAX
Clean Price = 
VAR val = TRIM(vehicle_data[price_lakh])
RETURN
IF(
    val = "NULL" || val = "",
    BLANK(),
    VALUE(val)
)
```

### 📍 KPI Measures

```DAX
Avg Vehicle Price = AVERAGE(vehicle_data[Clean Price])

Total Vehicles = COUNT(vehicle_data[vehicle_id])

Total Errors = 
COUNTROWS(
    FILTER(
        'data validation table',
        'data validation table'[price_check] <> "OK" ||
        'data validation table'[mileage_check] <> "OK" ||
        'data validation table'[fuel_check] <> "OK"
    )
)

Error % = DIVIDE([Total Errors], COUNTROWS('data validation table'), 0)

Data Status = 
IF(
    [Error %] > 0.3, "🔴 Critical",
    IF(
        [Error %] > 0.1, "🟡 Needs Attention",
        "🟢 Clean Data"
    )
)
```

---

## 📈 Dashboard Design

### 🔹 KPI Layer

* Average Vehicle Price
* Total Vehicles
* Total Errors
* Error Percentage
* Data Quality Status

### 🔹 Visualizations

* Vehicle Type Distribution (Bar Chart)
* Fuel Type Distribution (Pie Chart)
* Average Price by Brand
* Data Validation Table with Conditional Formatting

### 🔹 Features

* Interactive slicers (Vehicle Type, Brand, Fuel Type)
* Conditional formatting (Error highlighting)
* Clean automotive-themed UI

---

## ⚠️ Errors Encountered & Resolutions

| Issue                           | Root Cause                     | Resolution                                  |
| ------------------------------- | ------------------------------ | ------------------------------------------- |
| Cannot convert 'NULL' to number | Text-based "NULL" values       | DAX cleaning using `TRIM + VALUE + BLANK()` |
| AVERAGE function failure        | Non-numeric column type        | Created numeric derived column              |
| Table not found                 | Incorrect table/view reference | Verified schema and reloaded dataset        |
| Incorrect KPI status            | Threshold mismatch             | Adjusted logic and validated % format       |
| SQL syntax error                | MySQL vs PostgreSQL mismatch   | Used `information_schema` queries           |

---

## 💡 Key Learnings

* Importance of **data type consistency in analytics pipelines**
* Real-world handling of **dirty and inconsistent datasets**
* Designing scalable **data validation frameworks**
* Building **business-ready dashboards with actionable insights**

---

## 🚀 Conclusion

This project demonstrates a production-style workflow combining **data engineering, validation, and business intelligence**. It highlights the critical role of clean data in enabling accurate analytics and decision-making.

---
