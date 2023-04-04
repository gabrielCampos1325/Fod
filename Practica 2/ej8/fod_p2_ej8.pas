program fod_p2_ej9;
uses crt;


procedure generarReporte(var mae:maestro);
var
	v,actual:maestroR;
	totalMes: real;
	total: real;
begin
	assign(mae,'maestro.data');
	reset(mae);
	leer(mae,v);
	while (v.cliente.codigo <> valoralto) do begin
		actual:= v;
		writeln('----------------');
		writeln('Cliente numero: ', actual.cliente.codigo);
		writeln('DATOS PERSONALES'); 
		writeln('Nombre: ', actual.cliente.nombre,'- Apellido: ', actual.cliente.apellido);
		while(actual.cliente.codigo = v.cliente.codigo)do begin
			actual:=v;
			total:=0;
			while(actual.anio = v.anio)and(actual.cliente.codigo = v.cliente.codigo) do begin
				actual:=v;
				totalMes:=0;
				while(actual.mes = v.mes)and (actual.anio = v.anio)and(actual.cliente.codigo = v.cliente.codigo)do begin
					totalMes:= totalMes + v.monto;
					total:= total + v.monto;
					leer(mae,v);
				end;
				writeln('TOTAL DEL MES: ',actual.mes);
				writeln('$ ',totalMes:0:2);
			end;
			writeln('TOTAL DEL ANIO: ', actual.anio);
			writeln('$ ',total:0:2);
		end;
	end;
	close(mae);
end;
