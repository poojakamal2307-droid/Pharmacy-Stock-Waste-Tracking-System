# 💊 Pharmacy Stock & Waste Tracking System (SQL Project)

📌 **Database Name:** `pharmacys_trackers`

A SQL-based inventory and waste management system designed for pharmacies to track medicines, stock, expiration, suppliers, and business performance metrics.

---

## ✅ Project Objective

Develop a complete database system to:

- Track pharmacy stock in/out movement  
- Manage medicine expiration & wastage  
- Maintain supplier relationships  
- Generate business insights & alert reports  

---

## 🏥 Functional Requirements

### 1️⃣ Pharmacy Information Management
- Pharmacy name
- City & contact details

### 2️⃣ Medicine Inventory Management
- Brand name, generic name, category
- Selling price & batch-wise stock
- Expiry date tracking

### 3️⃣ Supplier Management
- Supplier name
- Phone number & location details

### 4️⃣ Stock-In (Purchases)
- Purchase quantity & pricing
- Auto-update stock upon purchase entry

### 5️⃣ Stock-Out (Sales)
- Auto stock deduction on sale
- Revenue calculation per transaction

### 6️⃣ Waste & Expiry Tracking
- Mark expired/damaged stock as waste
- Reduce physical stock
- Calculate financial loss

### 7️⃣ Reorder Alerts
- If stock < reorder level → flag as low stock

---

## 📊 Analytical KPIs Required

| KPI | Description |
|-----|-------------|
| Total Sales Revenue | Pharmacy wise sales summary |
| Total Waste Value | Reason wise (expired/damaged) loss |
| Low Stock Report | Stock less than reorder level |
| High Value Medicines | Top expensive items |
| Expired Stock List | Report for expired medicines |
| Category-wise Stock Value | Grouped inventory summary |

---

## 🧠 SQL Concepts to Implement

✅ Required SQL Features:

| SQL Feature | Usage |
|-------------|------|
| Primary & Foreign Keys | Data integrity |
| INSERT, UPDATE, DELETE | CRUD operations |
| SUM, AVG, COUNT, MIN, MAX | KPIs & summary calculations |
| GROUP BY + HAVING | Analytics |
| Subqueries | Complex reports |
| INNER & LEFT JOIN | Data relationships |
| VIEWS | Reporting access |
| STORED PROCEDURES | Stock update & wastage analysis |
| TRIGGERS | Automatic expiry/waste handling |
| INDEXES | Query performance improvement |

---

## 🚀 Outcome

✔ Pharmacy inventory and wastage managed efficiently  
✔ Real-time alerts for expiry and low-stock medicines  
✔ Automated business calculations & reporting  
✔ Demonstrates strong SQL development skills  

