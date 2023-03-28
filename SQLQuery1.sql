  create database P135


use P135

create view getCustomersById
as
select * from Customers where Id = 1

select * from getCustomersById




create function SayHelloWorld()
returns nvarchar(50)
as
BEGIN
	return 'Hello World' 
END


select dbo.SayHelloWorld()



create function dbo.writeWord(@word nvarchar(20))
returns nvarchar(50)
as
BEGIN
	return @word
END


declare @word nvarchar(20)= 'P135'

select dbo.writeWord(@word)




create function dbo.writeWordsWithTwoParametr(@word nvarchar(20), @source nvarchar(20))
returns nvarchar(50)
as
BEGIN
	return @word + @source
END

select dbo.writeWordsWithTwoParametr('Ali','P135') as 'Data'




create function dbo.sumOfNumbers(@num1 int, @num2 int)
returns nvarchar(50)
as
BEGIN
	return @num1 + @num2
END

select dbo.sumOfNumbers(5,10)




create function dbo.getCustomerCount()
returns int
as
BEGIN
	declare @count int
	select @count = COUNT (*) from Customers
	return @count
END

select dbo.getCustomerCount()




create function dbo.getCustomerAvarageAgeById(@id int)
returns int
as
BEGIN
	declare @avgAge int
	select @avgAge = AVG (Age) from Customers where Id > @id
	return @avgAge
END

select * from Customers

select dbo.getCustomerAvarageAgeById(4)




 create procedure usp_SayHelloWorld
 as
 BEGIN
	print 'Hello world'
 END


 exec usp_SayHelloWorld



 create procedure usp_sumOfNums
 @num1 int,
 @num2 int
 as
 BEGIN
	print @num1 + @num2
 END


 exec usp_sumOfNums 5, 8



 create procedure usp_addCustomer
 @name nvarchar(50),
 @surname nvarchar(50),
 @age int
 as
 BEGIN
	insert into Customers([Name],[Surname],[Age])
	values(@name,@surname,@age)
 END

 exec usp_addCustomer 'Anar','Aliyev',27





  create procedure usp_deleteCustomer
 @id int
 as
 BEGIN
	delete from Customers where Id = @id
 END

 exec usp_deleteCustomer 3




   create procedure usp_deleteCustomerAndShowDatas
 @id int
 as
 BEGIN
	delete from Customers where Id = @id
	select * from Customers
 END

 exec usp_deleteCustomerAndShowDatas 8









 create table Users(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50),
	[Age] int,
	[IsDelete] bit
 )



create procedure usp_deleteUsersByIsDelete
@id int
as
BEGIN
	update  Users set IsDelete = 'true' where Id= @id
	select * from Users where IsDelete = 'false'
END


exec usp_deleteUsersByIsDelete 4



create procedure usp_searchOperation
@text nvarchar(100),
@search nvarchar(10)
as
BEGIN
	declare @num int
	select @num = CHARINDEX(@search, @text)

	if @num > 0 
		print 'Yes'
	else
		print 'No'
END

exec usp_searchOperation 'Inter', 'I'
 




 create table UserLogs(
	[Id] int primary key identity(1,1),
	[UserID] int,
	[Operation] nvarchar(10),
	[Date] datetime
 )



 create trigger trg_insertUser on Users
 after insert
 as
 BEGIN
	--burada, deyisiklik etdiyimiz tabledeki deyisiklikleri diger tableye (yeni, userlogs-a) elave edirik
	insert into UserLogs([UserId],[Operation],[Date])
	select Id,'Insert',GETDATE() from inserted
 END



 create procedure usp_insertUser
 @name nvarchar(20),
 @age int
 as
 BEGIN
	insert into Users([Name],[Age])
	values (@name,@age)
 END


 exec usp_insertUser 'Ceyhun', 23


 create trigger trg_deleteUser on Users
 after delete
 as
 BEGIN
	insert into UserLogs([UserId],[Operation],[Date])
	select Id,'Delete',GETDATE() from deleted
 END

 delete from Users where Id = 1




 
 create trigger trg_updateUser on Users
 after update
 as
 BEGIN
	insert into UserLogs([UserId],[Operation],[Date])
	select Id,'Update',GETDATE() from deleted
 END



update Users
set [Age] = 30 where Id = 3

update Users
set [Name] = 'Alekber' where Id = 3

select * from UserLogs where UserID = 3
