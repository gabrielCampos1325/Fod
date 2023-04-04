program fod_p2_ej18;
uses crt;

{
	mientras no se termine el archivo
		localidad:= r.localidad;
		mientras sea la misma localidad
			municipio:= r.municipio;
			totalMunicipio:= 0;
			mientras sea el mismo municipio
				hospital:= r.hospital;
				casos:= 0;
				mientras sea el mismo hospital
					casos += r.casos;
					leer(m, r);
				write(r.n_h, '................', casos)
				totalMunicipio += casos
			if (totalMunicipio > 1500)
				agregar al archivo de texto
			writeln('Cantidad de casos Municipio', r.nombMunicipio, totalMunicipio);
			writeln();
		totalLocalidad += totalMunicipio;
		writeln('Cantidad de casos Localidad', r.nombLocalidad, totalLocalidad);
		writeln('--------------------------------------');
}
