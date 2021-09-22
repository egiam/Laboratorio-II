--Clase 2/09

create view vis_clientes_3
as
select	cod_cliente, ape_cliente+' '+nom_cliente as nombre, calle+' '+trim(str(altura))+' B° '+barrio
from	clientes c join barrios b on c.cod_barrio = b.cod_barrio

create proc pa_clientes_facturas
	@nombre varchar(25) = '%'
as
select *
from	vis_clientes vc join facturas f on vc.Codigo = f.cod_cliente
where	year(fecha) = year(getdate()) and
		Nombre like @nombre

exec pa_clientes_facturas 'a%'

select *
from sysobjects
where xtype = 'p'

set dateformat dmy
select DATEDIFF(day, '31/1/2021', getdate())

create function f_div(@num1 int, @num2 int)
	returns decimal(10,4)
as
begin
	return @num1/@num2
end

select dbo.f_div(10,2)

create function f_dif(@num1 int, @num2 int)
	returns int
as
begin
	return @num1 - @num2
end

select dbo.f_dif(10,3)

create function f_mult(@num1 int, @num2 int)
	returns int
as
begin
	return @num1*@num2
end

select dbo.f_mult(10,2)



