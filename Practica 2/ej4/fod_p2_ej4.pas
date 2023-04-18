program fod_p2_ej4;
uses crt;

const
	valoralto = 9999;
	n = 5;
	
type
	fecha = record
		dia, mes, anio: integer;
	end;	
	
	sesion = record
		cod_usuario, tiempo_sesion: integer;
		fecha: fecha;
	end;	
	
	detalle = file of sesion;
	
	maestro = file of sesion;
	
	vectorDetalles = array [1..n] of detalle;
	
	vectorRegistros = array [1..n] of sesion;
	

procedure leer (var archivo: detalle; var dato: sesion);
begin
	if not(eof(archivo)) then
		read(archivo, dato)
	else
		dato.cod_usuario:= valoralto;
end;

procedure minimo(var vD: vectorDetalles; var vR:vectorRegistros; var min: sesion);
var
	i, pos: integer;
begin
	min.cod_usuario:= valoralto;
	pos:= 0;
	for i:= 1 to n do begin
		if (vR[i].cod_usuario <> valoralto) then begin
			if (vR[i].cod_usuario < min.cod_usuario) then begin
				min:= vR[i];
				pos:= i;
			end;
		end;
	end;
	if (pos <> 0) then
		leer(vD[pos], vR[pos]);
end;

procedure crearMaestro(var mae: maestro; var vD: vectorDetalles); // aunque no lo necesite devolver es encesario por el var vD?
var
	vR: vectorRegistros;
	min, actual: sesion;
	i: integer;
begin
	rewrite(mae);
	for i:= 1 to n do begin
		reset(vD[i]);
		leer(vD[i], vR[i]);
	end;
	minimo(vD, vR, min);
	while (min.cod_usuario <> valoralto) do begin
		actual.cod_usuario:= min.cod_usuario;
		while (actual.cod_usuario = min.cod_usuario) do begin
			actual.tiempo_sesion:= 0;
			actual.fecha:= min.fecha;
			while ((actual.cod_usuario = min.cod_usuario) and 
			(min.fecha.dia = actual.fecha.dia) and 
			(min.fecha.mes = actual.fecha.mes) and
			(min.fecha.anio = actual.fecha.anio))do begin
				actual.tiempo_sesion:= actual.tiempo_sesion + min.tiempo_sesion;
				minimo(vD, vR, min);
			end;
			write(mae, actual);
		end;
	end;
	for i:= 1 to n do 
		close(vD[i]);
	close(mae);
end;

procedure imprimirReg(r: sesion);
begin
	with r do begin
		writeln ('CODIGO: ', cod_usuario);
		writeln ('FECHA: ', fecha.dia,'/', fecha.mes,'/', fecha.anio);
		writeln ('TIEMPO TOTAL DE SESIONES ABIERTAS ', tiempo_sesion);
		writeln ('');
	end;
end;
	
procedure imprimirMaestro(var mae: maestro);
var
	reg: sesion;
begin
	reset(mae);
	while not (eof(mae)) do begin
		read(mae, reg);
		imprimirReg(reg);
	end;
	close (mae);
end;
	
var
	mae: maestro;
	vD: vectorDetalles;
	i: integer;
	st: string;

begin
	assign(mae, './var/log/maestro');
	for i:= 1 to n do begin
		Str(i, st);
		assign(vD[i], 'detalle' + st);
	end;
	crearMaestro(mae, vD);
	imprimirMaestro(mae);
end.
