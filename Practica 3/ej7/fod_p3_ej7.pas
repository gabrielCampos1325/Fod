program fod_p3_ej7;  

procedure compactar(var a: archivo);
var
	reg: ave;
	cont: integer;
	
begin	
	reset(a);
	cont:= 0;
	while (filepos(a) <> filesize(a)-cont) do begin
		read(a, reg);
		if (pos('@', reg.nombre) <> 0) then begin
			cont++;
			pos:= filepos(a)-1;
			seek(a, filesize(a)-cont);
			read(a, reg);
			seek(a, pos);
			write(a, reg);
			seek(a, filepos(a)-1)
		end;
	end;
	truncate(a);
	close(a);	
end; 
