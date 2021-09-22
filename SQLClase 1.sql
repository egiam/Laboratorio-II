select count(b.barrio) cantidad, b.barrio
from clientes c join barrios b on c.cod_barrio = b.cod_barrio
group by c.cod_barrio, b.barrio
order by cantidad desc


--Ejercicio 10
select top 5 fecha, importe, m.apellido+' '+m.nombre Medico, detalle_consulta
from	consultas c join medico m on c.id_medico = m.id_medico
where	MONTH(fecha) >= month(GETDATE()) - 3 and
		YEAR(fecha) = year(getdate())
order by importe desc


--Consultas con JOIN
select nom_cliente, ape_cliente, barrio
from clientes c join barrios b on c.cod_barrio = b.cod_barrio

select distinct barrio
from	clientes c join barrios b on c.cod_barrio = b.cod_barrio
		join facturas f on c.cod_cliente = f.cod_cliente
		join detalle_facturas df on df.nro_factura=f.nro_factura
		join articulos a on a.cod_articulo = df.cod_articulo
where descripcion like 'a%' and year(fecha) = 2021



