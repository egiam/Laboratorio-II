
--Clase 16/09
--Manejo de errores
begin try
	
end try

begin catch
	
end catch

select * from barrios

begin try
	insert into barrios values(1,'Nva. Cba') --Da error
	insert into barrios values(13,'Nva. Cba') --No da error
end try
begin catch
	print 'No se puede repetir el cod_barrio'
	select ERROR_NUMBER(), ERROR_MESSAGE()
end catch


--Guia 2 Ejercicio 2.2 Manejo de errores
--2.2.1 
Create view vista_vendedores
as
SELECT fecha FECHA, f.nro_factura as numero_factura,v.cod_vendedor as codigo_vendedor, nom_vendedor+' '+ape_vendedor as
nombre_vendedor, a.descripcion as articulo, cantidad as cantidad, d.pre_unitario * cantidad as importe
FROM vendedores v join facturas f on v.cod_vendedor = f.cod_vendedor
join detalle_facturas d on f.nro_factura = d.nro_factura
join articulos a on a.cod_articulo = d.cod_articulo
WHERE YEAR(fecha) = YEAR(getdate())

select* from vista_vendedores

begin try
select*
from vista_vendedores
end try
begin catch
select 'No se puede ver la vista correctamente',
ERROR_MESSAGE(),
ERROR_NUMBER() AS ErrorNumber,
ERROR_LINE() AS ErrorLine
end catch


--2.2.2 
Create view vista_vendedores
as
SELECT fecha FECHA, nro_factura NRO_FACTURA, cod_vendedor COD_VENDEDOR, nom_vendedor+' '+ape_vendedor
NOMBRE_VENDEDOR, descripción ARTICULO, cantidad CANTIDAD, pre_unitario * cantidad IMPORTE
FROM vendedores v join facturas f on v.cod_vendedor = f.cod_vendedor
join detalle_facturas df on f.nro_factura = df.nro_factura
join articulos a on a.cod_articulo = df.cod_articulo
WHERE YEAR(fecha) = YEAR(getdate())

begin try
SELECT fecha FECHA, nro_factura NRO_FACTURA, cod_vendedor COD_VENDEDOR, nom_vendedor+' '+ape_vendedor
NOMBRE_VENDEDOR, descripcion ARTICULO, cantidad CANTIDAD, pre_unitario * cantidad IMPORTE
FROM vendedores v join facturas f on v.cod_vendedor = f.cod_vendedor
join detalle_facturas df on f.nro_factura = df.nro_factura
join articulos a on a.cod_articulo = df.cod_articulo
WHERE YEAR(fecha) = YEAR(getdate())
end try
begin catch
select 'se produjo un error',
error_number() as Numero,
error_state() as Estado,
ERROR_SEVERITY() as Gravedad,
ERROR_PROCEDURE() as Procedimiento,
ERROR_LINE() as Linea,
ERROR_MESSAGE() as Mensaje;
end catch;


--2.3.f
create proc pa_articulo_busqueda
	@art varchar(100),
	@nombre varchar(100) output
as
begin try
	select @nombre=descripcion
	from articulos
	where descripcion like @art+'%'
end try
begin catch
	select 'Existen varios articulos con ese nombre'
end catch

--Ejecutar el procedimiento
declare @a varchar (100)
execute pa_articulo_busqueda Carpeta,@a output
select @a as Articulo


--2.5.1
create table #ventas
(id int identity (1,1),
nro_factura int,
fecha datetime,
vendedor varchar(100),
cliente varchar(100)
)

create procedure pri_ulti_venta
as
declare @nro_factura int, @fecha datetime, @vendedor varchar(100), @cliente varchar(100)

select top 1 @nro_factura = nro_factura, @fecha = fecha, @vendedor = v.nom_vendedor
     + ' ' + v.ape_vendedor,@cliente = c.nom_cliente + ' ' + c.ape_cliente
from facturas f
     join clientes c on c.cod_cliente = f.cod_cliente
     join vendedores v on v.cod_vendedor = f.cod_vendedor
order by fecha asc

insert into #ventas values(@nro_factura, @fecha, @vendedor, @cliente)

select top 1 @nro_factura = nro_factura, @fecha = fecha,@vendedor = v.nom_vendedor
     + ' ' + v.ape_vendedor,@cliente = c.nom_cliente + ' ' + c.ape_cliente
from facturas f
     join clientes c on c.cod_cliente = f.cod_cliente
     join vendedores v on v.cod_vendedor = f.cod_vendedor
order by fecha desc

insert into #ventas values(@nro_factura, @fecha, @vendedor, @cliente)



execute pri_ulti_venta

select * from #ventas


--2.5.2
select * from facturas

create table #Fimpares(
id_impar int identity(1,1),
nro_factura int,
fecha datetime,
cod_cliente int,
cod_vendedor int
)

alter proc pa_impar
as
begin
	declare @cantidad int
	select @cantidad = count(cod_cliente) from facturas
	while @cantidad != 0
	begin
		declare @nroFact int, @fecha datetime, @cliente int,@vendedor int
		select @nroFact = nro_factura,@fecha = fecha,@cliente = cod_cliente, @vendedor = cod_vendedor from facturas
		where (day(fecha)%2) = 1
		insert into #Fimpares values(@nroFact,@fecha,@cliente,@vendedor)
		set @cantidad = @cantidad - 1
	end
end

exec pa_impar
select * from #Fimpares
select cod_cliente from facturas where (day(fecha) % 2) = 1
select count(cod_cliente) from facturas


--Triggers
create trigger dis_nvo_barrio
on barrios
for insert
as
	print 'Se inserto un nuevo barrio', cod_barrio,barrio
	from inserted

create trigger dis_eliminar_barrio
on barrios
for delete
as
	print 'Se elimino un barrio',barrio
	from deleted

create trigger dis_actualizar_art
on articulos
instead of update
as
	if update(pre_unitario)
	begin
		print 'No se puede modificar el precio del articulo'
	end
	else
	begin
		update articulos
		set descripcion=(select descripcion from inserted),
			stock=(select stock from inserted),
			stock_minimo=(select stock_minimo from inserted),
			pre_unitario(select pre_unitario from inserted),
			observaciones=(select observaciones from inserted)
		where cod_articulo = (select cod_articulo from inserted)
		print 'Ha modificado la tabla articulos'
	end




