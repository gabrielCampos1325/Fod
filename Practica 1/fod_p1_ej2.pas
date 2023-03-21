program fod_p1_ej2;

type
	arch_enteros = file of integer;
	
var
	enteros: arch_enteros;
	nombre: string;
	num,cont,total: integer;
	prom: real;
	
begin
	cont:= 0;
	total:= 0;
	prom:= 0.0;
	writeln('Ingrese nombre del archivo a procesar');
	readln(nombre);
	assign(enteros, nombre);
	reset(enteros);	
	while not eof(enteros) do begin
		read(enteros, num);
		total:= total + 1;
		writeln('Posicion ', total, ': ', num);
		if (num<1500) then
			cont:= cont + 1;
		prom:= prom + num;		
	end;
	close(enteros);
	writeln('La cantidad de numeros < a 1500 es: ', cont);
	writeln('El promedio de numeros es: ', prom/total:2:2);
end.

