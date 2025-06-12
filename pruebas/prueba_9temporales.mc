testRegistrosTemporales() {
    // Declaraciones
    var int a, b, c, d, e, f, g, h, i, j, k;
    const int uno = 1, dos = 2, tres = 3, cuatro = 4, cinco = 5, seis = 6, siete = 7, ocho = 8, nueve = 9;
    var int resultado;

    // Expresión anidada al máximo (9 temporales)
    resultado = ((((uno + dos) * tres) - cuatro) / cinco) + 
                ((((seis * siete) + ocho) - nueve) / uno);

    print("Resultado = ", resultado);

    // Ternario que usa el resultado anterior
    k = (resultado ? (a + b) : (c - d));
    print("k = ", k);

    // Bucle sencillo
    a = 0;
    while (a) {
        a = a + 1;
    }
    print("a = ", a);

    // Operación final
    resultado = (k * a) + (b - c);
    print("Resultado final = ", resultado);
}