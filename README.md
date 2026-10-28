# Hospital Management System — SQL Project

## Project Overview
This project demonstrates the design and implementation of a relational database for a Hospital Management System using MySQL. It organizes information about patients, doctors, departments, appointments, treatments, and bills.

## Database Tables
The database contains seven tables:

- `Departments` — department information and contact details.
- `Doctors` — doctors, their specializations, and department assignments.
- `Patients` — patient demographic information.
- `Appointments` — patient appointments with doctors.
- `Treatments` — treatment descriptions and costs.
- `PatientTreatments` — records linking patients to treatments.
- `Bills` — billing amounts and payment status.

## SQL Concepts
The project demonstrates:

- Database and table creation
- Primary keys and foreign keys
- Relational database design and normalization
- Sample data insertion
- JOIN and GROUP BY
- Aggregate functions
- SQL views
- CASE expressions
- Window functions and ranking
- Indexing and query optimization

## Project Structure
- `sql/` — SQL scripts for database setup, sample data, and analysis.
- `images/` — database ER diagram and relevant screenshots.
- `docs/` — supporting documentation, where permission has been granted.

## Requirements
- MySQL Server
- MySQL Workbench or another MySQL client

## How to Run
1. Install and start MySQL Server.
2. Open the SQL script in MySQL Workbench.
3. Review the script before executing it.
4. Execute the database creation and table setup statements.
5. Run the sample data insertion statements.
6. Execute the views and analytical queries.
7. Verify the results using SELECT statements.

**Important:** The setup script may drop an existing database named `HospitalDB` before recreating it. Review the script and back up any important data before running it.

## Learning Objectives
The project illustrates how SQL can be used to structure relational data, connect related tables, generate reports, and explore basic database performance improvements.
