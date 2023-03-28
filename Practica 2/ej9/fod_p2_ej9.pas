program fod_p2_ej9;
uses crt;

const
	
	
type
	

procedure crearListado();
var
	total: integer;
	reg: 	
begin
	leer(archivo, reg);
	total:= 0;
	
	while (reg.provincia <> valoralto) do begin
		writeln('Codigo Provincia: ', reg.provincia);
		prov := reg.Provincia;
		totprov := 0;
		
		while (prov = reg.Provincia) do begin	
			writeln('Codigo Localidad		Total de Votos');			
			localidad := reg.localidad;
			totlocalidad := 0
			
			while (prov = reg.Provincia) and 
			(localidad = reg.localidad) do begin
				totlocalidad += reg.votos;
				leer(archivo, reg;)
			end;
			
			writeln('	', reg.localidad, '			', totlocalidad);
			
		end;
		
		writeln('Total Provincia', totprov);
		total:= total + totprov;
		writeln();	
		writeln();		
	end;
	
	writeln ('......................................');
	writeln('Total General de Votos', total);
	close(archivo);
end;
	
var
	
	
begin
	
end.
