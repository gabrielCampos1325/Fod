program fod_p1_ej3;

Uses sysutils, crt;

type
	empleado = record
		num,edad,dni: integer;
		nombre,apellido: string[50];	
		end;
		
	arch_emp = file of empleado;

procedure leerEmp(var e: empleado);
begin
	readln(e.apellido);
	if (e.apellido<>'fin') then begin
		e.nombre:= IntToHex(Random(Int64($7fffffffffffffff)), 16);
		e.num:= Random(999);
		e.edad:= 18 + Random(79);
		writeln('Ingrese el dni');
		readln(e.dni);
	end;
end;
	
procedure ingresarEmpleado(var emp: arch_emp);	
var
	un_emp: empleado;
begin
	writeln('Ingrese un empleado');
	leerEmp(un_emp);
	while (un_emp.apellido<>'fin') do begin
		write(emp, un_emp);
		writeln('Ingrese un empleado');
		leerEmp(un_emp);
	end;
end;

procedure crearArchivo(var emp: arch_emp);		

begin	
	rewrite(emp);
	ingresarEmpleado(emp);	
	close(emp);	
end;
	
procedure imprimirEmp(e: empleado);
begin
	writeln(e.nombre);
	writeln(e.apellido);
	writeln(e.dni);
	writeln(e.edad);
	writeln(e.num);
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
		writeln();
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
			writeln();
		end;
	end;
	close(emp);	
end;

procedure agregarEmp(var emp: arch_emp);
begin
	seek(emp,fileSize(emp));
	ingresarEmpleado(emp);
	close(emp);
end;	

procedure modifEmp(var emp: arch_emp);
var
	e: empleado;
	st: string[50];
	ok: boolean;
begin	
	ok:= false;
	writeln('Ingrese el apellido del empleado a modificar');
	readln(st);
	while (st<>'fin') and not (ok) do begin		
		while not eof(emp)do begin
			read(emp, e);
			if (e.apellido=st) then begin				
				writeln('Ingrese la nueva edad');
				readln(e.edad);	
				seek(emp, filePos(emp) - 1);	
				write(emp, e);	
				ok:= true;	
			end;
		end;
		if (ok) then
			writeln('Se modifico exitosamente')
		else
			writeln('No se encontro el empleado');
		ok:= false;		
		writeln('Ingrese el apellido del empleado a modificar');
		readln(st);		
	end;
	close(emp);	
end;

procedure exportarEmpTxt(var emp: arch_emp; var empText: Text);
var
	e: empleado;
begin
	Assign(empText,'todos_empleados.txt');
	rewrite(empText);
	while not eof(emp)do begin
		read(emp, e);
		with e do
			writeln (empText,
					 'num: ',num,
					 ' edad: ',edad,
					 ' dni: ',dni,
					 ' apellido: ',apellido,
					 ' nombre: ',nombre);
	end;
	close(emp);
	close(empText);
end;

procedure exportarEmpSinDniTxt(var emp: arch_emp; var sinDniText: Text);
var
	e: empleado;
begin
	Assign(sinDniText,'faltaDNIEmpleados.txt');
	rewrite(sinDniText);
	while not eof(emp)do begin
		read(emp, e);
		if (e.dni = 00) then begin
			with e do
				writeln (sinDniText,
						 'num: ',num,
						 ' edad: ',edad,
						 ' dni: ',dni,
						 ' apellido: ',apellido,
						 ' nombre: ',nombre);
		end;
	end;
	close(emp);
	close(sinDniText);
end;
	
procedure bienvenida(var emp: arch_emp; var empText, sinDniText: Text);
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
			writeln('4. Agregar empleado');
			writeln('5. Modificar empleado');
			writeln('6. Exportar empleados a .txt');
			writeln('7. Exportar empleados sin DNI a .txt');
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
				4: begin
					agregarEmp(emp);
				end;
				5: begin
					modifEmp(emp);
				end;
				6: begin					
					exportarEmpTxt(emp,empText);
				end;
				7: begin				 	
					exportarEmpSinDniTxt(emp,sinDniText);
				end;
			end;
		end else
			ok:= false;
	end;
end;


var
	emp: arch_emp;
	empText, sinDniText: Text;
begin
	textcolor(green);
	Randomize;
	bienvenida(emp,empText,sinDniText);		
end.

