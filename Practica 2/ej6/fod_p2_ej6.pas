program fod_p2_ej6;
uses crt;

const
	valoralto = 9999;
	n = 10;
	
type
	municipio = record
		codigo_localidad, codigo_cepa,
		casos_activos, casos_nuevos,
		casos_recuperados, casos_fallecidos: integer;
	end;
	
	ministerio = record
		codigo_localidad, codigo_cepa,
		casos_activos, casos_nuevos,
		casos_recuperados, casos_fallecidos: integer;
		nombre_localidad, nombre_cepa: string;
	end;
	
	maestro = file of ministerio;	
	detalle = file of municipio;
	
	vectorDetalles = array [1..n] of detalle;	
	vectorRegistros = array [1..n] of municipio;


procedure leer(var archivo: detalle; var dato: municipio);
begin
	if not(eof(archivo)) then
		read(archivo, dato)
	else
		dato.codigo_localidad:= valoralto;
end;

procedure minimo(var vD: vectorDetalles; var vR: vectorRegistros; var min: municipio);
var
	i, pos: integer;
begin
	min.codigo_localidad:= valoralto;
	pos:= 0;
	for i:= 1 to n do begin
		if (vR[i].codigo_localidad <> valoralto) then begin
			if (vR[i].codigo_localidad < min.codigo_localidad) or 
			((vR[i].codigo_localidad = min.codigo_localidad) and
			(vR[i].codigo_cepa < min.codigo_cepa)) then begin
				min.codigo_localidad:= vR[i].codigo_localidad;
				pos:= i;
			end;
		end;
	end;
	if (pos <> 0) then
		leer(vD[pos], vR[pos]);
end;

procedure crearMaestro(var mae: maestro; var vD:vectorDetalles);
var
	i: integer;
	min, actual: municipio;
	vR: vectorRegistros;
	regm: ministerio;
begin
	reset(mae);
	for i:= 1 to n do begin
		reset(vD[i]);
		leer(vD[i], vR[i]);
	end;
	minimo(vD, vR, min);
	while (min.codigo_localidad <> valoralto) do begin	
		actual.codigo_localidad := min.codigo_localidad;
		actual.codigo_cepa := min.codigo_cepa;
		actual.casos_fallecidos:= 0;
		actual.casos_recuperados:= 0;
		actual.casos_activos:= 0;
		actual.casos_nuevos:= 0;
		
		while (actual.codigo_localidad = min.codigo_localidad) and
		(actual.codigo_cepa = min.codigo_cepa)do begin
			actual.casos_fallecidos += min.casos_fallecidos;
			actual.casos_recuperados += min.casos_recuperados;
			actual.casos_activos += min.casos_activos;
			actual.casos_nuevos += min.casos_nuevos;
			minimo(vD, vR, min);
		end;
		
		read(mae, regm);
		while (regm.codigo_localidad <> actual.codigo_localidad) do begin
			read(mae, regm);			
		end;
		while (regm.codigo_cepa <> actual.codigo_cepa) do begin
			read(mae, regm);			
		end;
		
		regm.casos_fallecidos += actual.casos_fallecidos; 
		regm.casos_recuperados += actual.casos_recuperados; 
		regm.casos_activos += actual.casos_activos; 
		regm.casos_nuevos += actual.casos_nuevos;
		
		seek(mae, filePos(mae) - 1);
		write(mae, regm); 
	end;
	
	close(mae);
	for i:= 1 to n do 
		close(vD[i]);
end;
	
var
	mae: maestro;
	vD: vectorDetalles;
	i: integer;
	st: string;
	
begin
	assign(mae, 'maestro');
	for i:= 1 to n do begin
		Str(i, st);
		assign(vD[i], 'detalle' + st);
	end;	
	crearMaestro(mae, vD);
	
end.
