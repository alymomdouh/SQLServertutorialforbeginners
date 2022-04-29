--v1 connect sql server 2014
--v2 create alter drop database 
--v3 create table 
--v4   default constraint   ****************
--v5 cascading constraint   *************
--v6 check constraint       **********
--v7 identity columns      *************
--      insert seset  very important 
--v8 how to get the last generated identity column value    **************
--v09  unique key constraint 
--v10 select statement  ,top 
--v11 group by 
--v12     joins  
--v13 advanced join 
--v14 self join 
--      (inner self join,outer self join(left,right,full),cross self join)

--v15 different ways to replace null   *****************
--        isnull() function      select ISNULL(null,'No Manager');
--        case statement       case when expression then '' else '' end 
--        coalesce() function   select coalesce(null,'No Manager' )as 'column name';
--v16 coalesce() function 
--            coalesce(firstname,middlename,lastname)    return the first non null value  
--v17 union  and union all 
--    union get data   and delete duplicate rows ,distinct sort to remove duplicate rows 
--    union all get all data also  duplicate rows 
-- v18  stored procedures 
--      is group of t-sql(transact sql) statement 
--v19  stored procedures ( without paramerters )
--  use out ,output parameteris 
--- v20   stored procedures output parameters or return values 
----v21 advantages of using stored procedures
---  v22 built in string functions in sql server
--- v23 built in string functions in sql server part2 
---  LEFT right CHARINDEX  SUBSTRING  len(..) count(..)
---v24 built in string functions in sql server part2 
---  REPLICATE  SPACE  REPLACE  PATINDEX  STUFF 
---v25  datetime functions in sql server 
--- time hh:mm:ss[nnnnn],date   yyyy-mm-dd  ,datetimeoffset
---smalldatetime yyyy-mm-dd hh:mm:ss,datetime yyyy-mm-dd hh:mm:ss [nnnnn]
----  getdate(),sysdatetime(),getutcdate() 
--- current_timestamp
----v26   datetime functions in sql server part2 
---	isdate()return 0  or 1 ,day(),month(),year(), datename()
--	select DATENAME(HOUR,GETDATE());--(Q,SECOND,MONTH,YEAR,DAY,DY,WEEKDAY,MM,ISO_WEEK)
--v27   datetime functions in sql server part3
select DATEPART(MM,'2012-08-30 19:23:31.621');--day month
select DATEADD(DAY,10,'2012-08-30 19:23:31.621');
select DATEDIFF(DAY,'2021-8-20',GETDATE())
---full example calcu age very important 
-- v28 cast and convert function 
--select CAST(GETDATE() as varchar(20)) as 'convert date to string';
--select CONVERT(varchar(20),GETDATE(),103);
--select CONVERT(date,GETDATE(),103);
---v29   mathematical functions 
--abs,ceiling,floor,power(5,2),rand,square,sqrt,round 
---v30 user defined function     3 types
--1-scalar function in this video 
--may have or not have paramenters ,return only single value
go
create function funname (@par1 int,@par2 int )
returns int 
as
begin
  declare @x int =4;
  ---any code 
   return @x;
end
--2-inline value function
--3-multi statement table value function 
--v31 inline table valued functions 
---inline table valued functions return only table
go
 create function xxx(@gen varchar(20))  
 returns table
 as
 return (select * from  dbo.spt_values where dbo.spt_values.name=@gen )
  go
  select * from xxx('dddd')
 --v32 multi statement table value function
		 go
		 create function multist (@x int)
		 returns @table table (id int ,[name] varchar)
		 as 
		 begin 
		   insert into @table select id,name from dbo.multist;
		   return 
		end 
		--- difference between all type of functions 
--v33 important concepts related to functions 
		---deterministic function  -----count(),pow,avg()----        åì ÏÇáå ßá ãÑÉ ÇäÏå ÚáíåÇ ÊÚØì äÝÓ  ÇáÞíã ãÇáã íÛíÑ Ýì ÇáÌÏæá ÇáÇÓÇÓì 
		----nondeterministic   getdate(),rand(),current_timestamp()       åì ÏÇáÉ ÊÛíÑ ßá ãÑÉ æáÇ ÊÚãÏ Úáì Çì ÌÏæá æáÇ Çì ÍÇÌÉ 
		--sp_helptext funname
		--  with encryption     --protect function 
