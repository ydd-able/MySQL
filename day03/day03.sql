-- 排序查询的关键字 order by
-- 升序 ASC
-- 降序 DESC

-- 使用order by 默认升序。
SELECT * FROM `employees`;

SELECT  `employee_id`,`last_name`,`salary` 
FROM `employees` 
ORDER BY salary DESC;


-- 使用别名来排序
-- 需求： 查询员工表的信息，包括年薪，根据年薪进行排序。
SELECT `employee_id`,`last_name`,`salary`*12 AS "total_salary" FROM employees ORDER BY "total_salary"DESC;

SELECT `employee_id`,`last_name`,`salary`*12 FROM employees WHERE salary*12 >100000 
ORDER BY salary*12 DESC;

-- order by 支持多字段排序,主排序字段相同时，次排序再生效。
SELECT `employee_id`,`last_name`,`salary`,`department_id`FROM employees 
ORDER BY `department_id` DESC ,`salary`ASC;

-- 分页查询的关键字limit【记录的偏移量】，行数
-- 分页查询的语法格式：
-- select 字段 from 表 limit 0,10 -- 第一页 显示10条记录
-- select 字段 from 表 limit 10,10 -- 第二页 显示10条记录

-- 需求1：分页查询员工表，显示前20条记录
SELECT `employee_id`,`last_name` FROM `employees` LIMIT 0,20;

-- 注意：不管sql语句多复杂，limit关键字应该在select语句最后面
SELECT `employee_id`,`last_name`,`salary`FROM`employees`
WHERE salary > 6000 ORDER BY salary DESC
LIMIT 0,10;
-- 查询员工表，只显示32，33条记录
SELECT `employee_id`,`last_name` FROM `employees` LIMIT 31,2;
-- limit 3 offset 4 等价于limit 4,3

-- 查询员工信息及其对应的部门信息
SELECT *FROM `employees`,`departments`
WHERE `departments`.`department_id`  = `employees`.`department`;


-- 查询员工信息及其对应的部门信息及其对应的地址信息
SELECT *FROM `employees` AS e ,`departments` AS d,`locations` AS l WHERE e.`department_id` = d.`department_id`
AND d.`location_id` = l.`location_id`;


-- 多表查询可以分为积累：等值匹配，非等值匹配 自连接 内连接 外连接
-- 需求：查询员工信息及其对应的薪资级别

SELECT `employees`.`employee_id`,`employees`.`last_name`,`job_grades`.`grade_level` FROM `employees`,`job_grades`
WHERE employees.`salary` >=job_grades.`lowest_sal` AND employees.`salary`<= job_grades.`highest_sal`;

-- 自连接 一张表自己和自己匹配,同一张表中一个字段引用了另一个字段的值
-- 需求：查询员工信息及其对应的上级领导信息。

SELECT emp.`employee_id`,emp.`last_name`,mgr.`last_name`FROM `employees` AS emp, `employees` AS mgr
WHERE  emp.`manager_id` = mgr.`employee_id`;

-- 内连接 只查询两张表中匹配的记录，任何不匹配的记录都会被过滤掉

SELECT * FROM `employees`AS emp INNER JOIN `departments` AS dept
ON emp.`department_id` = dept.`department_id`;

-- inner关键字可以省略

-- 查询员工信息及其对应部门信息和对应的地址信息
SELECT e.`employee_id`,e.`last_name`,d.`department_id`,l.`city`FROM `employees` AS e JOIN `departments` AS d ON e.`department_id` = d.`department_id`
JOIN `locations` AS l ON l.`location_id` = d.`location_id`;


-- 外连接 除了将两张表与匹配的记录显示出来，还需要显示另外一张没有匹配的记录。
-- 例子：查询员工信息及其对应的部门，将所有员工信息全部查询出来。
SELECT e.`employee_id`,e.`last_name`,d.`department_name` FROM `employees` AS e LEFT JOIN `departments` AS d  ON e.`department_id` = d.`department_id`;


-- 右外连接的使用
-- 查询所有的部门信息，及其对应的员工信息
SELECT e.`employee_id`,e.`last_name`,d.`department_id` FROM `employees` e RIGHT OUTER JOIN `departments` d ON e.`department_id` = d.`department_id`;

-- 联合查询
-- 联合查询就是将多个select语句的结果合并成一个单的结果集。
-- 合并的前提式多个查询结果之间，他们的列的数目和字段的数据类型必须一致
-- 联合查询的语法结构

-- 查询部门编号大于90，或者邮箱中包含a的员工信息。
SELECT * FROM employees WHERE email LIKE '%a%' OR department_id>90;
-- 联合查询实现
SELECT * FROM employees WHERE email LIKE '%a%'
UNION 
SELECT * FROM employees WHERE department_id>90;

  


-- 中图 内连接
SELECT e.`employee_id`,e.`last_name`,d.`department_name` FROM `employees` e JOIN `departments` d ON e.`department_id` = d.`department_id`;

-- 左上图 左外连接
SELECT e.`employee_id`,e.`last_name`,d.`department_name` FROM `employees` e LEFT JOIN `departments` d ON e.`department_id` = d.`department_id`;

-- 右上图 右外连接

SELECT e.`employee_id`,e.`last_name`,d.`department_name` FROM `employees` e RIGHT JOIN `departments` d ON e.`department_id` = d.`department_id`;

-- 左中图
SELECT e.`employee_id`,e.`last_name`,d.`department_name`
 FROM `employees` e LEFT JOIN `departments` d 
 ON e.`department_id` = d.`department_id`
 WHERE d.`department_id` IS NULL;
 

-- 右中图

SELECT e.`employee_id`,e.`last_name`,d.`department_name`
 FROM `employees` e RIGHT JOIN `departments` d 
 ON e.`department_id` = d.`department_id`
 WHERE e.`department_id` IS NULL;
 
 SELECT `department_id`,`department_name` FROM `departments`;
 
 -- 左下图
SELECT e.`employee_id`,e.`last_name`,d.`department_name` FROM `employees` e LEFT JOIN `departments` d ON e.`department_id` = d.`department_id`
UNION
SELECT e.`employee_id`,e.`last_name`,d.`department_name` FROM `employees` e RIGHT JOIN `departments` d ON e.`department_id` = d.`department_id`;

-- 右下图
SELECT e.`employee_id`,e.`last_name`,d.`department_name`
 FROM `employees` e LEFT JOIN `departments` d 
 ON e.`department_id` = d.`department_id`
 WHERE d.`department_id` IS NULL
 UNION
 SELECT e.`employee_id`,e.`last_name`,d.`department_name`
 FROM `employees` e RIGHT JOIN `departments` d 
 ON e.`department_id` = d.`department_id`
 WHERE e.`department_id` IS NULL;
 




