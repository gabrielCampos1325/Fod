program fod_p2_ej3;
uses crt;

const
	n = 3;
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
	pos:= 0;
	for i:= 1 to n do begin
		if (vV[i].codigo < min.codigo) then begin
			min:= vV[i];
			pos:= i;
		end;
	end;
	if (pos <> 0) then
		leer(vD[pos], vV[pos]);
end;

procedure actualizar(var mae: maestro);
var
	i, cod, total: integer;
	vD: vectorDetalle;
	vV: vectorVentas;
	st: string;
	min: venta;
	regm: producto;
	
begin
	for i:= 1 to n do begin
		str(i, st);
		assign(vD[i], 'detalle' + st);
		reset(vD[i]);		
		leer(vD[i], vV[i]);
	end;
	
	minimo(vD, vV, min);
	read(mae, regm);
	while (min.codigo <> valoralto) do begin
		cod:= min.codigo;
		total:= 0;
		while (cod = min.codigo) do begin
			total += min.cantidad;
			minimo(vD, vV, min);
		end;
		while (regm.codigo <> cod) do begin
			read(mae, regm);
		end;
		regm.stockDisp -= total;
		seek(mae, filepos(mae) - 1);
		write(mae, regm);
	end;
	close(mae);
	for i:= 1 to n do begin
		close(vD[i]);
	end;
end;

procedure crearTxt(var mae: maestro);
var
	t: Text;
	r: producto;
begin
	assign(t, 'bajoStock.txt}');
	rewrite(t);
	reset(mae);
	while not(eof(mae)) do begin
		read(mae, r);
		if (r.stockDisp < r.stockMin) then begin
			with r do begin
				writeln(t, codigo, '	', nombre, '	',
						precio:2:2, '	', stockDisp);
			end;
		end;
	end;
end;


var
	mae: maestro;
	
begin
	assign(mae, 'maestro');
	reset(mae);
	actualizar(mae);
	crearTxt(mae);	
end.
