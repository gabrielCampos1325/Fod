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
		writeln('5. Salir del menu');
		readln(opcion);
		case opcion of
			1: crear(arch_log, arch_carga);
			
			2: actMenorMin(arch_log);
			
			3: descripTengaCadena(arch_log);
			
			4: exportar(arch_log);
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


