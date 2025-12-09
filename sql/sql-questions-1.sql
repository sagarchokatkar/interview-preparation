create table emp(name text,salary int);
insert into emp(name,salary) values('aa',5000);
insert into emp(name,salary) values('bb',3000);
insert into emp(name,salary) values('cc',9000);
insert into emp(name,salary) values('dd',7000);
----------
select * from emp;

-- GET SECOND HIGHEST SALARY
-- SOL-1
select max(salary) from emp
where salary not in (select max(salary) from emp);

-- SOL-2
select max(salary) from emp
where salary < (select max(salary) from emp);

-- SOL-3
SELECT DISTINCT salary FROM emp
ORDER BY salary DESC LIMIT 1 OFFSET 1;

-- SOL-4
SELECT salary
FROM
(SELECT salary
FROM emp
ORDER BY salary DESC LIMIT 2)as temp --N-th highest
ORDER BY temp.salary ASC
LIMIT 1;

-- SOL-5
with cte as(
    select *, Dense_rank() over(order by salary desc) as ds
    from emp
)
select max(salary) as SecondHighestSalary from cte where ds=2

-- PERFECT SOLUTION
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      SELECT DISTINCT e1.salary
       FROM Employee e1
        WHERE (
            SELECT COUNT(DISTINCT e2.salary)
            FROM Employee e2
            WHERE e2.salary > e1.salary
        )= N - 1
);
END

-----------------------------------
--Aggregate Functions

SELECT department,
       COUNT(*) AS total_employees,
       AVG(salary) AS avg_salary,
       MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary
FROM employees
GROUP BY department;
------
select min(salary) as min_sal,
max(salary) as max_sal,
sum(salary) as sum_sal,
avg(salary) as avg_sal,
count(*) as count_rows
from emp;
------------------------------------
select * from emp where city in ('Banglore','Chennai');
----------------------------------
select * from A
union --combines tables without duplicates
select * from B;

select * from A
union all --combines tables with duplicates
select * from B;