/************************
 * 	Fichero de prueba: comentarios mal anidados
 ************************/

main() {
    var int y;
    y = 10;
    /* Comentario que /* intenta anidar */ pero no debe */
    y = y + 2; // Suma dos
    /* Comentario abierto
    y = y + 3; // Esto está dentro del comentario
    // Pero aquí no se cierra nunca
    print("¿Esto se imprime?\n");
}