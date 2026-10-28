DROP DATABASE IF EXISTS HospitalDB;

CREATE DATABASE HospitalDB;

USE HospitalDB;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    Phone VARCHAR(15),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10),
    DateOfBirth DATE,
    Phone VARCHAR(15)
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    Status VARCHAR(30),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Treatments (
    TreatmentID INT PRIMARY KEY,
    TreatmentName VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    Cost DECIMAL(10,2)
);

CREATE TABLE PatientTreatments (
    PatientTreatmentID INT PRIMARY KEY,
    PatientID INT,
    TreatmentID INT,
    TreatmentDate DATE,
    Notes VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID)
);

CREATE TABLE Bills (
    BillID INT PRIMARY KEY,
    PatientID INT,
    BillDate DATE,
    Amount DECIMAL(10,2),
    PaymentStatus VARCHAR(30),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

SHOW TABLES;

INSERT INTO Departments
(DepartmentID, DepartmentName, Location, Phone)
VALUES
(1, 'Cardiology', 'Building A', '1111111111'),
(2, 'Neurology', 'Building B', '2222222222'),
(3, 'Orthopedics', 'Building C', '3333333333'),
(4, 'Pediatrics', 'Building D', '4444444444');

INSERT INTO Doctors
(DoctorID, DoctorName, Specialization, Phone, DepartmentID)
VALUES
(101, 'Dr. John Smith', 'Cardiologist', '9876543210', 1),
(102, 'Dr. Sarah Brown', 'Neurologist', '9876543211', 2),
(103, 'Dr. Michael Lee', 'Orthopedic Surgeon', '9876543212', 3),
(104, 'Dr. Emma Wilson', 'Pediatrician', '9876543213', 4);

INSERT INTO Patients
(PatientID, FirstName, LastName, Gender, DateOfBirth, Phone)
VALUES
(201, 'James', 'Anderson', 'Male', '1990-05-15', '9000000001'),
(202, 'Sophia', 'Taylor', 'Female', '1995-08-20', '9000000002'),
(203, 'Daniel', 'Thomas', 'Male', '1988-11-10', '9000000003'),
(204, 'Olivia', 'Martin', 'Female', '1992-03-25', '9000000004'),
(205, 'William', 'White', 'Male', '1998-07-18', '9000000005');

INSERT INTO Appointments
(AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, Status)
VALUES
(301, 201, 101, '2026-05-01', '09:00:00', 'Completed'),
(302, 202, 102, '2026-05-03', '10:00:00', 'Completed'),
(303, 203, 103, '2026-05-05', '11:00:00', 'Completed'),
(304, 204, 101, '2026-06-07', '12:00:00', 'Pending'),
(305, 205, 104, '2026-06-10', '14:00:00', 'Completed');

INSERT INTO Treatments
(TreatmentID, TreatmentName, Description, Cost)
VALUES
(401, 'Heart Checkup', 'Cardiac examination and consultation', 500.00),
(402, 'Brain MRI', 'Neurological scan for brain diagnosis', 1200.00),
(403, 'Bone Surgery', 'Orthopedic surgical procedure', 5000.00),
(404, 'ECG Test', 'Heart rhythm monitoring test', 300.00),
(405, 'Child Health Checkup', 'General pediatric health examination', 250.00);

INSERT INTO PatientTreatments
(PatientTreatmentID, PatientID, TreatmentID, TreatmentDate, Notes)
VALUES
(501, 201, 401, '2026-05-01', 'Routine cardiac checkup completed'),
(502, 202, 402, '2026-05-03', 'MRI scan completed'),
(503, 203, 403, '2026-05-05', 'Surgery completed successfully'),
(504, 204, 404, '2026-06-07', 'ECG test performed'),
(505, 205, 405, '2026-06-10', 'General pediatric screening completed');

INSERT INTO Bills
(BillID, PatientID, BillDate, Amount, PaymentStatus)
VALUES
(601, 201, '2026-05-01', 500.00, 'Paid'),
(602, 202, '2026-05-03', 1200.00, 'Paid'),
(603, 203, '2026-05-05', 5000.00, 'Pending'),
(604, 204, '2026-06-07', 300.00, 'Paid'),
(605, 205, '2026-06-10', 250.00, 'Paid');

SELECT * FROM Departments;
SELECT * FROM Doctors;
SELECT * FROM Patients;
SELECT * FROM Appointments;
SELECT * FROM Treatments;
SELECT * FROM PatientTreatments;
SELECT * FROM Bills;

-- View 1: Patient Bill Summary

CREATE OR REPLACE VIEW PatientBillSummary AS
SELECT
    P.PatientID,
    CONCAT(P.FirstName, ' ', P.LastName) AS PatientName,
    COUNT(B.BillID) AS NumberOfBills,
    SUM(B.Amount) AS TotalSpent
FROM Patients P
JOIN Bills B
    ON P.PatientID = B.PatientID
GROUP BY
    P.PatientID,
    P.FirstName,
    P.LastName;

SELECT * FROM PatientBillSummary;

-- View 2: Monthly Appointment Trend

CREATE OR REPLACE VIEW MonthlyAppointmentTrend AS
SELECT
    YEAR(AppointmentDate) AS AppointmentYear,
    MONTH(AppointmentDate) AS AppointmentMonth,
    MONTHNAME(AppointmentDate) AS MonthName,
    COUNT(AppointmentID) AS TotalAppointments
FROM Appointments
GROUP BY
    YEAR(AppointmentDate),
    MONTH(AppointmentDate),
    MONTHNAME(AppointmentDate)
ORDER BY
    AppointmentYear,
    AppointmentMonth;

SELECT * FROM MonthlyAppointmentTrend;