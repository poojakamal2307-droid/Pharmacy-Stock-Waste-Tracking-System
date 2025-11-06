CREATE DATABASE IF NOT EXISTS pharmacys_trackers;
USE pharmacys_trackers;

-- Pharmacies
CREATE TABLE pharmacies (
  pharmacy_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  address VARCHAR(255),
  city VARCHAR(100),
  phone VARCHAR(30)
);

-- Suppliers
CREATE TABLE suppliers (
  supplier_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  contact_person VARCHAR(100),
  phone VARCHAR(30),
  email VARCHAR(100)
);

-- Medicines
CREATE TABLE medicines (
  medicine_id INT AUTO_INCREMENT PRIMARY KEY,
  generic_name VARCHAR(150) NOT NULL,
  brand_name VARCHAR(150),
  form VARCHAR(50),
  strength VARCHAR(50),
  category VARCHAR(100),
  unit_price DECIMAL(10,2)
);

-- Batches (Tracks expiry + quantity)
CREATE TABLE batches (
  batch_id INT AUTO_INCREMENT PRIMARY KEY,
  medicine_id INT NOT NULL,
  pharmacy_id INT NOT NULL,
  supplier_id INT,
  batch_number VARCHAR(100),
  manufacture_date DATE,
  expiry_date DATE,
  quantity INT NOT NULL,
  purchase_price DECIMAL(10,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id),
  FOREIGN KEY (pharmacy_id) REFERENCES pharmacies(pharmacy_id),
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Purchases
CREATE TABLE purchases (
  purchase_id INT AUTO_INCREMENT PRIMARY KEY,
  pharmacy_id INT NOT NULL,
  supplier_id INT,
  batch_id INT NOT NULL,
  purchase_date DATE,
  qty INT,
  total_cost DECIMAL(12,2),
  invoice_no VARCHAR(100),
  FOREIGN KEY (pharmacy_id) REFERENCES pharmacies(pharmacy_id),
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
  FOREIGN KEY (batch_id) REFERENCES batches(batch_id)
);

-- Sales
CREATE TABLE sales (
  sale_id INT AUTO_INCREMENT PRIMARY KEY,
  pharmacy_id INT NOT NULL,
  sale_date DATE,
  batch_id INT,
  medicine_id INT NOT NULL,
  qty INT,
  unit_price DECIMAL(10,2),
  total_amount DECIMAL(12,2),
  FOREIGN KEY (pharmacy_id) REFERENCES pharmacies(pharmacy_id),
  FOREIGN KEY (batch_id) REFERENCES batches(batch_id),
  FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- Wastages (expired/damaged)
CREATE TABLE wastages (
  wastage_id INT AUTO_INCREMENT PRIMARY KEY,
  pharmacy_id INT NOT NULL,
  batch_id INT,
  medicine_id INT NOT NULL,
  wastage_date DATE,
  qty INT,
  reason VARCHAR(255),
  cost_value DECIMAL(12,2),
  notes TEXT,
  FOREIGN KEY (pharmacy_id) REFERENCES pharmacies(pharmacy_id),
  FOREIGN KEY (batch_id) REFERENCES batches(batch_id),
  FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- Reorder levels
CREATE TABLE reorder_levels (
  reorder_id INT AUTO_INCREMENT PRIMARY KEY,
  pharmacy_id INT NOT NULL,
  medicine_id INT NOT NULL,
  min_qty INT NOT NULL DEFAULT 10,
  reorder_qty INT NOT NULL DEFAULT 50,
  FOREIGN KEY (pharmacy_id) REFERENCES pharmacies(pharmacy_id),
  FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- Pharmacies
INSERT INTO pharmacies (name, address, city, phone) VALUES
('GreenCare Pharmacy', '12 MG Road', 'Bengaluru', '080-99990000'),
('HealWell Pharmacy', '45 Park Street', 'Kolkata', '033-55551234'),
('MediPlus Pharmacy', '89 Anna Salai', 'Chennai', '044-67891234'),
('HealthFirst Pharmacy', '22 FC Road', 'Pune', '020-22446688'),
('LifeCare Pharmacy', '101 Sector 17', 'Chandigarh', '0172-5050505'),
('CityMeds Pharmacy', '56 Connaught Place', 'New Delhi', '011-45454545'),
('Wellness Pharma', '77 SG Highway', 'Ahmedabad', '079-66554433'),
('CarePoint Pharmacy', '18 Banjara Hills', 'Hyderabad', '040-60606060'),
('MediTrust Pharmacy', '90 Park Avenue', 'Mumbai', '022-78787878'),
('GoodHealth Pharmacy', '45 Gandhi Road', 'Coimbatore', '0422-3131313'),
('CureAll Pharmacy', '33 VIP Road', 'Guwahati', '0361-2525252'),
('PharmaWorld', '24 Hazratganj', 'Lucknow', '0522-2727272'),
('MedZone Pharmacy', '67 Lalbagh Road', 'Bengaluru', '080-12345678'),
('TotalCare Pharmacy', '81 Church Street', 'Mysuru', '0821-4545123'),
('LifeLine Pharmacy', '10 Teen Murti Marg', 'New Delhi', '011-23232323'),
('WellCare Pharmacy', '58 Marine Drive', 'Mumbai', '022-34343434'),
('TrustMeds Pharmacy', '21 Link Road', 'Nagpur', '0712-5656565'),
('Apollo Pharmacy', '11 Ring Road', 'Surat', '0261-2121212');

-- Suppliers
INSERT INTO suppliers (name, contact_person, phone, email) VALUES
('ABC Pharma Distributors','Ravi Kumar','9876543210','ravi@abcpharma.com'),
('Global Meds Ltd','Anita Singh','9123456789','anita@globalmeds.com'),
('MediSource Pvt Ltd','Kiran Patel','9812233445','kiran@medisource.in'),
('HealthLink Suppliers','Suresh Mehta','9922456781','suresh@healthlink.com'),
('Wellness Distributors','Priya Sharma','9876500012','priya@wellnessdist.com'),
('PharmaOne Traders','Manoj Verma','9654321098','manoj@pharmaone.in'),
('LifeLine Supplies','Deepa Reddy','9998765432','deepa@lifelinesupplies.com'),
('MediTrust Distributors','Rahul Iyer','9012345678','rahul@meditrust.co.in'),
('CureAll Healthcare','Amit Khanna','9821010101','amit@cureallhealth.com'),
('TrustCare Distributors','Sneha Joshi','9898989898','sneha@trustcare.in'),
('CityPharma Traders','Rajesh Nair','9777712345','rajesh@citypharma.com'),
('MedicoMart Ltd','Sunita Das','9001234567','sunita@medicomart.in'),
('BioGen Supplies','Harish Kapoor','9845123456','harish@biogensupplies.com'),
('Apollo Distributors','Neha Menon','9877001122','neha@apollodistributors.com'),
('Zenith Pharma Co','Anand Mishra','9765432189','anand@zenithpharma.in'),
('CarePlus Traders','Poonam Batra','9800456712','poonam@careplus.com'),
('WellMed Suppliers','Ajay Deshmukh','9822334455','ajay@wellmedsuppliers.com'),
('Prime Health Distributors','Lakshmi Rao','9888123456','lakshmi@primehealth.com');

-- Medicines
INSERT INTO medicines (generic_name, brand_name, form, strength, category, unit_price) VALUES
('Paracetamol','Cetadol','Tablet','500 mg','Analgesic',5.00),
('Amoxicillin','Amoxil','Capsule','500 mg','Antibiotic',12.00),
('Cetirizine','Cetzine','Tablet','10 mg','Antihistamine',6.50),
('Metformin','Glucoformin','Tablet','500 mg','Antidiabetic',8.00),
('Atorvastatin','Lipostat','Tablet','10 mg','Cardiac',20.00),
('Azithromycin','Azithral','Tablet','250 mg','Antibiotic',18.00),
('Ibuprofen','Brufen','Tablet','400 mg','Analgesic',7.00),
('Omeprazole','Omez','Capsule','20 mg','Antacid',9.50),
('Losartan','Losar','Tablet','50 mg','Antihypertensive',14.00),
('Glibenclamide','Daonil','Tablet','5 mg','Antidiabetic',6.00),
('Diclofenac','Voveran','Tablet','50 mg','Analgesic',8.50),
('Ranitidine','Zinetac','Tablet','150 mg','Antacid',5.50),
('Doxycycline','Doxylin','Capsule','100 mg','Antibiotic',10.00),
('Levocetirizine','Levocet','Tablet','5 mg','Antihistamine',6.00),
('Amlodipine','Amlong','Tablet','5 mg','Antihypertensive',9.00),
('Pantoprazole','Pantodac','Tablet','40 mg','Antacid',11.00),
('Insulin','Huminsulin','Injection','10 mL','Antidiabetic',250.00),
('Clopidogrel','Clopilet','Tablet','75 mg','Cardiac',22.00);

-- Batches
INSERT INTO batches (medicine_id, pharmacy_id, supplier_id, batch_number, manufacture_date, expiry_date, quantity, purchase_price) VALUES
(1,1,1,'P500-A1','2024-01-10','2026-03-15',200,2.50),
(1,1,1,'P500-A2','2023-08-01','2025-11-30',50,2.40),
(2,1,2,'AMX-2024-01','2024-02-05','2025-02-28',120,6.00),
(3,1,1,'CTZ-23B','2023-09-10','2024-11-10',30,3.00),
(4,2,2,'MTF-2023-09','2023-09-01','2025-09-01',100,4.00),
(5,2,1,'ATR-2022-07','2022-07-20','2024-10-15',25,10.00),
(2,2,2,'AMX-KOL-01','2024-03-10','2026-03-09',80,5.80),
(6,3,3,'AZT-2024-02','2024-02-15','2025-08-15',150,9.00),
(7,3,4,'IBU-2023-10','2023-10-01','2025-03-01',90,3.50),
(8,4,5,'OME-2024-04','2024-04-20','2026-04-20',200,5.00),
(9,4,6,'LOS-2023-05','2023-05-25','2025-05-25',75,7.00),
(10,5,7,'GLB-2023-08','2023-08-30','2025-07-30',60,3.20),
(11,5,8,'DCF-2023-11','2023-11-12','2025-11-11',150,4.20),
(12,6,9,'RAN-2023-07','2023-07-05','2025-06-30',80,2.80),
(13,7,10,'DOX-2024-01','2024-01-01','2026-01-01',70,5.50),
(14,8,11,'LCT-2023-12','2023-12-05','2025-12-05',110,3.10),
(15,9,12,'AML-2024-02','2024-02-15','2026-02-14',90,4.80),
(16,10,13,'PNT-2023-03','2023-03-10','2025-03-09',120,6.00);

-- Purchases
INSERT INTO purchases (pharmacy_id, supplier_id, batch_id, purchase_date, qty, total_cost, invoice_no) VALUES
(1,1,1,'2024-01-12',200,500.00,'INV-1001'),
(1,1,2,'2023-08-05',50,120.00,'INV-0823-11'),
(1,2,3,'2024-02-06',120,720.00,'INV-2003'),
(1,1,4,'2023-09-12',30,90.00,'INV-0930'),
(2,2,5,'2023-09-05',100,400.00,'INV-309'),
(2,1,6,'2022-07-25',25,250.00,'INV-7722'),
(2,2,7,'2024-03-15',80,464.00,'INV-315');

-- Sales
INSERT INTO sales (pharmacy_id, sale_date, batch_id, medicine_id, qty, unit_price, total_amount) VALUES
(1,'2024-05-10',1,1,10,5.00,50.00),
(1,'2024-06-01',3,2,8,12.00,96.00),
(1,'2024-08-20',2,1,5,5.00,25.00),
(1,'2024-09-15',4,3,6,6.50,39.00),
(2,'2024-04-05',5,4,12,8.00,96.00),
(2,'2024-08-30',6,5,3,20.00,60.00),
(2,'2024-09-20',7,2,10,12.00,120.00);

-- Wastages
INSERT INTO wastages (pharmacy_id, batch_id, medicine_id, wastage_date, qty, reason, cost_value, notes) VALUES
(1,2,1,'2024-12-01',10,'Near-expiry returned to supplier',24.00,'Partially returned'),
(1,4,3,'2024-11-20',5,'Expired',15.00,'Expired before sale'),
(2,6,5,'2024-10-20',8,'Expired',80.00,'Batch expired'),
(2,5,4,'2025-09-02',2,'Damaged',8.00,'Leaking bottles'),
(3,8,6,'2025-07-12',12,'Expired',108.00,'Stock not sold'),
(3,9,7,'2025-06-25',5,'Broken during transport',17.50,'Transport damage'),
(4,10,8,'2025-08-18',6,'Packaging defect',30.00,'Customer complaint'),
(4,11,9,'2025-07-10',4,'Expired',28.00,'Late stock clearance'),
(5,12,10,'2025-06-05',10,'Near-expiry returned to supplier',32.00,'Returned to distributor'),
(5,13,11,'2025-09-15',3,'Damaged',12.60,'Damaged during unloading'),
(6,14,12,'2025-04-28',8,'Expired',22.40,'Expired before audit'),
(6,15,13,'2025-03-30',6,'Near-expiry',33.00,'Cleared from shelf'),
(7,16,14,'2025-01-20',5,'Expired',15.50,'Not sold in time'),
(8,17,15,'2025-02-22',3,'Damaged',14.40,'Broken packaging'),
(9,18,16,'2025-05-18',4,'Expired',24.00,'Expired before return'),
(10,3,3,'2024-12-15',7,'Spillage',21.00,'Accidental spill in storage'),
(8,11,9,'2025-08-25',2,'Temperature damage',14.00,'Fridge malfunction'),
(7,9,7,'2025-07-30',4,'Near-expiry returned to supplier',14.00,'Stock returned');

-- Reorder Levels
INSERT INTO reorder_levels (pharmacy_id, medicine_id, min_qty, reorder_qty) VALUES
(1,1,30,100),
(1,2,20,100),
(1,3,20,50),
(2,4,40,150),
(2,5,10,50),
(2,2,15,80),
(3,6,25,120),
(3,7,20,100),
(3,8,30,150),
(4,9,15,60),
(4,10,10,50),
(5,11,20,100),
(5,12,25,120),
(6,13,15,70),
(6,14,10,40),
(7,15,20,90),
(8,16,25,110),
(9,1,30,100);

-- 1. View all medicines


SELECT * FROM medicines;

-- 2. View all pharmacies in a city
SELECT * FROM pharmacies WHERE city = 'Bengaluru';

-- 3. List all suppliers with email

SELECT name, contact_person, email FROM suppliers;

-- 4. Get all batches expiring this month

SELECT batch_number, expiry_date 
FROM batches
WHERE MONTH(expiry_date) = MONTH(CURDATE())
  AND YEAR(expiry_date) = YEAR(CURDATE());


-- 5. Count total medicines
SELECT COUNT(*) AS total_medicines FROM medicines;

-- 6. Total sales value per pharmacy
SELECT pharmacy_id, SUM(total_amount) AS total_sales
FROM sales
GROUP BY pharmacy_id;

-- 7. Average purchase cost by supplier
SELECT supplier_id, AVG(total_cost) AS avg_purchase
FROM purchases
GROUP BY supplier_id;

-- 8. Total wastage cost per reason
SELECT reason, SUM(cost_value) AS total_loss
FROM wastages
GROUP BY reason;


-- INNER JOIN: Get medicines with recorded waste
SELECT 
    m.generic_name AS Medicine_Name,
    m.category,
    w.reason AS waste_reason,
    w.qty AS quantity_wasted,
    w.wastage_date AS waste_date
FROM medicines m
JOIN wastages w ON m.medicine_id = w.medicine_id;

-- LEFT JOIN: Show all medicines and waste info (if any)
SELECT 
    m.generic_name,
    w.reason AS waste_reason,
    w.wastage_date AS waste_date
FROM medicines m
LEFT JOIN wastages w ON m.medicine_id = w.medicine_id;

-- Find medicines priced above the average unit price
SELECT 
    generic_name, brand_name, category, unit_price
FROM medicines
WHERE unit_price > (
    SELECT AVG(unit_price) FROM medicines
);

-- Find medicines that have any waste records due to expiry
SELECT generic_name, brand_name, category
FROM medicines m
WHERE EXISTS (
    SELECT 1
    FROM wastages w
    WHERE w.medicine_id = m.medicine_id
      AND w.reason = 'Expired'
);

-- Total quantity of medicines by category
SELECT 
    category,
    SUM(quantity) AS total_quantity
FROM batches b
JOIN medicines m ON b.medicine_id = m.medicine_id
GROUP BY category;

-- Categories having total stock more than 500
SELECT 
    category,
    SUM(quantity) AS total_quantity
FROM batches b
JOIN medicines m ON b.medicine_id = m.medicine_id
GROUP BY category
HAVING SUM(quantity) > 500;

-- Medicines with brand_name containing '500 mg'
SELECT * FROM medicines
WHERE strength LIKE '%500 mg%';

-- Medicines expiring between 2025 and 2026
SELECT m.*, b.expiry_date
FROM medicines m
JOIN batches b ON m.medicine_id = b.medicine_id
WHERE b.expiry_date BETWEEN '2025-01-01' AND '2026-12-31';

-- Filter medicines from specific cities
SELECT m.*, b.pharmacy_id
FROM medicines m
JOIN batches b ON m.medicine_id = b.medicine_id
JOIN pharmacies p ON b.pharmacy_id = p.pharmacy_id
WHERE p.city IN ('New Delhi', 'Mumbai', 'Chennai');

-- Average price of all medicines

SELECT AVG(unit_price) AS avg_price FROM medicines;

-- Total quantity wasted across all records
SELECT SUM(qty) AS total_waste FROM wastages;

-- Highest-priced medicine
SELECT 
    m.generic_name,
    SUM(b.quantity) AS total_quantity
FROM medicines m
JOIN batches b ON m.medicine_id = b.medicine_id
GROUP BY m.generic_name;

-- Count total medicines in each city
SELECT p.city AS pharmacy_city, COUNT(DISTINCT b.medicine_id) AS total_medicines
FROM batches b
JOIN pharmacies p ON b.pharmacy_id = p.pharmacy_id
GROUP BY p.city;

-- Combine all expired and damaged medicines
SELECT m.generic_name, w.reason
FROM medicines m
JOIN wastages w ON m.medicine_id = w.medicine_id
WHERE w.reason = 'Expired'
UNION
SELECT m.generic_name, w.reason
FROM medicines m
JOIN wastages w ON m.medicine_id = w.medicine_id
WHERE w.reason LIKE '%Damaged%';

-- Sort medicines by earliest expiry date
SELECT m.generic_name, b.expiry_date
FROM medicines m
JOIN batches b ON m.medicine_id = b.medicine_id
ORDER BY b.expiry_date ASC;

-- Filter medicines with low stock (less than 100)
SELECT m.generic_name, SUM(b.quantity) AS total_stock
FROM medicines m
JOIN batches b ON m.medicine_id = b.medicine_id
GROUP BY m.generic_name
HAVING total_stock < 100
ORDER BY total_stock ASC;

-- Get top 5 most expensive medicines
SELECT generic_name, unit_price
FROM medicines
ORDER BY unit_price DESC
LIMIT 5;

-- Total cost wasted by each pharmacy
SELECT 
    p.city AS pharmacy_city,
    SUM(w.qty * m.unit_price) AS total_cost_wasted
FROM wastages w
JOIN medicines m ON w.medicine_id = m.medicine_id
JOIN pharmacies p ON w.pharmacy_id = p.pharmacy_id
GROUP BY p.city
ORDER BY total_cost_wasted DESC;

-- Trigger

DELIMITER $$

CREATE TRIGGER Before_Expiry_Insert
AFTER INSERT ON batches
FOR EACH ROW
BEGIN
    IF NEW.expiry_date < CURDATE() THEN
        INSERT INTO wastages (medicine_id, pharmacy_id, wastage_date, qty, reason)
        VALUES (NEW.medicine_id, NEW.pharmacy_id, CURDATE(), NEW.quantity, 'Expired on Arrival');
    END IF;
END $$

DELIMITER $$

CREATE TRIGGER After_Waste_Insert
AFTER INSERT ON wastages
FOR EACH ROW
BEGIN
    UPDATE batches
    SET quantity = quantity - NEW.qty
    WHERE medicine_id = NEW.medicine_id AND pharmacy_id = NEW.pharmacy_id;
END $$

DELIMITER ;

-- Stored procedured
DELIMITER $$

CREATE PROCEDURE CheckAndInsertExpiredMedicines()
BEGIN
    INSERT INTO wastages (medicine_id, pharmacy_id, wastage_date, qty, reason)
    SELECT 
        b.medicine_id,
        b.pharmacy_id,
        CURDATE(),
        b.quantity,
        'Expired'
    FROM batches b
    WHERE b.expiry_date < CURDATE()
      AND NOT EXISTS (
          SELECT 1 
          FROM wastages w
          WHERE w.medicine_id = b.medicine_id
            AND w.pharmacy_id = b.pharmacy_id
            AND w.reason = 'Expired'
      );
END $$

DELIMITER $$

CREATE PROCEDURE UpdateMedicineStock(
    IN p_medicine_id INT,
    IN p_sold_quantity INT
)
BEGIN
    UPDATE batches
    SET quantity = quantity - p_sold_quantity
    WHERE medicine_id = p_medicine_id;
END $$


DELIMITER $$

CREATE PROCEDURE GetPharmacyWasteSummary()
BEGIN
    SELECT 
        p.city AS pharmacy_city,
        SUM(w.qty) AS total_waste_qty,
        SUM(w.qty * m.unit_price) AS total_waste_value
    FROM wastages w
    JOIN medicines m ON w.medicine_id = m.medicine_id
    JOIN pharmacies p ON w.pharmacy_id = p.pharmacy_id
    GROUP BY p.city
    ORDER BY total_waste_value DESC;
END $$

DELIMITER ;

call GetPharmacyWasteSummary();

CALL UpdateMedicineStock(101, 10);

-- Index on foreign keys
CREATE INDEX idx_batches_medicine_id ON batches(medicine_id);
CREATE INDEX idx_batches_pharmacy_id ON batches(pharmacy_id);
CREATE INDEX idx_batches_supplier_id ON batches(supplier_id);
SELECT * 
FROM batches b
JOIN medicines m ON b.medicine_id = m.medicine_id;



CREATE INDEX idx_purchases_pharmacy_id ON purchases(pharmacy_id);
CREATE INDEX idx_purchases_supplier_id ON purchases(supplier_id);
CREATE INDEX idx_purchases_batch_id ON purchases(batch_id);
SELECT * 
FROM purchases
WHERE supplier_id = 5;


CREATE INDEX idx_sales_pharmacy_id ON sales(pharmacy_id);
CREATE INDEX idx_sales_medicine_id ON sales(medicine_id);
CREATE INDEX idx_sales_batch_id ON sales(batch_id);
SELECT SUM(quantity) 
FROM sales
WHERE pharmacy_id = 3;



CREATE INDEX idx_wastages_pharmacy_id ON wastages(pharmacy_id);
CREATE INDEX idx_wastages_medicine_id ON wastages(medicine_id);
CREATE INDEX idx_wastages_batch_id ON wastages(batch_id);
SELECT * 
FROM wastages
WHERE pharmacy_id = 2;



CREATE INDEX idx_reorder_levels_pharmacy_id ON reorder_levels(pharmacy_id);
CREATE INDEX idx_reorder_levels_medicine_id ON reorder_levels(medicine_id);
SELECT * 
FROM reorder_levels
WHERE pharmacy_id = 1;

-- Optional: Index for queries filtering by expiry_date

CREATE INDEX idx_batches_expiry_date ON batches(expiry_date);
SELECT * 
FROM batches
WHERE expiry_date < CURRENT_DATE;

-- a) Medicines with Current Stock
CREATE VIEW v_medicine_stock AS
SELECT 
    m.generic_name,
    m.brand_name,
    m.category,
    SUM(b.quantity) AS total_stock,
    AVG(m.unit_price) AS unit_price
FROM medicines m
JOIN batches b ON m.medicine_id = b.medicine_id
GROUP BY m.medicine_id;

-- b) Expired Medicines
CREATE VIEW v_expired_medicines AS
SELECT 
    m.generic_name,
    m.brand_name,
    b.batch_number,
    b.expiry_date,
    b.quantity,
    p.name AS pharmacy_name,
    p.city AS pharmacy_city
FROM batches b
JOIN medicines m ON b.medicine_id = m.medicine_id
JOIN pharmacies p ON b.pharmacy_id = p.pharmacy_id
WHERE b.expiry_date < CURDATE();

-- c) Waste Summary by Pharmacy
CREATE VIEW v_pharmacy_waste AS
SELECT 
    p.name AS pharmacy_name,
    p.city AS pharmacy_city,
    SUM(w.qty) AS total_waste_qty,
    SUM(w.qty * m.unit_price) AS total_waste_value
FROM wastages w
JOIN medicines m ON w.medicine_id = m.medicine_id
JOIN pharmacies p ON w.pharmacy_id = p.pharmacy_id
GROUP BY p.pharmacy_id;

-- d) Top 5 Most Expensive Medicines
CREATE VIEW v_top_expensive_medicines AS
SELECT generic_name, brand_name, unit_price
FROM medicines
ORDER BY unit_price DESC
LIMIT 5;

-- e) Low Stock Medicines (Below Reorder Level)
CREATE VIEW v_low_stock_medicines AS
SELECT 
    m.generic_name,
    m.brand_name,
    p.name AS pharmacy_name,
    SUM(b.quantity) AS current_stock,
    r.min_qty
FROM medicines m
JOIN batches b ON m.medicine_id = b.medicine_id
JOIN pharmacies p ON b.pharmacy_id = p.pharmacy_id
JOIN reorder_levels r ON m.medicine_id = r.medicine_id AND p.pharmacy_id = r.pharmacy_id
GROUP BY m.medicine_id, p.pharmacy_id
HAVING current_stock < r.min_qty;



SELECT * FROM v_expired_medicines;
SELECT * FROM v_pharmacy_waste WHERE total_waste_value > 100;