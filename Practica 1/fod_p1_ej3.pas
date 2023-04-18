program fod_p1_ej3;

Uses sysutils, crt;

type
	empleado = record
		num,edad,dni: integer;
		nombre,apellido: string[50];	
		end;
		
	arch_emp = file of empleado;
	
procedure crearArchivo(var emp: arch_emp);
		procedure leerEmp(var e: empleado);
		begin
			writeln('Ingrese un empleado');
			readln(e.apellido);
			if (e.apellido<>'fin') then begin
				e.nombre:= IntToHex(Random(Int64($7fffffffffffffff)), 16);
				e.num:= Random(1000);
				e.edad:= 18 + Random(79);
				e.dni:= Random(10000000);
			end;
		end;
		
var
	un_emp: empleado;
begin	
	rewrite(emp);	
	leerEmp(un_emp);
	while (un_emp.apellido<>'fin') do begin
		write(emp, un_emp);
		leerEmp(un_emp);
	end;
	close(emp);	
end;
	
procedure imprimirEmp(e: empleado);
begin
	writeln(e.nombre);
	writeln(e.apellido);
	writeln(e.dni);
	writeln(e.edad);
	writeln(e.num);
	writeln();
end;

procedure mostrarEmpDet(var emp: arch_emp);
var
	st: string[50];
	e: empleado;
begin
	writeln('Ingrese nombre de el/los empleado/empleados');
	readln(st);
	while not eof(emp) do begin
		read(emp, e);
		if (e.nombre = st) or (e.apellido = st) then
			imprimirEmp(e);
	end;
	close(emp);	
end;	
	
procedure mostrarTodosEmp(var emp: arch_emp);
var
	e: empleado;
begin
	while not eof(emp) do begin
		read(emp, e);
		imprimirEmp(e);		
	end;
	close(emp);	
end;

procedure mostrarEmpMayores(var emp: arch_emp);
var
	e: empleado;
begin
	while not eof(emp) do begin
		read(emp, e);
		if (e.edad>70) then begin
			imprimirEmp(e);
		end;
	end;
	close(emp);	
end;
	
procedure bienvenida(var emp: arch_emp);
var
	num: integer;
	nombre: string[50];	
	ok: boolean;
begin
	ok:= true;
	writeln('Ingrese nombre del archivo');
	readln(nombre);
	assign(emp, nombre);
	while (ok) do begin
		writeln('Seleccione una opcion');
		writeln('1. Crear archivo de empleados');
		writeln('2. Abrir archivo de empleados');
		writeln('3. Cerrar la consola');
		readln(num);
		if (num=1) then
			crearArchivo(emp)
		else if (num=2) then begin
			writeln('1. Listar empleado determinado');
			writeln('2. Listar todos los empleados');
			writeln('3. Listar empleados con edad > a 70');
			readln(num);
			reset(emp);			
			case num of
				1: begin
					mostrarEmpDet(emp);
				end;
				2: begin
					mostrarTodosEmp(emp);
				end;
				3: begin
					mostrarEmpMayores(emp);
				end;
			end;
		end else
			ok:= false;
	end;
end;


var
	emp: arch_emp;
begin
	textcolor(red);
	Randomize;
	bienvenida(emp);		
end.

