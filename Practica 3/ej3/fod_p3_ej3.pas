program fod_p3_ej3;


type
	novela = record
		codigo, duracion: integer;
		genero, nombre, director: string;
		precio: real;
	end;
	
	maestro = file of novela;


procedure crearArchivo(var mae: maestro);
var
	reg: novela;
begin
	assign(mae, 'maestro');
	rewrite(mae);
	reg.codigo:= 0;
	write(mae, reg);
	leerNovela(reg);
	while (reg.codigo <> 0) do begin
		write(mae, reg);
		leerNovela(reg);
	end;
	close(mae);
end;

procedure agregarNovela(var mae: maestro);
var
	n, reg: novela;
begin
	leerNovela(n);
	if (n.codigo > 0) then begin
		reset(mae);
		read(mae, reg);
		if(reg.codigo <> 0) then begin
			seek(mae, Abs(reg.codigo));
			read(mae, reg);
			seek(mae, filepos(mae)-1);
			write(mae, n);
			seek(mae, 0);
			write(mae, reg);
		end else begin
			seek(mae, filesize(mae));
			write(mae, n);
		end;
		close(mae);
		writeln('Novela registrada');
	end else
		writeln('Codigo de novela invalido');
end;

procedure eliminarNovela(var mae: maestro);
var
	cod, pri: integer;
	reg: novela;
begin
	readln(cod);
	reset(mae);
	read(mae, reg);
	pri:= reg.codigo;
	while not eof(mae) and (reg.codigo <> cod) do begin
		read(mae, reg);
	end;
	if not eof(mae) do begin
		seek(f, filepos(f)-1);
		reg.code:= pri;		
		pri:= filepos(mae)*(-1);
		write(mae, reg);		
		seek(mae, 0);
		reg.codigo:= pri;
		write(mae, reg);
		writeln('Novela eliminada')
	end else
		writeln('Codigo de novela no encontrado');
	close(mae);
end;

procedure menu(var mae: maestro);
var
	opcion: integer;
begin
	writeln('Ingrese una opcion');
	writeln('1 - Crear archivo');
	writeln('2 - Modificar archivo');
	writeln('3 - Exportar a texto');
	writeln('4 - Cerrar consola');
	readln(opcion);
	while (opcion < 4) do begin		
		case opcion of
			1: crearArchivo(mae);
			2: begin
				writeln('1 - Agregar novela');
				writeln('2 - Modificar novela');
				writeln('3 - Remover novela');
				writeln('4 - Salir al menu principal');
				case opcion of
					1: agregarNovela(mae);
					2: modificarNovela(mae);
					3: eliminarNovela(mae);
					4: menu(mae);
				end;
			end;
			3: exportarTxt(mae);			
		end;
	end;
end;

	
var
	mae: maestro;

begin
	menu(mae);
	crearArchivo(mae);	
end.
