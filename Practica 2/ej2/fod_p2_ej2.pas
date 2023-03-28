program fod_p2_ej2;

const valoralto = 9999;

type
	alumno = record
		nombre, apellido: string;
		codigo, matSinFinal, matConFinal: integer;
	end;
	
	materia = record
		codigo: integer;
		aprobo: boolean; // true con final // false sin final
	end;
	
	maestro =  file of alumno;
	
	detalle = file of materia;


procedure leer(var det: detalle; var dato: materia);
begin
	if not(eof(det)) then
		read(det, dato)
	else
		dato.codigo:= valoralto;
end;

procedure actualizar(var mae: maestro; var det: detalle);
var
	regm: alumno;
	regd: materia;
	aux, totalConFinal, totalSinFinal: integer;
begin
	reset(mae);
	reset(det);
	read(mae, regm);
	leer(det, regd);
	while (regd.codigo <> valoralto) do begin
		aux:= regd.codigo;
		totalConFinal:= 0;
		totalSinFinal:= 0;
		while (regd.codigo = aux) do begin
			if (regd.aprobo) then
				totalConFinal:= totalConFinal + 1
			else
				totalSinFinal:= totalSinFinal + 1;
			leer(det, regd);
		end;
		while (aux <> regm.codigo) do 
			read(mae, regm);
		regm.matSinFinal:= regm.matSinFinal + totalSinFinal;
		regm.matConFinal:= regm.matConFinal + totalConFinal;
		seek(mae, filepos(mae) - 1);
		write(mae, regm);
	end; 
	close(mae);
	close(det);
end;

procedure listar(var mae: maestro);
var
	reg: alumno;
	alumnos: Text;
begin	
	assign(alumnos, 'alumnos');
	reset(mae);
	rewrite(alumnos);
	while not(eof(mae)) do begin
		read(mae, reg);
		if (reg.matSinFinal > 4) then begin
			writeln('ALUMNO');
			writeln(alumnos, 
					'Codigo: ', reg.codigo,
					' Nombre: ', reg.nombre);
			writeln(alumnos,				
					'MatConFinal: ', reg.matConFinal,
					' MatSinFinal: ', reg.matSinFinal,
					' Apellido: ', reg.apellido);
		end;
	end;
	close(mae);
	close(alumnos);
end;

procedure menu(var mae: maestro; var det: detalle);
var
	opcion: integer;
begin
	writeln('Seleccione una opcion');
	writeln('1. Actualizar archivo maestro');
	writeln('2. Listar en un archivo de texto alumnos que tengan mas de 4 materias aprobadas sin final');
	readln(opcion);
	case opcion of
		1: actualizar(mae, det);
		2: listar(mae);
	end;	
end;

	
var
	mae: maestro;
	det: detalle;
	
begin
	assign(mae, 'maestro');
	assign(det, 'detalle');
	menu(mae, det);
end.
