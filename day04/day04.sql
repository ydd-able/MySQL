-- mysql中的单行函数
-- 数值函数
SELECT SIGN(200) , SIGN(-120),SIGN(0),SIGN(NULL) FROM DUAL; -- 返回指定数字的符号，正数是1，负数是-1
SELECT PI() FROM DUAL;
SELECT CEIL(19.999),CEIL(19.001) FROM DUAL; -- 向上取整数
SELECT FLOOR(3.9999) FROM DUAL;
SELECT MOD(10,3) FROM DUAL;

SELECT RAND(),RAND() FROM DUAL;

-- 如何获取指定区间的随机数


-- 四舍五入
SELECT ROUND(120.67) , ROUND(123.342,0) FROM DUAL;

SELECT TRUNCATE(123.123,0) FROM DUAL;

SELECT RADIANS(30) FROM DUAL;

SELECT DEGREES(2*PI())FROM DUAL;

SELECT SIN(RADIANS(30))FROM DUAL;


-- 指数函数
SELECT POW(2,5) ,POWER(3,2),EXP(2) FROM DUAL;
SELECT LN(EXP(2)) FROM DUAL;
SELECT LOG2(4) FROM DUAL;

-- bin(10) 将十进制转换为二进制
-- hek(10) 将16进制转换成16进制
-- oct(10) 将10进制的10转换为8进制
SELECT BIN(10),HEX(10),OCT(10) FROM DUAL;






-- 字符串函数
SELECT ASCII('A'),ASCII('xyz') FROM DUAL; -- 返回指定字符的ascii码值

-- 返回字符个数
SELECT CHAR_LENGTH('hello'),CHAR_LENGTH('大家好') FROM DUAL; 

SELECT LENGTH('hello'),LENGTH('大家好') FROM DUAL; -- 一个汉字对应三个字节

-- 字符串拼接
SELECT CONCAT('hello','world') FROM DUAL;

SELECT INSERT('helloworld',2,3,'abcde') FROM DUAL;
-- 转大写
SELECT UPPER('abcd'),UPPER('AbcDe') FROM DUAL;

-- 需求
SELECT last_name ,salary FROM employees WHERE LOWER(last_name) = 'king';

SELECT LEFT('hello',2) FROM DUAL; -- 返回左边的指定数目的字符

SELECT RIGHT('hello' ,2) FROM DUAL;

SELECT `employee_id`,`last_name`,LPAD(salary,10,"*") FROM `employees`;

SELECT REPEAT('hello',4)FROM DUAL;
SELECT LENGTH(SPACE(5)) FROM DUAL;
SELECT STRCMP('abc','abe') FROM DUAL;  -- 比较两个字符串大小
SELECT SUBSTR('hello',2,2) FROM DUAL;  -- 根据指定索引值和长度截取字符串。
SELECT LOCATE('l','hello') FROM DUAL;  -- 返回指定位置的字符串
SELECT ELT(2,'aa','bb','dd') FROM DUAL; -- 返回指定字符串

SELECT FIELD('bb','aa','bb','dd') FROM DUAL; -- 返回指定字符串再字符串列表中第一次出现的索引值位置。

SELECT FIND_IN_SET('mm','aa,bb,cc,dd,mm') FROM DUAL;

-- 日期
-- 获取当前的系统日期
SELECT CURDATE(),CURRENT_DATE() FROM DUAL; -- 返回当前系统时间的年月日部分。
SELECT CURTIME(), CURRENT_TIME() FROM DUAL; -- 返回当前系统时间的时分秒部分
SELECT UTC_DATE(),UTC_TIME() FROM DUAL; -- 返回国际标准格式的时间和日期
SELECT NOW() FROM DUAL; -- 返回当前系统时间的年月日，时分秒
SELECT CURDATE() + 0 FROM DUAL;


-- 日期和时间戳之间的转换。
SELECT UNIX_TIMESTAMP('2024-2-15 10:10:10') FROM DUAL; -- 返回指定时间的毫秒值
SELECT YEAR(NOW()) FROM DUAL;
SELECT MONTHNAME('2024-7-22') FROM DUAL;
SELECT DAYOFWEEK(NOW()) FROM DUAL;


SELECT EXTRACT(SECOND FROM NOW()) FROM DUAL;

SELECT NOW(),DATE_ADD(NOW(),INTERVAL 1 YEAR) FROM DUAL;
SELECT NOW(),DATE_SUB(NOW(),INTERVAL 2 YEAR) FROM DUAL;


SELECT DATE_ADD(NOW(),INTERVAL '1_1' YEAR_MONTH) FROM DUAL;

SELECT last_name, salary, IF(salary>=6000,'高薪','低能') AS "result" FROM `employees`;
SELECT last_name , salary, IF(`commission_pct`IS NOT NULL,`commission_pct`,0) AS "result",
salary*12*(1+IF(`commission_pct` IS NOT NULL , `commission_pct` , 0))AS "total" FROM `employees` ;

-- ifnull的使用
SELECT last_name,`commission_pct`,IFNULL(`commission_pct`,0) AS "result" FROM `employees`;

-- case when

SELECT last_name, salary , CASE WHEN salary >=15000 THEN '精英阶层'
			   WHEN salary >=10000 THEN '高收入'
			   WHEN salary >= 8000 THEN '潜力股'
			   ELSE '无' END '结果',`department_id`
                       FROM `employees`;


-- 练习
SELECT `employee_id` , last_name ,`department_id`,salary ,
	CASE `department_id` WHEN 10 THEN `salary`*1.1
			     WHEN 20 THEN `salary`*1.2
			     WHEN 30 THEN `salary`*1.3
			     ELSE `salary`*1.4 END "result"
			     FROM `employees`;


-- mysql中的加密函数
SELECT PASSWORD('admin') FROM DUAL;
SELECT MD5('mysql') FROM DUAL;
SELECT SHA('mysql') FROM DUAL;

-- mysql的信息函数
SELECT VERSION() FROM DUAL; -- mysql服务器的版本号
SELECT CONNECTION_ID() FROM DUAL;
SELECT DATABASE(),SCHEMA() FROM DUAL;
SELECT USER(),CURRENT_USER(),SYSTEM_USER() FROM DUAL;

SELECT FORMAT(123.125,2)FROM DUAL;
SELECT CONV(16,10,2) FROM DUAL;

-- 分组
SELECT department_id, AVG(salary) AS "平均工资" , MAX(salary) AS "最高工资"
FROM `employees` GROUP BY `department_id`;

-- 需求： 查询各个job_id的平均工资
SELECT job_id , AVG(salary) FROM `employees` GROUP BY `job_id`;

-- 两个组一块查
SELECT department_id, job_id, AVG(salary) AS "平均工资" FROM employees GROUP BY department_id ,job_id;

-- having 分组之后的过滤，必须跟在group关键字后面
SELECT department_id , MAX(salary) FROM employees GROUP BY `department_id` HAVING MAX(salary) > 10000;

-- 练习 ： 查询部门id为10，20，30，40这4个部门中最高工资比10000高的部门信息。
SELECT `department_id`,MAX(salary) FROM `employees`  WHERE `department_id` IN (10,20,30,40) GROUP BY `department_id` 
HAVING MAX(salary) > 10000;






