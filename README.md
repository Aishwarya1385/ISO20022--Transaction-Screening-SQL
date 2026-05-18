# 🏦 ISO 20022 Transaction Screening SQL

## 📌 Project Overview
This project simulates an ISO 20022-based payment transaction screening workflow used in modern financial institutions for operational risk and compliance monitoring.

The system models cross-border payment processing pipelines using ISO 20022 message structures (`pacs.008`, `pacs.009`) and applies SQL-based analytics to identify:

- Payments under sanctions review
- Frozen or investigating transactions
- Compliance-risk exposure
- Operational escalation requirements
- High-risk payment queues

The project is inspired by real-world payment operations, sanctions screening, and transaction investigation workflows commonly used in banking and financial services environments.

---

# 🛠️ Tech Stack & Concepts

### Language
- SQL

### Database
- PostgreSQL

### Core Concepts Demonstrated
- Data Definition Language (DDL)
- Data Manipulation Language (DML)
- Conditional Aggregation
- `CASE WHEN`
- `SUM()`
- `COUNT()`
- `GROUP BY`
- Operational Risk Analytics
- ISO 20022 Payment Messaging
- Compliance & Sanctions Screening Logic

---

# 🚀 Workflow Simulation

The project executes in 3 operational stages:
![Schema Design](/ISO20022/Screenshot/ss1.jpg)
## 1️⃣ DATA Creation
Creates a payment pipeline table storing:
- UETR transaction references
- ISO message types
- Payment participants
- Settlement amounts
- Sanctions screening outcomes
- Operational pipeline statuses

---
![Data Addition](/ISO20022/Screenshot/ss2.jpg)
## 2️⃣ Transaction Addition
Simulates realistic payment activity involving:
- Cleared payments
- Frozen transactions
- Investigating queues
- Critical sanctions alerts
- False positive screenings

---
![Analytics Output](/ISO20022/Screenshot/ss3.jpg)
## 3️⃣ Running the data
Runs SQL aggregation logic to:
- Count total processed messages
- Calculate total transferred value
- Aggregate payment exposure under compliance review
- Trigger operational escalation indicators

---

---

# 👤 Author

**Aishwarya Sivakumar**  



---
    END

