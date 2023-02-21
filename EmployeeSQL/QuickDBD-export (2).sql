-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
DROP TABLE IF EXISTS "Departments";
DROP TABLE IF EXISTS "Department_employees";
DROP TABLE IF EXISTS "Department_managers";
DROP TABLE IF EXISTS "Employees";
DROP TABLE IF EXISTS "Salaries";
DROP TABLE IF EXISTS "Titles";

CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
	constraint"pk_Departments" primary key ("dept_no")
);

CREATE TABLE "Department_employees" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "Department_managers" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "Employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
	constraint"pk_Employees" primary key ("emp_no")
);

CREATE TABLE "Salaries" (
    "employee_number" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
	constraint"pk_Titles" primary key ("title_id")
);

ALTER TABLE "Department_employees" ADD CONSTRAINT "fk_Department_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Department_employees" ADD CONSTRAINT "fk_Department_employees_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_managers" ADD CONSTRAINT "fk_Department_managers_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_managers" ADD CONSTRAINT "fk_Department_managers_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_employee_number" FOREIGN KEY("employee_number")
REFERENCES "Employees" ("emp_no");

-- Query * FROM Each Table Confirming Data
SELECT * FROM "Departments";
SELECT * FROM "Titles";
SELECT * FROM "Employees";
SELECT * FROM "Department_employees";
SELECT * FROM "Department_managers";
SELECT * FROM "Salaries";

--1.List the employee number, last name, first name, sex, and salary of each employee.
SELECT "Employees"."emp_no", "Employees"."last_name", "Employees"."first_name", "Employees"."sex", "Salaries"."salary"
FROM "Employees"
JOIN "Salaries"
ON "Employees"."emp_no"="Salaries"."employee_number";

--2.List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT "Employees"."last_name", "Employees"."first_name", "Employees"."hire_date"
FROM "Employees"
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date;

--3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT "Departments"."dept_no", "Departments"."dept_name", "Department_managers"."emp_no", "Employees"."last_name", "Employees"."first_name"
FROM "Departments"
JOIN "Department_managers"
ON "Departments"."dept_no" = "Department_managers"."dept_no"
JOIN "Employees"
ON "Department_managers"."emp_no" = "Employees"."emp_no";

--4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT "Departments"."dept_no","Department_employees"."emp_no", "Employees"."last_name", "Employees"."first_name",  "Departments"."dept_name"
FROM "Department_employees"
JOIN "Employees"
ON "Department_employees"."emp_no" = "Employees"."emp_no"
JOIN "Departments"
ON "Department_employees"."dept_no" = "Departments"."dept_no";


--5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT "last_name", "first_name", "sex"
FROM "Employees"
WHERE "first_name" = 'Hercules' AND "last_name" LIKE 'B%';

--6.List each employee in the Sales department, including their employee number, last name, and first name.
SELECT "Departments"."dept_name", "Employees"."last_name","Employees"."first_name"
FROM "Department_employees"
JOIN "Employees"
ON "Department_employees"."emp_no" = "Employees"."emp_no"
JOIN "Departments"
ON "Department_employees"."dept_no" = "Departments"."dept_no"
WHERE "Departments"."dept_name" = 'Sales';

--7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT "Departments"."dept_name", "Employees"."last_name","Employees"."first_name", "Employees"."emp_no"
FROM "Department_employees"
JOIN "Employees"
ON "Department_employees"."emp_no" = "Employees"."emp_no"
JOIN "Departments"
ON "Department_employees"."dept_no" = "Departments"."dept_no"
WHERE "Departments"."dept_name" = 'Sales' OR "Departments"."dept_name" = 'Development';

--8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT "last_name",
COUNT("last_name") AS "frequency"
FROM "Employees"
GROUP BY "last_name"
ORDER BY
COUNT("last_name") DESC;

