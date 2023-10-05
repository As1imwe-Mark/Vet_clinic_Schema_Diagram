CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  date_of_birth DATE,
  PRIMARY KEY(id)
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  type VARCHAR(255),
  PRIMARY KEY(id)
);

CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  status VARCHAR(100),
  patient_id INT REFERENCES patients(id),
  PRIMARY KEY(id)
);

CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  paid_at TIMESTAMP,
  medical_history_id INT REFERENCES medical_histories(id),
  PRIMARY KEY(id)
);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT REFERENCES invoices(id),
  treatment_id INT REFERENCES treatments(id),
  PRIMARY KEY(id)
);

-- Created a join table for the many-to-many relationship between treatments and medical_histories
CREATE TABLE medical_history_treatments (
  medical_history_id INT,
  treatment_id INT,
  PRIMARY KEY(medical_history_id, treatment_id),
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

-- Created a join table for the many-to-many relationship between patients and medical_histories
CREATE TABLE patient_medical_histories (
  patient_id INT,
  medical_history_id INT,
  PRIMARY KEY(patient_id, medical_history_id),
  FOREIGN KEY (patient_id) REFERENCES patients(id),
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

-- Added foreign key indexes for the join tables
CREATE INDEX idx_medical_history_id ON medical_history_treatments(medical_history_id);
CREATE INDEX idx_treatment_id ON medical_history_treatments(treatment_id);
CREATE INDEX idx_patient_id ON patient_medical_histories(patient_id);
CREATE INDEX idx_medical_history_id_pmh ON patient_medical_histories(medical_history_id);
