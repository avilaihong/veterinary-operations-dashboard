-- Veterinary Operations Analytics Database
-- Synthetic portfolio dataset; SQLite-compatible starter schema.

CREATE TABLE clinics (
  ClinicID TEXT PRIMARY KEY,
  ClinicName TEXT,
  City TEXT,
  State TEXT,
  Region TEXT,
  ClinicType TEXT,
  OpenDate DATE,
  SquareFeet INTEGER,
  ExamRooms INTEGER,
  AnnualCapacity INTEGER,
  ManagerName TEXT
);

CREATE TABLE employees (
  EmployeeID TEXT PRIMARY KEY,
  ClinicID TEXT,
  EmployeeName TEXT,
  Role TEXT,
  Specialty TEXT,
  HireDate DATE,
  EmploymentStatus TEXT,
  FTE REAL,
  HourlyRate REAL,
  AnnualSalary REAL,
  FOREIGN KEY (ClinicID) REFERENCES clinics(ClinicID)
);

CREATE TABLE clients (
  ClientID TEXT PRIMARY KEY,
  PreferredClinicID TEXT,
  ClientName TEXT,
  City TEXT,
  State TEXT,
  PostalCode TEXT,
  ClientSince DATE,
  MarketingOptIn TEXT,
  PreferredContact TEXT,
  AcquisitionChannel TEXT,
  HouseholdIncomeBand TEXT,
  FOREIGN KEY (PreferredClinicID) REFERENCES clinics(ClinicID)
);

CREATE TABLE pets (
  PetID TEXT PRIMARY KEY,
  ClientID TEXT,
  PetName TEXT,
  Species TEXT,
  Breed TEXT,
  Sex TEXT,
  SpayedNeutered TEXT,
  DateOfBirth DATE,
  WeightLbs REAL,
  InsuranceStatus TEXT,
  ChronicCondition TEXT,
  PetStatus TEXT,
  FOREIGN KEY (ClientID) REFERENCES clients(ClientID)
);

CREATE TABLE appointments (
  AppointmentID TEXT PRIMARY KEY,
  ClinicID TEXT,
  PetID TEXT,
  ClientID TEXT,
  VeterinarianID TEXT,
  AppointmentDate DATE,
  AppointmentTime TEXT,
  AppointmentType TEXT,
  BookingChannel TEXT,
  AppointmentStatus TEXT,
  ScheduledMinutes INTEGER,
  ActualMinutes INTEGER,
  WaitTimeMinutes INTEGER,
  PrimaryDiagnosis TEXT,
  NewPatientVisit TEXT,
  FollowUpRecommended TEXT,
  SatisfactionScore INTEGER,
  FOREIGN KEY (ClinicID) REFERENCES clinics(ClinicID),
  FOREIGN KEY (PetID) REFERENCES pets(PetID),
  FOREIGN KEY (ClientID) REFERENCES clients(ClientID),
  FOREIGN KEY (VeterinarianID) REFERENCES employees(EmployeeID)
);

CREATE TABLE services (
  ServiceID TEXT PRIMARY KEY,
  ServiceName TEXT,
  ServiceCategory TEXT,
  StandardPrice REAL,
  StandardMinutes INTEGER
);

CREATE TABLE invoices (
  InvoiceID TEXT PRIMARY KEY,
  AppointmentID TEXT,
  ClinicID TEXT,
  ClientID TEXT,
  PetID TEXT,
  InvoiceDate DATE,
  Subtotal REAL,
  TaxAmount REAL,
  TotalAmount REAL,
  AmountPaid REAL,
  BalanceDue REAL,
  PaymentStatus TEXT,
  PaymentMethod TEXT,
  InsuranceClaim TEXT,
  FOREIGN KEY (AppointmentID) REFERENCES appointments(AppointmentID)
);

CREATE TABLE invoice_lines (
  InvoiceLineID TEXT PRIMARY KEY,
  InvoiceID TEXT,
  AppointmentID TEXT,
  ServiceID TEXT,
  Quantity INTEGER,
  UnitPrice REAL,
  DiscountAmount REAL,
  LineTotal REAL,
  RevenueCategory TEXT,
  FOREIGN KEY (InvoiceID) REFERENCES invoices(InvoiceID),
  FOREIGN KEY (ServiceID) REFERENCES services(ServiceID)
);

CREATE TABLE inventory_monthly (
  SnapshotDate DATE,
  ClinicID TEXT,
  ItemID TEXT,
  ItemName TEXT,
  Category TEXT,
  UnitCost REAL,
  ChargePrice REAL,
  UnitsOnHand INTEGER,
  UnitsUsedMonth INTEGER,
  UnitsWastedMonth INTEGER,
  ReorderPoint INTEGER,
  StockoutFlag TEXT,
  InventoryValue REAL
);

CREATE TABLE staff_hours_monthly (
  Month DATE,
  EmployeeID TEXT,
  ClinicID TEXT,
  Role TEXT,
  RegularHours REAL,
  OvertimeHours REAL,
  PTOHours REAL,
  ProductiveHours REAL
);