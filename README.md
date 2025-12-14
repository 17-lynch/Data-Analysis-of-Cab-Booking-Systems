# 🚕 Cab Booking System – SQL Database Project

## 📌 Project Overview

The **Cab Booking System** is a database design and analysis project created using **SQL** to replicate the backend data structure of real-world ride-hailing platforms such as **Uber and Ola**.

This project focuses on how data is structured, related, and analyzed in a transactional system.  
Instead of only writing queries, the main goal of this project is to demonstrate **database design thinking, normalization, and business-driven problem solving**, which are critical skills for a **Data Analyst / Data Engineer role**.

---

## 🎯 Project Objectives

- Design a scalable and normalized relational database  
- Handle real-world cab booking scenarios:
  - Customer ride requests  
  - Driver assignment  
  - Trip completion & cancellation  
  - Payment tracking  
- Maintain data integrity using proper relationships  
- Enable analytical reporting for business decision-making  

---

## 🧠 Project Design Approach (How We Built It)

### Step 1️⃣ Understanding the Business Flow

Before creating tables, the real-world flow of a cab booking system was analyzed:

- A customer requests a ride  
- A cab with a driver is assigned  
- The ride has:
  - Pickup location  
  - Drop location  
  - Fare  
  - Status (Completed / Cancelled)  
- A payment is made using a specific payment mode  

This understanding helped in identifying **entities and relationships**.

---

### Step 2️⃣ Identifying Core Entities

Based on the business flow, the following entities were finalized:

- Customers  
- Drivers  
- Cabs  
- Locations  
- Bookings (Trips)  
- Payments  

Each entity was separated into its own table to avoid redundancy and ensure clean data storage.

---

### Step 3️⃣ Database Normalization

The database was designed following normalization principles:

- Removed duplicate data (e.g., driver details stored only once)  
- Used foreign keys instead of repeating information  
- Ensured:
  - One customer → multiple bookings  
  - One driver → multiple trips  
  - One booking → one payment  

This helped in:
- Reducing data inconsistency  
- Improving query performance  
- Making the database scalable  

---

### Step 4️⃣ Defining Relationships

Relationships were carefully planned using **Primary Keys and Foreign Keys**:

- Customers → Bookings (One-to-Many)  
- Drivers → Cabs → Bookings  
- Locations → Bookings (Pickup & Drop)  
- Bookings → Payments (One-to-One)  

This structure ensures **referential integrity**, meaning no booking can exist without a valid customer, cab, or location.

---

## 🏗️ Database Architecture

### 🔹 High-Level Structure

- **Customers** store user details  
- **Drivers & Cabs** store supply-side data  
- **Bookings** act as the central transactional table  
- **Payments** store financial information  
- **Locations** standardize city and area names  

This architecture mirrors real production systems used in ride-sharing platforms.

---

## ⚠️ Challenges Faced & How We Solved Them

### 🚧 1. Designing Proper Relationships

**Challenge:**  
Initially, there was confusion about where driver and cab details should be stored.

**Solution:**  
Drivers and cabs were separated into different tables and linked using foreign keys.

This allowed:
- One driver to change cabs  
- Easy tracking of driver performance  

---

### 🚧 2. Avoiding Data Redundancy

**Challenge:**  
Repeating customer and location details in every booking would increase redundancy.

**Solution:**  
Created separate tables for customers and locations and referenced them using IDs.

This reduced storage and ensured consistency.

---

### 🚧 3. Handling Cancelled vs Completed Rides

**Challenge:**  
Cancellations are common in real-world systems and must be tracked.

**Solution:**  
Added a status field in the bookings table to clearly differentiate:
- Completed rides  
- Cancelled rides  

This enables accurate revenue and performance analysis.

---

### 🚧 4. Payment Tracking

**Challenge:**  
Not every booking may result in a successful payment.

**Solution:**  
Payment data was stored in a separate table with a payment status, allowing:
- Failed payments tracking  
- Payment mode analysis  
- Financial reconciliation  

---

## 📊 Business Use-Cases Supported

This database design supports analysis such as:

- Customer ride frequency  
- Driver workload analysis  
- Revenue tracking  
- Popular pickup & drop locations  
- Payment mode preferences  
- Ride cancellation patterns  

---

## 🛠️ Tools & Technologies Used

- **Database:** MySQL / PostgreSQL  
- **Language:** SQL  
- **IDE:** MySQL Workbench / pgAdmin  

### Concepts Applied
- Normalization  
- Relational Modeling  
- Primary & Foreign Keys  
- Data Integrity  
- Analytical Thinking  

---

## 🧪 Testing & Validation

- Inserted realistic sample data  
- Verified foreign key constraints  
- Checked data consistency across tables  
- Ensured no orphan records exist  


---

## 🎓 What I Learned From This Project

- Translating business requirements into database design  
- Importance of normalization  
- Real-world challenges in transactional systems  
- How SQL databases support analytical reporting  
- How production-level systems manage structured data  


