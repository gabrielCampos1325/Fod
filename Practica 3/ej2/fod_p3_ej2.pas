program fod_p3_ej2;

const
	valoralto = 9999;
	limite = 1000;
type
	asistente = record
		num, telefono, dni: integer;
		nombre, apellido, mail: string;
	end;
	
	maestro = file of asistente;
	

procedure eliminar(var mae: maestro);
var
	reg: asistente;
begin
	reset(mae);
	while not eof(mae) do begin
		read(mae, reg);
		if (reg.num < limite) then begin
			reg.nombre := '@' + reg.nombre;
			seek(mae, filepos(mae)-1);
			write(mae, reg);
		end;
	end;
	close(mae);
end;

procedure imprimir(var mae: maestro);
var
	reg: asistente;
begin
	reset(mae);
	while not eof(mae) do begin
		read(mae, reg);
		if(pos('@', reg.nombre) = 0) then
			writeln(reg.nombre);
	end;
	close(mae);	
end;

var
	mae: maestro;
	
begin
	assign(mae, 'maestro');
	eliminar(mae);
	imprimir(mae);
end.
