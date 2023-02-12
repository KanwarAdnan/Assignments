CREATE TABLE students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(255),
);

CREATE TABLE courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(255),
 
);

CREATE TABLE enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (student_id) REFERENCES students (student_id) ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES courses (course_id) ON DELETE CASCADE
);

CREATE TABLE users (
  user_id INT PRIMARY KEY,
  user_name VARCHAR(255),
);

CREATE TABLE loans (
  loan_id INT PRIMARY KEY,
  user_id INT,
  loan_amount INT,
  loan_date DATE,
  FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE repayments (
  repayment_id INT PRIMARY KEY,
  loan_id INT,
  user_id INT,
  repayment_amount INT,
  repayment_date DATE,
  FOREIGN KEY (user_id) REFERENCES users (user_id),
  FOREIGN KEY (loan_id) REFERENCES loans (loan_id)
);


INSERT INTO students (student_id, student_name)
VALUES (1, 'John Doe'), (2, 'Jane Doe'), (3, 'Jim Smith');

INSERT INTO courses (course_id, course_name)
VALUES (1, 'Intro to Computer Science'), (2, 'Data Structures'), (3, 'Database Systems');

INSERT INTO enrollments (enrollment_id, student_id, course_id, start_date, end_date)
VALUES (1, 1, 1, '2022-01-01', '2022-05-31'), (2, 1, 2, '2022-06-01', '2022-12-31'),
       (3, 2, 1, '2022-01-01', '2022-05-31'), (4, 2, 3, '2022-06-01', '2022-12-31'),
       (5, 3, 2, '2022-01-01', '2022-05-31'), (6, 3, 3, '2022-06-01', '2022-12-31');

INSERT INTO users (user_id, user_name)
VALUES (1, 'John Doe'), (2, 'Jane Doe'), (3, 'Jim Smith');

INSERT INTO loans (loan_id, user_id, loan_amount, loan_date)
VALUES (1, 1, 10000, '2022-02-02'), (2, 2, 5000, '2022-03-03'), (3, 3, 7000, '2022-04-04');

INSERT INTO repayments (repayment_id, loan_id, user_id, repayment_amount, repayment_date)
VALUES (1, 1, 1, 5000, '2022-03-03'), (2, 1, 1, 2500, '2022-04-04');

Get the total loan amount taken by each user:
SELECT user_id, SUM(loan_amount) AS total_loan_amount
FROM loans
GROUP BY user_id;

Get the total repayment amount for each loan:
SELECT loan_id, SUM(repayment_amount) AS total_repayment_amount
FROM repayments
GROUP BY loan_id;

Get the loan and repayment information for a specific user:
SELECT l.loan_id, l.loan_amount, l.loan_date, r.repayment_amount, r.repayment_date
FROM loans l
LEFT JOIN repayments r ON l.loan_id = r.loan_id
WHERE l.user_id = 1;

Get the remaining balance for each loan:
SELECT l.loan_id, l.loan_amount - COALESCE(SUM(r.repayment_amount), 0) AS remaining_balance
FROM loans l
LEFT JOIN repayments r ON l.loan_id = r.loan_id
GROUP BY l.loan_id;

