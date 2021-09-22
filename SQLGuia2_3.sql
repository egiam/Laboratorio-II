--Guia 2.3

--1.a
create proc pa_arti_may
	@valor1 int
as
begin
	select *
	from articulos
	where pre_unitario >= @valor1
end

exec pa_arti_may 400


--1.b
create proc pa_arti_nuevo
	@descripcion nvarchar(50) = '',
	@stock_m int = 30,
	@stock int = 50,
	@precio decimal(10,2) = 100,
	@observaciones nvarchar(50) = ''
as
begin
	if @stock > 30 and @stock < 100
		begin
		insert into articulos values(@descripcion,@stock_m,@stock,@precio,@observaciones)
		select 'Ingreso completo'
		end
	else
		select 'El stock es menor a 30 o mayor a 100'
end

exec pa_arti_nuevo 'Lapiz',30,105,100,'Lapices'


--1.c
create proc pa_reponer
	@codigo int
as
begin
	if exists(select stock from articulos where @codigo = cod_articulo and stock = 0)
		select 'Reponer stock'
	else
		select 'No hace falta reponer stock'
end

exec pa_reponer 6


--1.d
create proc pa_actualizar
	@precio decimal(10,2)
as
begin
	update articulos
	set pre_unitario = @precio
	where @precio > pre_unitario
end

exec pa_actualizar 10


--1.e
create proc pa_cliente
as
begin
	select top 1 nom_cliente 
	from clientes c join facturas f on c.cod_cliente = f.cod_cliente 
	order by fecha
end



--1.f
create proc pa_articulo
	@letra char,
	@nombre varchar(50)
as
begin
	select descripcion 
	from articulos 
	where descripcion like '@letra%'
end


--2.a
--@apellido varchar(50),@nombre varchar(50),@telefono varchar(10),@calle varchar(50),@altura varchar(10),@nombreBarrio varchar(50)
create function f_cadena(@codigo int,@email varchar(50))
	returns varchar(max)
as
begin
	declare @cliente varchar(max)
	if @codigo is not null
		select @cliente = nom_cliente+' '+ape_cliente+' - '+nro_tel+' - '+calle+' - '+altura+' - '+barrio 
		from clientes c join barrios b on c.cod_barrio = b.cod_barrio
		where cod_cliente = @codigo or [e-mail] = @email
	else
		select @cliente = nom_cliente+' '+ape_cliente+' - '+nro_tel+' - '+calle+' - '+altura+' - '+barrio 
		from clientes c join barrios b on c.cod_barrio = b.cod_barrio
		where cod_cliente = @codigo or [e-mail] = @email
	return @cliente
end


--2.b
create function f_devolver(@valor char)
	returns varchar(max)
as
begin
	declare @articulos varchar(max)
	if @valor = 'A'
		select @articulos = cod_articulo+' - '+descripcion+' - '+pre_unitario+' - '+stock+' - '+stock_minimo+' - '+observaciones from articulos order by pre_unitario asc
	else
		if @valor = 'D'
		select @articulos = cod_articulo+' - '+descripcion+' - '+pre_unitario+' - '+stock+' - '+stock_minimo+' - '+observaciones from articulos order by pre_unitario desc
		else
			return 'Valor no correcto'
	return @articulos
end


--2.c
create function f_precio(@aumento decimal(10,2))
	returns decimal(10,2)
as
begin
	declare @precio decimal(10,2)
	declare @total decimal(10,2)
	select @precio = pre_unitario from articulos
	set @total = @precio * (@aumento / 100 + 1)
	return @total
end



