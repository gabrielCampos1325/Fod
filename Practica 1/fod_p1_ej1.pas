program fod_p1_ej1;

type
	arch_enteros = file of integer;
	
var
	enteros: arch_enteros;
	nombre: string;
	num: integer;
	
begin
	writeln('Ingrese nombre del archivo');
	readln(nombre);
	assign(enteros, nombre);
	rewrite(enteros);
	readln(num);
	while (num<>30000) do begin
		write(enteros, num);
		readln(num);
	end;	
	close(enteros);
end.

