### 1 单行函数的课后练习


# 1.显示系统时间(注：日期+时间)
SELECT NOW() FROM DUAL;


# 2.查询员工号，姓名，工资，以及工资提高百分之20%后的结果（new salary）
SELECT `employee_id`,`last_name`,`salary`,`salary`*(1+0.2) AS "new salary" FROM `employees`;


# 3.将员工的姓名按首字母排序，并写出姓名的长度（length）
SELECT `last_name`,LENGTH(last_name) AS "new_length" FROM `employees`
ORDER BY last_name ASC;

# 4.查询员工id,last_name,salary，并作为一个列输出，别名为OUT_PUT
SELECT CONCAT(`employee_id`,',',`last_name`,`salary`) AS "OUT_PUT" FROM `employees`;


# 5.查询公司各员工工作的年数、工作的天数，并按工作年数的降序排序
SELECT `employee_id`, DATEDIFF(CURDATE(),hire_date) AS work_days, 
TIMESTAMPDIFF(YEAR,hire_date,CURDATE()) AS work_years FROM `employees` 
ORDER BY work_years DESC;


# 6.查询员工姓名，hire_date , department_id，满足以下条件：
#雇用时间在1997年之后，department_id 为80 或 90 或110, commission_pct不为空
SELECT `last_name`,`department_id`,`hire_date`
FROM `employees`
WHERE hire_date>='1997-01-01' 
AND `department_id` IN (80,90,110)
AND `commission_pct` IS NOT NULL;
# 7.查询公司中入职超过10000天的员工姓名、入职时间
SELECT `last_name`,`hire_date`FROM`employees`
WHERE DATEDIFF(CURDATE(),hire_date)>10000;


# 8.做一个查询，产生下面的结果
#<last_name> earns <salary> monthly but wants <salary*3> 
SELECT CONCAT(`last_name`,' earns ',`salary`,' monthly but wants ',`salary`*3) AS result
FROM employees;



# 9.使用case-when，按照下面的条件：
job                  grade
AD_PRES              	A
ST_MAN               	B
IT_PROG              	C
SA_REP               	D
ST_CLERK             	E


SELECT
    last_name,
    job_id,
    CASE job_id
        WHEN 'AD_PRES'  THEN 'A'
        WHEN 'ST_MAN'   THEN 'B'
        WHEN 'IT_PROG'  THEN 'C'
        WHEN 'SA_REP'   THEN 'D'
        WHEN 'ST_CLERK' THEN 'E'
        ELSE '未知'  
    END AS grade
FROM employees;

















### 2 聚合函数练习题


#1.where子句可否使用组函数进行过滤?  No!
-- 不可以，要用having

#2.查询公司员工工资的最大值，最小值，平均值，总和
SELECT
    MAX(salary) AS 最高工资,
    MIN(salary) AS 最低工资,
    AVG(salary) AS 平均工资,
    SUM(salary) AS 工资总和
FROM employees;

#3.查询各job_id的员工工资的最大值，最小值，平均值，总和
SELECT
job_id,
    MAX(salary) AS 最高工资,
    MIN(salary) AS 最低工资,
    AVG(salary) AS 平均工资,
    SUM(salary) AS 工资总和
    FROM employees;
GROUP BY `job_id`


#4.选择具有各个job_id的员工人数
SELECT
job_id,COUNT(*)
FROM `employees`
GROUP BY `job_id`;

# 5.查询员工最高工资和最低工资的差距（DIFFERENCE）  #DATEDIFF
SELECT
MAX(salary) - MIN(salary) AS DIFFERENCE
FROM employees;

# 6.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
SELECT `manager_id`,MIN(`salary`) 
FROM`employees`
WHERE `manager_id` IS NOT NULL
GROUP BY `manager_id`
HAVING MIN(`salary`) >= 6000;

# 7.查询所有部门的名字，location_id，员工数量和平均工资，并按平均工资降序 
SELECT
    d.department_name,
    d.location_id,
    COUNT(e.employee_id) AS 员工数量,
    AVG(e.salary) AS 平均工资
FROM departments d
LEFT JOIN employees e 
ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name, d.location_id
ORDER BY 平均工资 DESC;


# 8.查询每个工种、每个部门的部门名、工种名和最低工资 
SELECT
    d.department_name,
    j.job_title,
    MIN(e.salary) AS 最低工资
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
GROUP BY d.department_name, j.job_title;

