program fod_p2_ej12;
uses crt;

type
	rangoAnio = 1990..2023;
	rangoMes = 1..12;
	rangoDia = 1..31;
	
	acceso = record
		anio: rangoAnio;
		mes: rangoMes;
		dia: rangoDia;
		idUsuario, tiempo: integer; //en minutos
		

program crearInforme();
var
	anio: integer;
	reg: acceso;
	
begin
	writeln('Ingrese un anio');
	readln(anio);
	
	leer(mae, reg);
	while (reg.anio <> valoralto) and (reg.anio <> anio) do begin
		leer(mae, reg);
	end;
	
	total:= 0;
	while (anio = reg.anio) do begin
		ok:= true;
		mes:= reg.mes;
		writeln ('Mes:-- ', reg.mes);
		totalMes:= 0;
		while (anio = reg.anio) and (mes = reg.mes) do begin
			writeln('dia: ', reg.dia);
			totalDia:= 0;
			dia:= reg.dia
			while (anio = reg.anio) and (mes = reg.mes) and 
			(dia = reg.dia) do begin				
				id:= reg.idUsuario;
				totalId:= 0;
				while (anio = reg.anio) and (mes = reg.mes) and 
				(dia = reg.dia) and (id = reg.idUsuario) do begin
					totalId += reg.tiempo;
					leer(mae, reg);
				end;
				writeln('idUsuario ', id, '	',
				'Tiempo Total de acceso en el dia ', dia,
				' mes ', mes, ' ', totalId);
				totalDia += totalId;										
			end;
			writeln('Tiempo Total de acceso en el dia ', dia,
			' mes ', mes, ' ', totalDia);						
		end;
		writeln ('Total tiempo de acceso mes ', mes, ' ',totalMes);
		total+= totalMes;
	end;
	
	if (ok) then
		writeln ('Total tiempo de accesos anio: ', total);
	else
		writeln('Anio no encontrado');
end;
