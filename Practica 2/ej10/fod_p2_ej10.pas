

procedure crearListado();
var
	total: integer;
	reg: 	
begin
	leer(archivo, reg);	
	
	while (reg.departamento <> valoralto) do begin
		writeln('Departamento: ', reg.departamento);
		dep:= reg.departamento;
		horasDep:= 0;
		montoDep:= 0;
		
		while (dep = reg.departamento) do begin
			writeln('Division: ', reg.division);
			division:= reg.division;
			horasDiv:= 0;
			montoDiv:= 0;
			
			while (dep = reg.departamento) and 
			(division = reg.division) do begin
				writeln('Numero de empleado		', 'Total de hs: 	', 'Importe a cobrar');
				empleado:= reg.codEmp;				
				
				while (dep = reg.departamento) and 
				(division = reg.division) and 
				(empleado = reg.codEmp) do begin
					writeln(reg.codEmp, '		', reg.horasEmp, '		', reg.montoEmp, '		',);
					horasDiv += reg.horasEmp;
					montoDiv += reg.montoEmp;
					leer(archivo, reg);
				end;
				
			end;
			
			writeln('Total horas divison', horasDiv);
			writeln('Monto total divison', montoDiv);
			horasDep += horasDiv;
			montoDep += montoDiv;
		end;
		
		writeln('Total horas departamento', horasDep);
		writeln('Monto total departamento', montoDep);
	end;		
	
	close(archivo);
end;
