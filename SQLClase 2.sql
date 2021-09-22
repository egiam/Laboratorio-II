--Vistas

create view vis_clientes
as
select cod_cliente codigo, ape_cliente+' '+nom_cliente nombre, calle+' '+str(altura) direccion, barrio, nro_tel as telefono
from clientes c join barrios b on c.cod_barrio = b.cod_barrio

select * from vis_clientes

drop view vis_clientes --eliminar vista

--Facturas con cliente y barrio
select nro_factura, format(fecha,'dd/MM/yyyy'), nombre, barrio
from facturas f join vis_clientes vs on cod_cliente = codigo
where nombre like '[A-G]%'



Create view vis_añopresente
as
select	format(fecha,'dd/MM/yyyy') Fecha, f.nro_factura Nro_Factura, v.cod_vendedor as 'Codigo Vendedor' , ape_vendedor+' '+nom_vendedor as 'Nombre Vendedor', a.descripcion Articulo, df.cantidad Cantidad, df.cantidad*df.pre_unitario as Importe
from	facturas f join vendedores v on f.cod_vendedor=v.cod_vendedor
		join detalle_facturas df on f.nro_factura = df.nro_factura
		join articulos a on df.cod_articulo = a.cod_articulo
where	year(f.fecha) = year(getdate())

select * from vis_añopresente



create view vis_clientes 
as
select cod_cliente Codigo, ape_cliente+' '+nom_cliente Nombre, calle+' '+str(altura) Direccion, barrio, nro_tel as telefono, [e-mail]
from clientes c join barrios b on c.cod_barrio = b.cod_barrio

create view vis_vendedores 
as
select cod_vendedor Codigo, ape_vendedor+' '+nom_vendedor as 'Nombre Vendedor', calle+' '+STR(altura) Direccion, nro_tel Telefono, [e-mail]
from vendedores v join barrios b on v.cod_barrio = b.cod_barrio

select * from vis_vendedores

create view vis_facturas 
as
select f.nro_factura, format(fecha,'dd/MM/yyyy') Fecha, df.cantidad, df.cantidad*df.pre_unitario as Importe
from facturas f join detalle_facturas df on f.nro_factura = df.nro_factura

select * from vis_facturas



--Procedimientos Almacenados
--create procedure
--create proc

create proc pa_articulos2
@precio money
as
select cod_articulo, descripcion, pre_unitario, stock
from articulos
where pre_unitario<@precio

--Para verlo tenes q ejecutarlo, esto ya no es una tabla, sino un pequeño programa
exec pa_articulos2 @precio=100


create proc pa_facturas
@anio1 int,
@anio2 int
as
select nro_factura, fecha, ape_vendedor+' '+nom_vendedor as Vendedor
from facturas f join vendedores v on f.cod_vendedor=v.cod_vendedor
where year(fecha) between @anio1 and @anio2

exec pa_facturas @anio1=2005, @anio2=2010


