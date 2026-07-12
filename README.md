# 💈 Barbershop Customer Analysis — SQL Portfolio Project

**SQL-only analysis of 2,000 customer visits to uncover behavior patterns, service performance, and revenue drivers for a barbershop business.**

![SQL](https://img.shields.io/badge/SQL-SQLite-blue?logo=sqlite&logoColor=white)
![Status](https://img.shields.io/badge/status-completed-brightgreen)
![Type](https://img.shields.io/badge/type-portfolio%20project-orange)

---

## 📌 Project Overview

A barbershop owner wants to know: *which services actually drive revenue, which days need more staff, which customers are loyal vs. at risk of churning, and who should receive a win-back promo?*

This project answers those questions end-to-end using **pure SQL** against a transactional dataset of customer visits — no BI tool, no spreadsheet. It's designed to demonstrate the kind of query-writing and business-translation skills expected from a **Data Analyst / Analytics** role: turning a flat table into decisions a business owner can act on.

## 🗂️ Dataset

| | |
|---|---|
| **Source** | `data/databarber.db` (SQLite) |
| **Table** | `pelanggan` |
| **Rows** | 2,000 visit transactions |
| **Unique customers** | 398 |
| **Date range** | Sep 2023 – Aug 2025 (2 years) |

**Schema:**

| Column | Type | Description |
|---|---|---|
| `id` | INTEGER | Primary key |
| `nama` | VARCHAR(100) | Customer name |
| `gender` | CHAR(1) | `L` (male) / `P` (female) |
| `usia` | INT | Customer age |
| `telepon` | VARCHAR(20) | Phone number |
| `layanan` | VARCHAR(50) | Service taken (Potong Rambut, Cukur, Cat Rambut, Facial, Creambath) |
| `tanggal_kunjungan` | DATE | Visit date |
| `metode_pembayaran` | VARCHAR(20) | Payment method (Tunai, Transfer, E-Wallet) |

## ❓ Business Questions Answered

1. How many unique customers visited, and how is monthly traffic trending (MoM % growth)?
2. What's the gender split of the customer base?
3. Which services are the most popular, and which generate the most revenue?
4. Which day of the week is busiest?
5. Who are the shop's most loyal (highest-frequency) customers?
6. How many days pass between a customer's visits on average?
7. Which customers haven't returned in 500+ days — i.e., churn candidates for a win-back promo?
8. Which services/customers follow the 80/20 (Pareto) rule?
9. How does service and payment preference break down by gender (pivot-style)?
10. What does revenue look like over time, segmented by gender?

## 🔑 Key Insights

- **Retention is strong**: 383 of 398 customers (**96%**) are repeat visitors — only 15 are one-time customers, suggesting healthy loyalty and word-of-mouth.
- **Volume leader ≠ revenue leader**: *Cukur* (haircut/shave) is the most-booked service (21.1% of visits), but **Creambath drives the highest estimated revenue** despite being only the 4th most-booked — a classic case for pricing/upsell strategy.
- **Payment method is diversified**: Transfer (34.8%), Tunai/cash (32.9%), and E-Wallet (32.4%) are nearly evenly split — no single channel dominates, which matters for reconciliation and payment-processing decisions.
- **Gender split is balanced**: 50.2% female, 49.9% male — services and promos don't need to skew toward one segment.
- **Friday and Tuesday are the busiest days**, useful for staff scheduling.
- **6 customers are flagged as churn risks** (500+ days since last visit) — a ready-made target list for a re-engagement campaign.

*(All figures above were computed directly from the dataset using the queries in this repo.)*

## 🛠️ SQL Techniques Demonstrated

- **Window functions** — `LAG()` for month-over-month % change, `RANK()` for customer visit leaderboards, `SUM() OVER()` for percentage-of-total
- **Date/time functions** — `strftime()` for day-of-week extraction, `julianday()` for recency/days-between-visits calculations
- **Conditional aggregation** — `CASE WHEN`, `COUNT(*) FILTER (WHERE ...)` to build pivot-style tables (service × gender, payment × gender) without a BI tool
- **CTEs (`WITH`)** — layered revenue calculation (assign price per service, then aggregate)
- **Pareto / 80-20 analysis** — identifying the customers and services that account for the majority of visits/revenue
- **Recency-Frequency style analysis** — last-visit tracking and churn-window flagging for promo targeting

## 📁 Repository Structure

```
barbershop-customer-analysis/
├── data/
│   └── databarber.db              # SQLite database (2,000 rows, table: pelanggan)
├── sql/
│   ├── pelanggan_barbershop.sql   # Standalone, runnable analysis queries
│   └── notebook database.dbcnb    # DBCode SQL notebook (VS Code) — same analysis with markdown-annotated sections
├── index.html                     # Exported static view of the notebook
└── README.md
```

## 🚀 How to Reproduce

1. Clone the repo:
   ```bash
   git clone https://github.com/MYusril0354/barbershop-customer-analysis.git
   ```
2. Open `data/databarber.db` with any SQLite client — e.g. [DB Browser for SQLite](https://sqlitebrowser.org/), the [DBCode](https://marketplace.visualstudio.com/items?itemName=DBCode.dbcode) extension in VS Code, or the `sqlite3` CLI.
3. Run the queries in `sql/pelanggan_barbershop.sql` (or open the `.dbcnb` notebook in VS Code for the same analysis with narrative markdown sections).


## 🧰 Tools

`SQLite` · `DBCode (VS Code SQL notebook)` · `Git/GitHub`

## 👤 Author

**Muhammad Yusril**
Logistics & Warehouse Supervisor transitioning into Data Analytics
GitHub: [@MYusril0354](https://github.com/MYusril0354)

---
*Part of a broader SQL portfolio — see [warehouse picking assignment analysis](https://github.com/MYusril0354) for a second project applying similar techniques to logistics operations data.*