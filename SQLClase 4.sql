--Clase 9/09

--Declarar una variable - Son locales
declare @opc varchar(1) = 'C'
set @opc = 'V'
if @opc='C'
	begin
		select * from clientes
		select 'Comando ejeguctado correctamente.'
	end
else
	if @opc = 'V'
	begin
		select * from vendedores
		select 'se mostro el listado de vendedores.'
	end
	else
		print 'Opcion Incorrecta'



declare @num int,@suma int
set @num = 5
while @num >= 0
	begin
		set @suma = @suma+@num
		set @num = @num - 1
	end
select @suma as 'Sumatoria'


select month(getdate()) as 'nro de mes', nombre = 
	case month(getdate())
		when 1 then 'Enero'
		when 2 then 'Febrero'
		when 9 then 'Septiembre'
		else 'Otro Mes'
	end



--guia de ejercicios:


--4
declare @num1 int, @num2 int, @suma1 int
set @num1 = 5
set @num2 = 10

if @num1 = @num2
	select 'Los numeros son iguales'
else
	begin
		select 'La suma de ambos numeros es de: '
		set @suma1 = @num1 + @num2
		select @suma1 as 'Sumatoria'
	end



--1
alter proc pa_ejercicio_1
	@codigo int,
	@stock int = 0,
	@stockMinimo int = 0
as
begin
	select @stock=stock, @stockMinimo= stock_minimo
	from articulos
	where cod_articulo = @codigo
	select @stock stock, @stockMinimo 'Stock Minimo'
end

exec pa_ejercicio_1 4

	

