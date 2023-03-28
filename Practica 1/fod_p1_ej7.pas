
Program fod_p1_ej7;

Type 
    novela =   Record
        cod:   integer;
        nombre, genero:   string;
        precio:   real;
    End;

    archivo =   file Of novela;

Procedure crear(Var arch_b: archivo; Var arch_carga: Text);

Var 
    n:   novela;
Begin
    rewrite(arch_b);
    writeln('LLEGO');
    reset(arch_carga);
    writeln('LLEGO');
    While Not eof(arch_carga) Do
        Begin
            With n Do
                Begin
                    readln(arch_carga,cod,precio,genero);
                    readln(arch_carga,nombre);
                End;
            write(arch_b, n);
        End;
    close(arch_b);
    close(arch_carga);
End;

Procedure leerNovela(Var n:novela);
Begin
    writeln('Ingrese el nombre de la novela');
    readln(n.nombre);
    writeln('Ingrese el codigo de la novela');
    readln(n.cod);
    writeln('Ingrese el precio de la novela');
    readln(n.precio);
    writeln('Ingrese el genero de la novela');
    readln(n.genero);
End;

Procedure agregarNovela(Var arch_b: archivo);

Var 
    n:   novela;
Begin
    reset(arch_b);
    seek(arch_b, fileSize(arch_b));
    leerNovela(n);
    write(arch_b, n);
    close(arch_b);
End;

Procedure modificarNovela(Var arch_b: archivo);

Var 
    n, nueva:   novela;
    ok:   boolean;
Begin
    reset(arch_b);
    writeln('Ingrese los nuevos datos de la novela a modificar');
    leerNovela(nueva);
    ok := false;
    While Not eof(arch_b) And Not (ok) Do
        Begin
            read(arch_b, n);
            If (n.cod = nueva.cod) Then
                Begin
                    ok := true;
                    seek(arch_b, filePos(arch_b) - 1);
                    write(arch_b, nueva)
                End;
        End;
    If (ok) Then
        writeln('Se modifico exitosamente')
    Else
        writeln('No se encontro la novela');
    close(arch_b);
End;

Procedure exportarNovelas(Var arch_b: archivo);

Var 
    n:   novela;
    arch_novelas:   Text;
Begin
    reset(arch_b);
    Assign(arch_novelas, 'nove.txt');
    rewrite(arch_novelas);
    While Not eof(arch_b) Do
        Begin
            read(arch_b, n);
            writeln(arch_novelas,
                    'Codigo: ', n.cod,
                    ' genero: ', n.genero);
            writeln(arch_novelas,
                    'Precio: ', n.precio:2:2,
                    ' nombre: ', n.nombre);
        End;
    close(arch_b);
    close(arch_novelas);
End;

Procedure menu(Var arch_b: archivo; Var arch_carga: Text);

Var 
    ok:   boolean;
    opc:   integer;
Begin
    ok := true;
    While (ok) Do
        Begin
            writeln('1. Crear archivo binario');
            writeln('2. Modificar archivo binario');
            writeln('3. Salir de la consola');
            readln(opc);
            If (opc = 1) Then
                crear(arch_b, arch_carga)
            Else If (opc = 2) Then
                     Begin
                         writeln('1. Agregar novela');
                         writeln('2. Modificar novela');
                         readln(opc);
                         Case opc Of 
                             1:   agregarNovela(arch_b);
                             2:   modificarNovela(arch_b);
                         End;
                     End
            Else
                Begin
                    exportarNovelas(arch_b);
                    ok := false;
                End;
        End;
End;

Var 
    arch_b:   archivo;
    arch_carga:   Text;
    nombre:   string;

Begin
    writeln('Ingrese el nombre del archivo binario');
    readln(nombre);
    assign(arch_b, nombre);
    writeln('Ingrese el nombre del archivo de carga');
    readln(nombre);
    assign(arch_carga, nombre);
    menu(arch_b, arch_carga);
End.
