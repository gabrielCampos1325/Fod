program fod_p2_ej15;
uses crt;
				//arreglo de detalle
procedure minimo (var deta:arDet; var min:cDetalle; var registro:regDet);
var
i,indiceMin:integer;
begin
	indiceMin:= 0;
	min.codP:= valorAlto;
	for i:= 1 to n do 
		if (registro[i].codP <> valorAlto) then
			if ((registro[i].codP < min.codP) or ((registro[i].codP = min.codP) and (registro[i].codL < min.codL))) then begin
				min:= registro[i];
				indiceMin:= i;
			end;
	if (indiceMin <> 0) then
		leer(deta[indiceMin],registro[indiceMin]);
end;
