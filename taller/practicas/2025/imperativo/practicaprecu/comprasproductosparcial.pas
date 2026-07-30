//MrStore requiere procesar las compras realizadas por sus clientes durante el año 2024.

//a) Implementar un módulo que lea compras de productos. De cada compra se lee código del producto, código de
//cliente, día y mes. La lectura finaliza con el código de cliente 0. Se sugiere utilizar el módulo leerCompra(). El módulo
//debe retornar un vector donde se almacenen las compras agrupadas por mes. Las compras de cada mes deben quedar
//almacenadas en un árbol binario de búsqueda ordenado por código de producto.
//b) Implementar un módulo recursivo que reciba el vector generado en a) y retorne el mes con mayor cantidad de
//compras.
//c) Implementar un módulo que reciba el vector generado en a), un número de mes y un código de producto, y
//retorne si fue comprado o no el producto ingresado en el mes recibido.
//NOTA: Implementar el programa principal, que invoque a los incisos a, b y c.

program parcialproductos;
Const
	cod_fin= 0;
Type
	compra=record
		cod_prod:integer;
		cod_cliente:integer;
		dia:integer;
		mes:integer;
	end;
	
	procedure leerCompra(var c:compra);
	
