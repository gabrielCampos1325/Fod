program fod_p1_ej5;

type
	celular = record
		cod, stockMin, stockDisp: integer;
		nombre, descripcion, marca: string;
		precio: real;
		end;
	
	archivo =  file of celular;
	

procedure crear(var arch_log: archivo; var arch_carga: Text);
var
	c: celular;
begin		
	reset(arch_carga);
	rewrite(arch_log);
	writeln('ARCHIVO CARGADO');			
	while (not eof(arch_carga)) do begin
		with c do begin
			readln(arch_carga, cod, precio, marca);
			readln(arch_carga, stockMin, stockDisp, descripcion);
			readln(arch_carga, nombre);
		end;
		write(arch_log, c);
	end;	
	close(arch_carga);
	close(arch_log);	
end;

procedure imprimirse(c: celular);
begin
	with c do begin
		writeln('Nombre: ', nombre,
				' Codigo: ', cod,
				' Precio: ', precio:0:2,
				' Marca: ', marca,
				' Stock minimo ', stockMin,
				' Stock disponible ', stockDisp,
				' Descripcion ', descripcion);
		writeln();
	end;
end;

procedure actMenorMin(var arch_log: archivo);
var
	c: celular;
begin
	reset(arch_log);
	while not eof(arch_log) do begin
		read(arch_log,c);
		if (c.stockDisp < c.stockMin) then
			imprimirse(c);
	end;
	close(arch_log);
end;

procedure descripTengaCadena(var arch_log: archivo);
var
	st: string;
	c: celular;
	cont: integer;
begin
	cont:= 0;
	writeln('Ingrese la descripcion a buscar');
	readln(st);
	st:= ' ' + st;
	reset(arch_log);
	while not eof(arch_log) do begin
		read(arch_log, c);
		if (c.descripcion = st) then
			imprimirse(c);
			cont:= cont + 1;
	end;
	if (cont = 0) then
		writeln('No se encontro ningun celular con esa descripcion');
	close(arch_log);
end;

procedure exportar(var arch_log: archivo);
var
	arch_exp: Text;
	c: celular;
begin
	assign(arch_exp, 'celulares2.txt');
	rewrite(arch_exp);
	reset(arch_log);
	while not eof(arch_log) do begin
		read(arch_log, c);
		writeln(arch_exp,				
				'Codigo: ', c.cod,
				' precio: ', c.precio:2:2,
				' marca: ', c.marca);
		writeln(arch_exp,				
				'Stock disp: ', c.stockDisp,
				' stock minimo: ', c.stockMin);
		writeln(arch_exp,				
				'Nombre: ', c.cod);
	end;
	close(arch_exp);
	close(arch_log);	
end;

procedure agregar(var arch_log: archivo);
				
		procedure leer(var c: celular);
		begin
			writeln('Ingrese el nombre');
			readln(c.nombre);
			if (c.nombre <> '') then begin
				writeln('Ingrese el cod');
				readln(c.cod);
				writeln('Ingrese el precio');
				readln(c.precio);
				writeln('Ingrese el marca');
				readln(c.marca);
				writeln('Ingrese el stock disp');
				readln(c.stockDisp);
				writeln('Ingrese el stock min');
				readln(c.stockMin);
				writeln('Ingrese la descripcion');
				readln(c.descripcion);
			end;	
			writeln();		
		end;

var
	c: celular;
begin
	reset(arch_log);
	seek(arch_log, filesize(arch_log));
	leer(c);
	while(c.nombre <> '') do begin
		write(arch_log, c);
		leer(c);
	end;
	close(arch_log);
end;

procedure modificar(var arch_log: archivo);
var
	c: celular;
	cod, nuevoStock: integer;
	ok: boolean;
begin
	reset(arch_log);
	writeln('Ingrese el cod');
	readln(cod);
	ok:= false;
	while not eof(arch_log) and not(ok) do begin
		read(arch_log, c);
		if (c.cod = cod) then begin
			ok:= true;
			writeln('Ingrese el nuevo stock');
			readln(nuevoStock);
			c.stockDisp:= nuevoStock;
			seek(arch_log, filePos(arch_log) - 1);
			write(arch_log, c);
		end;
	end;
	if (ok) then
		writeln('Modificado correctamente')
	else
		writeln('No se encontro el celular');
	close(arch_log);
end;

procedure menu(var arch_log:archivo; var arch_carga: Text);
var
	opcion: integer;
	ok: boolean;	
begin
	ok:= true;
	while (ok) do begin
		writeln('Seleccione una opcion');
		writeln('1. Crear archivo binario a partir de un archivo de carga');
		writeln('2. Imprimir celulares cuyo stock actual es menor al stock minimo');
		writeln('3. Imprimir celulares cuyo descripcion tenga una cadena proporcionada por el usuario');
		writeln('4. Exportar archivo binario a un archivo de texto');
		writeln('5. Agregar celulares al final del archivo');
		writeln('6. Modificar celular en el archivo');
		writeln('9. Salir del menu');
		readln(opcion);
		case opcion of
			1: crear(arch_log, arch_carga);
			
			2: actMenorMin(arch_log);
			
			3: descripTengaCadena(arch_log);
			
			4: exportar(arch_log);
			
			5: agregar(arch_log);
			
			6: modificar(arch_log);
		else 
			ok:= false;
		end;
	end;
end;


var
	arch_log: archivo;
	arch_carga: Text;
	nombre: string;
	
begin
	writeln('Ingrese nombre del archivo binario');
	readln(nombre);
	assign(arch_log, nombre);	
	
	writeln('Ingrese nombre del archivo de carga');
	readln(nombre);
	assign(arch_carga, nombre);
	
	menu(arch_log, arch_carga);		
end.


