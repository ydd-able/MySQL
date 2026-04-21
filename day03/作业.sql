## 1 分页与排序课后练习题
# 1. 查询员工的姓名和部门号和年薪，按年薪降序,按姓名升序显示 
SELECT `last_name`,`department_id`,`salary`*12 FROM `employees` ORDER BY `salary`*12 DESC,last_name ASC;

# 2. 选择工资不在 8000 到 17000 的员工的姓名和工资，按工资降序，显示第21到40位置的数据 
SELECT `last_name`,`salary`FROM employees WHERE `salary` NOT BETWEEN 8000 AND 17000 
ORDER BY salary DESC 
LIMIT 20,20;

# 3. 查询邮箱中包含 e 的员工信息，并先按邮箱的字节数降序，再按部门号升序
SELECT `employee_id`,`last_name`,`department_id`,`email`FROM `employee_id`
WHERE email LIKE '%e%'
ORDER BY LENGTH(email) DESC,department_id ASC;






## 2 多表查询课后练习题
#表查询的课后练习

# 1.显示所有员工的姓名，部门号和部门名称。
SELECT e.`last_name`,e.`department_id`,d.`department_name` FROM employees AS e 
LEFT JOIN `departments` d
ON e.`department_id` = d.`department_id`;

# 2.查询90号部门员工的job_id和90号部门的location_id
SELECT e.`job_id`,d.`location_id` FROM `employees` e JOIN `departments` d ON e.`department_id` = d.`department_id` 
WHERE d.`department_id` = 90;

# 3.选择所有有奖金的员工的 last_name , department_name , location_id , city
SELECT e.`last_name`,d.`department_name`,l.`city` FROM `employees`e LEFT JOIN `departments` d ON e.`department_id` = d.`department_id`
LEFT JOIN `locations` l
ON d.`location_id` = l.`location_id`
WHERE e.`commission_pct` IS NOT NULL;


# 4.选择city在Toronto工作的员工的 last_name , job_id , department_id , department_name 
SELECT e.`last_name`,e.`job_id`,d.`department_id`,d.`department_name` FROM `employees` e JOIN `departments` d ON e.`department_id` = d.`department_id`
JOIN `locations` l ON d.`location_id` = l.`location_id`
WHERE l.`city` = 'Toronto';

# 第二种写法:
SELECT e.`last_name`,e.`job_id`,d.`department_id`,d.`department_name` 
FROM `employees` e,`departments` d ,`locations` l
WHERE e.`department_id` = d.`department_id`
AND d.`location_id` = l.`location_id`
AND l.`city` = 'Toronto';

# 5.查询员工所在的部门名称、部门地址、姓名、工作、工资，其中员工所在部门的部门名称为’Executive’
SELECT d.`department_name` ,l.`street_address` ,e.`last_name`,e.`job_id`,e.`salary` FROM `departments` d LEFT JOIN `employees` e 
ON e.`department_id` = d.`department_id`
LEFT JOIN `locations` l
ON d.`location_id` = l.`location_id`
WHERE d.`department_name` = 'executive';


# 6.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
SELECT emp.`last_name`AS "employees",emp.`employee_id` AS "emp",mgr.`last_name` AS "manager",mgr.`employee_id` AS "mgr"
FROM `employees` emp LEFT JOIN `employees` mgr 
ON emp.`manager_id` = mgr.`employee_id`;


# 7.查询哪些部门没有员工

SELECT d.`department_name`FROM `departments` d LEFT JOIN `employees` e 
ON d.`department_id` = e.`department_id`
WHERE e.`department_id` IS NULL;

# 8. 查询哪个城市没有部门 
SELECT l.`city` FROM `locations` l LEFT JOIN `departments` d
ON d.`location_id` = l.`location_id`
WHERE d.`location_id` IS NULL;


# 9. 查询部门名为 Sales 或 IT 的员工信息
SELECT e.`employee_id` ,e.`last_name`,e.`department_id` FROM `employees` e JOIN `departments` d 
ON e.`department_id` = d.`department_id`
WHERE d.`department_name` IN('Sales','IT');

