program fod_p2_ej3;
uses crt;

const
	n = 30;
	valoralto = 9999;

type
	producto = record
		codigo, stockDisp, stockMin: integer;
		precio: real;
		nombre: string;
	end;
	
	venta = record
		codigo, cantidad: integer;
	end;
	
	maestro = file of producto;
	
	detalle = file of venta;
	
	vectorDetalle = array [1..n] of detalle;
	
	vectorVentas = array [1..n] of venta;


procedure leer(var det: detalle; var dato:venta);	
begin
	if not(eof(det)) then
		read(det, dato)
	else
		dato.codigo:= valoralto;
end;

procedure minimo(var vD: vectorDetalle; var vV: vectorVentas; var min: venta);
var
	pos, i: integer;
begin
	min.codigo:= valoralto;
	for i:= 1 to n do begin
		if (vD[i].codigo <> valoralto) then begin
			if (vD[i].codigo < min.codigo) then begin
				min:= vD[i].codigo;
				pos:= i;
			end;
		end;
	end;
	if (pos <> 0) then
		leer(vD[pos], vV[pos]);
end;

procedure actualizar(var mae: maestro);
var
	i: integer;
	vD: vectorDetalle;
	vV: vectorVentas;
	st: string;
	min: venta;
	
begin
	for i:= 1 to n do begin
		str(i, st);
		assign(vD[i], 'detalle' + st);
		reset(vD[i]);
		leer(vD[i], vV[i]);
	end;
	minimo(vD, vV, min);
end;


var
	mae: maestro;
	det: detalle;	
	
begin
	assign(mae, 'maestro');
	reset(mae);
	actualizar(mae);	
end.
