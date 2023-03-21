program fod_p1_ej7;

type
	novela = record
		cod: integer;
		nombre, genero: string;
		precio: real;
		end;

	archivo = file of novela;

procedure crear(var arch_b: archivo; var arch_carga: Text);
var
	n: novela;
begin
	rewrite(arch_b);
	writeln('LLEGO');
	reset(arch_carga);
	writeln('LLEGO');
	while not eof(arch_carga) do begin
		with n do begin
			readln(arch_carga,cod,precio,genero);
			readln(arch_carga,nombre);
		end;
		write(arch_b, n);
	end;
	close(arch_b);
	close(arch_carga);	
end;

procedure leerNovela(var n:novela);		
begin
	writeln('Ingrese el nombre de la novela');
	readln(n.nombre);
	writeln('Ingrese el codigo de la novela');
	readln(n.cod);
	writeln('Ingrese el precio de la novela');
	readln(n.precio);
	writeln('Ingrese el genero de la novela');
	readln(n.genero);
end;

procedure agregarNovela(var arch_b: archivo);	
var
	n: novela;
begin
	reset(arch_b);
	seek(arch_b, fileSize(arch_b));
	leerNovela(n);
	write(arch_b, n);
	close(arch_b);
end;

procedure modificarNovela(var arch_b: archivo);
var
	n, nueva: novela;
	ok: boolean;
begin
	reset(arch_b);
	writeln('Ingrese los nuevos datos de la novela a modificar');
	leerNovela(nueva);	
	ok:= false;
	while not eof(arch_b) and not (ok) do begin
		read(arch_b, n);
		if (n.cod = nueva.cod) then begin
			ok:= true;
			seek(arch_b, filePos(arch_b) - 1);
			write(arch_b, nueva)
		end;			
	end;
	if (ok) then
		writeln('Se modifico exitosamente')
	else
		writeln('No se encontro la novela');
	close(arch_b);
end;

procedure exportarNovelas(var arch_b: archivo);
var
	n: novela;
	arch_novelas: Text;
begin
	reset(arch_b);
	Assign(arch_novelas, 'nove.txt');
	rewrite(arch_novelas);
	while not eof(arch_b)do begin
		read(arch_b, n);
		writeln(arch_novelas,				
				'Codigo: ', n.cod,
				' genero: ', n.genero);
		writeln(arch_novelas,
				'Precio: ', n.precio:2:2,
				' nombre: ', n.nombre);
	end;
	close(arch_b);
	close(arch_novelas);
end;

procedure menu(var arch_b: archivo; var arch_carga: Text);
var
	ok: boolean;
	opc: integer;
begin
	ok:= true;
	while (ok) do begin
		writeln('1. Crear archivo binario');
		writeln('2. Modificar archivo binario');
		writeln('3. Salir de la consola');
		readln(opc);
		if (opc = 1) then 
			crear(arch_b, arch_carga)					
		else if (opc = 2) then begin
			writeln('1. Agregar novela');
			writeln('2. Modificar novela'); 
			readln(opc);
			case opc of
				1: agregarNovela(arch_b);
				2: modificarNovela(arch_b);
			end;
		end else begin
			exportarNovelas(arch_b);
			ok:= false;			
		end;
	end;
end;

var
	arch_b: archivo;
	arch_carga: Text;
	nombre: string;
	
begin
	writeln('Ingrese el nombre del archivo binario');
	readln(nombre);
	assign(arch_b, nombre);
	writeln('Ingrese el nombre del archivo de carga');
	readln(nombre);
	assign(arch_carga, nombre);
	menu(arch_b, arch_carga);
end.
