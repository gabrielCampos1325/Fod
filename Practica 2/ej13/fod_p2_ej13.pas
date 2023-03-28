program fod_p2_ej13;
uses crt;

procedure actualizar();
var
	
begin
	reset(mae);
	reset(det);
	read(mae, regm);
	leer(det, regd);
	while (regd <> valoralto) do begin
		usuarioActual:= regd.numUsuario;
		total:= 0;
		while (usuarioActual = regd.numUsuario) do begin
			total += 1;
			leer(det, regd);
		end;
		while (regm.numUsuario <> regd.numUsuario) do begin
			read(mae, regm);
		end;
		regm.totalMails += total;
		seek(mae, filepos(regm) - 1);
		write(mae, regm);
	end;
	close();
	close();
end;

procedure listar();
var
begin
	// mientras no se termine el maestro
	// leer reg maestro
	// idactual del rgm
	// mientras no se termine el detalle y el idactual sea menor al reg detalle
		// leer reg detalle
	// si el idactual = id del reg detalle
		// imprimir lo del detalle
	// sino
		// imprmir 0
	
end;
