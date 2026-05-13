## 1 子查询课后练习

-- 1.查询和Zlotkey相同部门的员工姓名和工资
SELECT `employee_id`,`salary` FROM `employees` 
WHERE `department_id` =(SELECT `department_id` FROM `employees` WHERE `last_name` = 'Zlotkey');


#2.查询工资比公司平均工资高的员工的员工号，姓名和工资。 
SELECT `employee_id`,`last_name`,`salary` FROM `employees`
WHERE salary > (SELECT AVG(salary) FROM `employees`);

#3.选择工资大于所有JOB_ID = 'SA_MAN'的员工的工资的员工的last_name, job_id, salary
SELECT last_name, job_id, salary
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE job_id = 'SA_MAN'
);


#4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
SELECT employee_id, last_name
FROM employees
WHERE department_id IN (
    SELECT DISTINCT department_id
    FROM employees
    WHERE last_name LIKE '%u%'
);


#5.查询在部门的location_id为1700的部门工作的员工的员工号
SELECT employee_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location_id = 1700
);


#6.查询管理者是King的员工姓名和工资
SELECT last_name, salary
FROM employees
WHERE manager_id = (
    SELECT employee_id
    FROM employees
    WHERE last_name = 'King'
);


#7.查询工资最低的员工信息: last_name, salary
SELECT last_name, salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);

		
#8.查询平均工资最低的部门信息
SELECT *
FROM departments
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary)
    LIMIT 1
);


		
#9.查询平均工资最低的部门信息和该部门的平均工资（相关子查询）
SELECT d.*,
       (SELECT AVG(salary) FROM employees e WHERE e.department_id = d.department_id) avg_sal
FROM departments d
HAVING avg_sal = (
    SELECT MIN(avg_sal)
    FROM (
        SELECT AVG(salary) avg_sal
        FROM employees
        GROUP BY department_id
    ) t
);



#10.查询平均工资最高的 job 信息
SELECT *
FROM jobs
WHERE job_id = (
    SELECT job_id
    FROM employees
    GROUP BY job_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);


		
#11.查询平均工资高于公司员工平均工资的部门有哪些?
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM employees
);

#12.查询出公司中所有 manager 的详细信息
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM employees
);



	
#13.各个部门中 最高工资中最低的那个部门的 最低工资是多少?
SELECT MIN(salary)
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY MAX(salary)
    LIMIT 1
);



#14.查询平均工资最高的部门的 manager 的详细信息: last_name, department_id, email, salary
SELECT last_name, department_id, email, salary
FROM employees
WHERE employee_id = (
    SELECT manager_id
    FROM departments
    WHERE department_id = (
        SELECT department_id
        FROM employees
        GROUP BY department_id
        ORDER BY AVG(salary) DESC
        LIMIT 1
    )
);



#15. 查询部门的部门号，其中不包括job_id是"ST_CLERK"的部门号
SELECT DISTINCT department_id
FROM employees
WHERE department_id NOT IN (
    SELECT DISTINCT department_id
    FROM employees
    WHERE job_id = 'ST_CLERK'
);


#16. 选择所有没有管理者的员工的last_name
SELECT last_name
FROM employees
WHERE manager_id IS NULL;




#17．查询员工号、姓名、雇用时间、工资，其中员工的管理者为 'De Haan'
SELECT employee_id, last_name, hire_date, salary
FROM employees
WHERE manager_id = (
    SELECT employee_id
    FROM employees
    WHERE last_name = 'De Haan'
);


#18.查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资（相关子查询）
SELECT employee_id, last_name, salary
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);



#19.查询每个部门下的部门人数大于 5 的部门名称（相关子查询）
SELECT department_name
FROM departments d
WHERE 5 < (
    SELECT COUNT(*)
    FROM employees e
    WHERE e.department_id = d.department_id
);



#20.查询每个国家下的部门个数大于 2 的国家编号（相关子查询）
SELECT DISTINCT country_id
FROM locations l
WHERE 2 < (
    SELECT COUNT(*)
    FROM departments d
    WHERE d.location_id = l.location_id
);


