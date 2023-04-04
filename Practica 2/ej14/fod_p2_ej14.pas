program fod_p2_ej14;
uses crt;

type
	rangoDia = 1.31;
	rangoMes = 1..12;
	rangoAnio = 2010...2025;
	
	rangoHora = 0..23;
	rangoMinutos = 0..59;
	
	fechaR = record
		dia: rangoDia;
		mes: rangoMes;
		anio: rangoAnio;
	end;
	
	hora = record
		hora = rangoHora;
		minutos = rangoMinutos;
	end;
	
	regMaestro = record
		destino: string;
		fecha: fechaR;
		horaSalida: hora;
		asientosDisp: integer;
	end;
	
	regDetalle = record
		destino: string;
		fecha: fechaR;
		horaSalida: hora;
		asientosComp: integer;
	end;

procedure minimo(var regd1, regd2, min regDetalle);
var
begin
	if (regd1.destino < regd2.destino) or 
	
	((regd1.destino =  regd2.destino) and (regd1.fecha <  regd2.fecha)) or 
	
	((regd1.destino =  regd2.destino) and (regd1.fecha =  regd2.fecha) and
	
	(regd1.horaSalida <  regd2.horaSalida))
	// vector?
end; 


procedure minimo(var regd1, regd2, min: regDetalle);
var
begin
	if (regd1.destino < regd2.destino){
	} else {
		if (regd1.fecha < regd2.fecha){
		} else {
			if (regd1.horaSalida <  regd2.horaSalida){}
			}
end;



procedure actualizar();
var
begin
	reset(mae);
	reset(det1);
	reset(det2);
	leer(det1, regd1);
	leer(det2, regd2);
	minimo(regd1, regd2, min);
	while (min <> valoralto) do begin
		
	end;
end;

var

begin
	
end;
{Una compañía aérea dispone de un archivo maestro donde guarda información sobre
sus próximos vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida
y la cantidad de asientos disponibles. La empresa recibe todos los días dos archivos detalles
para actualizar el archivo maestro. En dichos archivos se tiene destino, fecha, hora de salida
y cantidad de asientos comprados. Se sabe que los archivos están ordenados por destino
más fecha y hora de salida, y que en los detalles pueden venir 0, 1 ó más registros por cada
uno del maestro. Se pide realizar los módulos necesarios para:
c. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje
sin asiento disponible.
d. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que
tengan menos de una cantidad específica de asientos disponibles. La misma debe
ser ingresada por teclado.
NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.}
