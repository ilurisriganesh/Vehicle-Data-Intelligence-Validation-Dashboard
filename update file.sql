
---STEP 1: Create Database
CREATE DATABASE vehicle_project;

----STEP 2: Create Table
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
-----STEP 3: Insert Data

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

----STEP 4: View Data
SELECT * FROM vehicle_data;

-----STEP 5: Basic Queries
--select All SUVs
SELECT * FROM vehicle_data
WHERE vehicle_type = 'SUV';

-----Average price by brand
SELECT brand, AVG(price_lakh) AS avg_price
FROM vehicle_data
GROUP BY brand;
-----Top 5 expensive vehicles
SELECT * FROM vehicle_data
ORDER BY price_lakh DESC
LIMIT 5;

---STEP 6: Data Validation Queries

---Invalid mileage
SELECT * FROM vehicle_data
WHERE mileage_kmpl > 50 OR mileage_kmpl IS NULL;

---Negative price
SELECT * FROM vehicle_data
WHERE price_lakh < 0;

---Missing fuel type
SELECT * FROM vehicle_data
WHERE fuel_type IS NULL;

---STEP 7: Insight Queries

--Best mileage cars
SELECT brand, model, mileage_kmpl
FROM vehicle_data
ORDER BY mileage_kmpl DESC;

---Count by vehicle type
SELECT vehicle_type, COUNT(*) AS total
FROM vehicle_data
GROUP BY vehicle_type;

---STEP 8: Build Data Validation System

---Instead of just finding errors, we’ll create a validation report system
---Create a Validation View
CREATE VIEW vehicle_data_validation AS
SELECT 
    vehicle_id,
    brand,
    model,
    
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

---View Validation Results
SELECT * FROM vehicle_data_validation;

---STEP 9: Error Summary Dashboard Query
SELECT 
    mileage_check,
    price_check,
    fuel_check,
    COUNT(*) AS total_issues
FROM vehicle_data_validation
GROUP BY mileage_check, price_check, fuel_check;

---STEP 10: Clean Data (Fix Errors)

--Fix negative price
UPDATE vehicle_data
SET price_lakh = NULL
WHERE price_lakh < 0;

---Fix invalid mileage
UPDATE vehicle_data
SET mileage_kmpl = NULL
WHERE mileage_kmpl > 50;

---STEP 11: Create Business Insights

--Average price by vehicle type
SELECT vehicle_type, AVG(price_lakh) AS avg_price
FROM vehicle_data
GROUP BY vehicle_type;

--Fuel type distribution
SELECT fuel_type, COUNT(*) 
FROM vehicle_data
GROUP BY fuel_type;

---STEP 12: Export to Excel
SELECT * FROM vehicle_data;

----Detect duplicate entries
SELECT brand, model, COUNT(*) 
FROM vehicle_data
GROUP BY brand, model
HAVING COUNT(*) > 1;
---view
SELECT table_name 
FROM information_schema.views 
WHERE table_schema = 'public';

--- recreating view
CREATE VIEW vehicle_data_validation AS
SELECT 
    vehicle_id,
    brand,
    model,
    
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
-----
SELECT * FROM vehicle_data_validation;




