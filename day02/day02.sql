SELECT RAND() FROM DUAL;
SELECT 10+3 FROM DUAL;
SELECT 10/0 FROM DUAL;
#取余数
SELECT 10 MOD 3 FROM DUAL;
#查询所有部门id模2为0的员工
SELECT *FROM employees WHERE employee_id % 2 = 0;

#大小写字母都是0
SELECT 1  =  'a' ,   0 = 'a' FROM DUAL;

#案例
#将每条记录的salary的值获取到，然后和6000进行比较，如果比较的结果为真，就将对应的记录过滤出来。
SELECT last_name ,salary ,`commission_pct` FROM employees WHERE salary = 6000;

#任何值和 NULL 用 = 比较，结果都是 NULL
SELECT NULL = NULL,'' = NULL FROM DUAL;
#用安全等于，得到的结果为1.
SELECT last_name FROM employees WHERE `commission_pct` <=>NULL;

# is null isnull函数
SELECT NULL IS NULL ,ISNULL(NULL),ISNULL('a'), 'b' IS NULL FROM DUAL;

#练习：查询表中的commision_pct为null的数据有哪些。
SELECT * FROM employees WHERE ISNULL(commission_pct);
SELECT * FROM employees WHERE `commission_pct` IS NULL;

#判断不为空：is not null
SELECT * FROM employees WHERE `commission_pct` IS NOT NULL;

#least 最小运算符
SELECT LEAST(1,0,2),LEAST('a','b','c');
#比较first_name , last_name的大小和字符串长度，将最小的显示出来。
SELECT LEAST(first_name, last_name),LEAST(LENGTH(first_name),LENGTH(last_name)) FROM employees;

#greatest 最大运算符。
SELECT GREATEST(1,3,5),GREATEST(1,NULL,100)FROM DUAL;

#查询员工工资在6000到8000的员工信息，
SELECT employee_id , last_name ,salary FROM employees WHERE salary BETWEEN 6000 AND 8000;
SELECT employee_id , last_name ,salary FROM employees WHERE salary>=6000 AND salary<=8000;

#查询员工工资不在6000到8000的员工信息，
SELECT employee_id , last_name ,salary FROM employees WHERE salary<=6000 OR salary>=8000;


#in关键字
SELECT 'a' IN ('a','b','c'), 1 IN (2,3);

#查询部门编号是10 20 30 的员工信息
SELECT * FROM employees WHERE `department_id` IN (10,20,30);

#查询部门编号不是10 20 30 的员工信息
SELECT *FROM employees WHERE `department_id` NOT IN(10,20,30);

#查询last_name中以字符‘a'开头的员工信息。
SELECT last_name FROM employees WHERE last_name LIKE 'a%';

#查询last_name中包含字符‘a'的员工信息。
SELECT last_name FROM employees WHERE last_name LIKE '%a%';

#查询last_name中包含字符’a'且包含字符‘e'的员工信息
SELECT * FROM employees WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';

#有且只会匹配一个字符.
#练习：查询第3个字符是’a'的员工信息。
# _:匹配任意一个字符
# %：匹配0个或多个字符。
SELECT last_name FROM employees WHERE last_name LIKE '__a%';

SELECT last_name FROM employees WHERE last_name LIKE '%a';

SELECT last_name FROM employees WHERE last_name LIKE '_a';








#第二天作业

## 1 基本SELECT语句练习
# 1.查询员工12个月的工资总和，并起别名为ANNUAL SALARY
#理解1：计算12月的基本工资
SELECT `employee_id`,salary*12 AS "ANNUAL SALARY" FROM employees;

#理解2：计算12月的基本工资和奖金

SELECT `employee_id`,salary*12*(1+IFNULL(`commission_pct`,0)) AS "ANNUAL SALARY" FROM employees;

# 2.查询employees表中去除重复的job_id以后的数据
SELECT DISTINCT job_id FROM employees;

# 3.查询工资大于12000的员工姓名和工资
SELECT `last_name`,`first_name`,`salary` FROM employees WHERE salary >12000;

# 4.查询员工号为176的员工的姓名和部门号
SELECT last_name ,`department_id` FROM employees WHERE `employee_id` = 176;

# 5.显示表 departments 的结构，并查询其中的全部数据 
DESC `departments`;
SELECT * FROM departments;

# 2 运算符练习

# 1.选择工资不在5000到12000的员工的姓名和工资
SELECT `last_name`,`first_name`,`salary` FROM employees WHERE salary NOT BETWEEN 5000 AND 12000;

# 2.选择在20或50号部门工作的员工姓名和部门号
SELECT `last_name`,`first_name`,`department_id` FROM employees WHERE `department_id` = 20 OR `department_id` = 50;

# 3.选择公司中没有管理者的员工姓名及job_id
SELECT `last_name`,`job_id`,`manager_id`FROM employees WHERE manager_id IS NULL;

# 4.选择公司中有奖金的员工姓名，工资和奖金级别
SELECT `last_name`,`salary`,`commission_pct`FROM employees WHERE  `commission_pct` IS NOT NULL;
# 5.选择员工姓名的第三个字母是a的员工姓名
SELECT`last_name`FROM employees WHERE `last_name` LIKE '__a%';
# 6.选择姓名中有字母a和k的员工姓名
SELECT`last_name`FROM employees WHERE `last_name` LIKE '%a%' AND last_name LIKE '%k%';
SELECT `last_name`FROM employees WHERE `last_name` LIKE '%a%k%' OR last_name LIKE '%k%a%';
# 7.显示出表 employees 表中 first_name 以 'e'结尾的员工信息
SELECT `first_name` FROM employees WHERE `first_name` LIKE '%e';

# 8.显示出表 employees 部门编号在 80-100 之间的姓名、工种
SELECT`last_name`,`job_id` ,`department_id`FROM employees WHERE `department_id` BETWEEN 80 AND 100;

# 9.显示出表 employees 的 manager_id 是 100,101,110 的员工姓名、工资、管理者id
SELECT `last_name`,`salary`,`manager_id` FROM`employees` WHERE `manager_id` IN (100,101,110);