## 2  创建和管理数据库、数据表课后练习


#练习1：
#1. 创建数据库test01_office,指明字符集为utf8。并在此数据库下执行下述操作
CREATE DATABASE IF NOT EXISTS test01_office CHARACTER SET utf8;
USE test01_office;


#2.	创建表dept01
/*
字段      类型
id	 INT(7)
NAME	 VARCHAR(25)
*/
CREATE TABLE dept01(
id INT(7),
NAME VARCHAR(25),
);



#3.将表departments中的数据插入新表dept02中
CREATE TABLE dept02 AS SELECT * FROM employees.departments;




#4.	创建表emp01
/*
字段            类型
id		INT(7)
first_name	VARCHAR (25)
last_name	VARCHAR(25)
dept_id		INT(7)
*/

CREATE TABLE emp01（
id INT(7),
first_name VARCHAR(25),
last_name VARCHAR(25),
dept_id INT(7)
);



#5.将列last_name的长度增加到50
ALTER TABLE emp01 MODIFY last_name VARCHAR(50);


#6.根据表employees创建emp02
CREATE TABLE emp02 AS SELECT * FROM employees




#7.删除表emp01
DROP TABLE emp01;



#8.将表emp02重命名为emp01
ALTER TABLE emp02 RENAME TO emp01;


#9.在表dept02和emp01中添加新列test_column，并检查所作的操作
ALTER TABLE dept02 ADD COLUMN test_column VARCHAR(10);
ALTER TABLE emp01 ADD COLUMN test_column VARCHAR(10);


#10.直接删除表emp01中的列 department_id
ALTER TABLE emp01 DROP COLUMN department_id;




#练习2：
# 1、创建数据库 test02_market
CREATE DATABASE IF NOT EXISTS test02_market CHARACTER SET utf8;



# 2、创建数据表 customers
CREATE TABLE customers (
    c_id INT,
    c_name VARCHAR(50),
    c_contact VARCHAR(20),
    c_birth DATE,
    c_city VARCHAR(30)
);



# 3、将 c_contact 字段移动到 c_birth 字段后面
ALTER TABLE customers MODIFY c_contact VARCHAR(20) AFTER c_birth;


# 4、将 c_name 字段数据类型改为 varchar(70)
ALTER TABLE customers MODIFY c_name VARCHAR(70);


# 5、将c_contact字段改名为c_phone
ALTER TABLE customers CHANGE c_contact c_phone VARCHAR(20);



# 6、增加c_gender字段到c_name后面，数据类型为char(1)
ALTER TABLE customers CHANGE c_contact c_phone VARCHAR(20);


# 7、将表名改为customers_info
ALTER TABLE customers RENAME TO customers_info;



# 8、删除字段c_city
ALTER TABLE customers_info DROP COLUMN c_city;


#练习3：
# 1、创建数据库test03_company
CREATE DATABASE IF NOT EXISTS test03_company CHARACTER SET utf8;
USE test03_company;



# 2、创建表offices
CREATE TABLE offices (
    office_id INT,
    address VARCHAR(50),
    city VARCHAR(20)
);




# 3、创建表employees
CREATE TABLE employees (
    id INT,
    CODE VARCHAR(10),
    NAME VARCHAR(20),
    mobile VARCHAR(15),
    birth DATE,
    sex VARCHAR(2),
    note VARCHAR(100)
);




# 4、将表employees的mobile字段修改到code字段后面
ALTER TABLE employees MODIFY mobile VARCHAR(15) AFTER CODE;



# 5、将表employees的birth字段改名为birthday
ALTER TABLE employees CHANGE birth birthday DATE;



# 6、修改sex字段，数据类型为char(1)
ALTER TABLE employees MODIFY sex CHAR(1);


# 7、删除字段note
ALTER TABLE employees DROP COLUMN note;


# 8、增加字段名favoriate_activity，数据类型为varchar(100)

ALTER TABLE employees ADD COLUMN favoriate_activity VARCHAR(100);

# 9、将表employees的名称修改为 employees_info
ALTER TABLE employees RENAME TO employees_info;


 