# 查询最低工资大于110号部门最低工资的部门id和其最低工资
SELECT `department_id`,MIN(`salary`) FROM `employees` GROUP BY `department_id`
HAVING MIN(`salary`) > (
SELECT MIN(`salary`) FROM `employees` WHERE `department_id` = 110
);

-- 单行子查询
SELECT `employee_id`,`last_name`,CASE`department_id` WHEN(
SELECT `department_id` FROM `departments`WHERE `department_id` =1800
) THEN 'Canada' ELSE 'USA' END location
FROM`employees`;

-- 单行子查询出现的空值问题
-- 内层查询结果为空，导致整个为空。
-- 内层子查询返回结果为一条


-- 多行子查询
SELECT employee_id,last_name,job_id,salary
FROM `employees`
WHERE `job_id` <> 'IT_PROG'
AND salary < ANY(
SELECT salary FROM employees 
WHERE job_id = 'IT_PROG'
);

SELECT employee_id,last_name,job_id,salary
FROM `employees`
WHERE `job_id` <> 'IT_PROG'
AND salary < ALL(
SELECT salary FROM employees 
WHERE job_id = 'IT_PROG'
);

#查询平均工资最低的部门id
SELECT`department_id`, AVG(`salary`) 
FROM `employees` 
GROUP BY department_id
HAVING AVG(`salary`) = (
SELECT MIN(avg_sal) FROM (SELECT AVG(salary) avg_sal
FROM `employees`
GROUP BY department_id
) t_dept_avg_sal
);


-- 相关子查询
-- （1） 查询员工中工资大于本部门平均工资的员工的last_name,salary和其department_id
SELECT `last_name`,`salary`,`department_id`
FROM `employees` e1
WHERE `salary` >(
SELECT AVG(`salary`) FROM `employees` e2 WHERE e2.`department_id` = e1.`department_id`
);

-- 查询员工的id，salary,按照department_name排序
SELECT `employee_id`,`salary` FROM `employees` e1 
ORDER BY(
SELECT `department_name` FROM`departments` d WHERE e1.`department_id` = d.`department_id`
) DESC;


-- 子查询
SELECT `employee_id` FROM `employees` 
WHERE `employee_id` IN
(SELECT DISTINCT `manager_id` FROM `employees`);


-- exists关键字实现
SELECT  `employee_id` , `last_name`,`job_id`,`department_id`
FROM `employees` e1
WHERE EXISTS(
SELECT * FROM `employees` WHERE e1.`employee_id` = e2.`manager_id`
)

SELECT `department_id` ,`department_name` 
FROM `departments` AS d 
WHERE NOT EXISTS (
SELECT * FROM employees e 
WHERE d.`department_id` = e.`department_id`
);


-- 5.3 创建和管理数据库，数据表
CREATE DATABASE mytest1; 

-- 查看数据库的结构
SHOW CREATE DATABASE mytest1;
-- 在创建数据库的时候指定字符集
CREATE DATABASE mytest2 CHARACTER SET 'gbk';
SHOW CREATE DATABASE mytest2;


-- 查看数据库有哪些
SHOW DATABASES;

-- 切换数据库
USE dbtest1;

-- 查看当前使用的数据库
SELECT DATABASE() 

SHOW TABLES FROM dbtest1;

-- 删除数据库
DROP DATABASE mytest3;


-- 数据表相关的操作
CREATE TABLE IF NOT EXISTS myemp1(
id INT ,
emp_name VARCHAR(10),
hire_date DATE
)


-- 修改表操作
-- 给数据表添加一个字段
  












  
















