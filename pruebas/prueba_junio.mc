/************************
 * 	Fichero de prueba junio 2025
 ************************/

__junio_2025() {
    // Declaraciones
    const int a = 0, b = 1;
    var int e56,y; 
    const int c=10;
    var int z;
    // Sentencias
    e56=(a+b*20-(b+19/2))/2; //e56=5
    print ("Comienza \t  simulación \\ junio 2025\n");
    if (a*1000) print ("Esto no va bien con a*1000=",a*1000,"\n");
    if (b-1) print ("Esto no va bien con b-1=\n",b-1);
         else while (e56-2) { // Entra 3 veces en el bucle
             e56 = e56-1;
             print ("Introduce valores de 'y' y 'z' 3 veces\n");
             read (y,z);
             print ("e56=",e56,", y=",(y+0)/1,", z=",(z-0)*1,"\n");
         }
    print ("Termina correctamente con e56=",e56,"\n","-----------------------","\n"); //e56 debe ser 2
    print ("Expresion triple a 1: ------------", (e56?1:0),"-----------\n");  
}