--		with schemaBinding  --use in function to prevent user from drop table make on it function or use this table a function 
--v34 temporary tables 
      ---- create in db tempdb 
	  ----- types is (local temporary table)(golabel temporary table)
	  ----local      
	  create table #name(id int,name varchar(20))
	  -----         insert into #name values(..)
	  select * from tempdb..sysobjects where name like '#name%';
	  select name from tempdb..sysobjects where name like '#name%'
	  ----if make temp table inside proc and call this table from outside will undifinded only inside proc
	  ---can make 2 two in same name in different seeion
	  ---- globalel table   create table ##name(id int,name varchar(20))
	  ----drop when close all conection 
	   -----difference between local ,dlobal table 
--v35 indexes 
		---why  ,example use index
		---use in table or in view 
		----types of inexes 
--v36 clustered and non clustered indexes 
		---types   10 
		-----clustered,nonclustered,unique,filtered,xml,fulltext
		-----spatial ,columnstore,indexwith include columns,index on computed columns
		--in this video  clustered,nonclustered
		---clustered index is only for primary key and only one in table and automatic order the data
		--execute sp_helpindex tablename
		---any table have only one cluster index and any number of nonclustered index
		-- create composite clustered index 
		--create clustered index index_table_attr1_attr2 on tablename (attr1 desc,attr2 asc);
		--create nonclustered index index_table_cloumn on tablename (columnsname);
		---- difference between  clustered,nonclustered
		---clustered is faster than nonclustered
		--clustered is 1 in table nonclustered more than 1 in table 
--v37  unique & non-unique indexes
		--by default PK constraint create unique cluster index
		--execute sp_helpindex tablename ;--view index details 
		--drop index tablename.indexname;
		--create unique nonclustered index unindex_table_first_lastname on employee (firstname,lastname);
		--alter table tablename add constraint unq_table_city unique (cite);
--v38   advantages and disadvantages of indexes 
         --
--v39 views  
         --create view viewname as  select * from  dbo.Course;
	     --  sp_helptext  viewname ;
		 --alter , drop view 
--v40 updateable views 
		-- if want to update,insert,delete multi table not use view use trigger is better 
--v41  indexed views  
        --create view viewname with schemabinding as select * from Student where St_Id=6;
		---guideline for creating indexed view 
		----1- view must have schemabinding
		----2- if there aggreate function in select list replace it by 0 
		----3-if there group by must use count_big(*)
		--create unique clustered index unqindex_viewname_atrrname on viewname (attr);
--v42    view limitations 
        -- not take parameters --->   can use  table value functions
		--- rules and default cant use with views 
		--can not use order by unless use top ,for, offset
		----view cannot on it temporary table on it 
--v43 dml trigger 
        ---- typesof trigger   3types
		--1--dml trigger     2- ddl  trigger    3- logon trigger 
		--dml trigger fired automati to event (insert, update,delete)
		--dml trigger classified into 2 types 
		--1- after trigger(sometimes called as for trigger)
		--2- instead of triggers 
		--- in this video only after trigger
		--create trigger triggname on tablename after insert as begin   end
--v44 dml trigger   (after update)
         --select * from deleted
		 ---select * from inserted
--v45 instead of insert trigger
		-- not make action(insert) make trigger 
		--view can not update multi table 
		--make raiserror for user 
----v46   instead of update trigger 
--        -- make view update 2 table  important 
----v47  instead of delete trigger
        -- make view delete from 2 table  important 
--v48  derived tables & cte 
		--  cte=comman table expressions 
		--  
		--example is(join from 2 tables into new table by) sol it by 
		--(view ,temp table ,table variable ,derived table ,cte )
--v49 cte  all about cte 
--v50  updatable ctes
		-- cte can update the base table  yes on one table base 
		---cte can update the base table  yes on join two table base it update only in one not 2 
		---cte can update the base table  no on join two table base it if update make effect in 2 table 
--v51   recursive cte 
        --- example emmployee and manager  very important level degree in work 
--v52   database normalization 
		--********** not view **********
--v53      2nf & 3nf    
		--********** not view **********
--v54  pivot in sql server 2008            very  very very important video 
		--pivot operator is sql server operator used to turn unique values from one column into multiple columns in the output
---v55 error handling in sql server 2000
      -----Error Handling in  SQL Server 2000 ==>     @@Error 
      -----Error Handling in  SQL Server 2005 & later ==> Try Catch 




