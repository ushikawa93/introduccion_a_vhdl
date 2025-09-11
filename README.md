# Introducción a VHDL

Autor: Matías Javier Oliva

Este repositorio contiene programas utilizados en el dictado de un curso introductorio a VHDL. También se incluyen las diapositivas utilizadas en el dictado de cada clase.

En todos los temas se hará énfasis en la implementación en VHDL de las arquitecturas propuestas, suponiendo un conocimiento previo de las estructuras subyacentes.

1° clase: Introducción a VHDL
- Introducción a HDLs.
- VHDL y Verilog.
- Estructura general de un archivo VHDL.
- Familiarización con el entorno Quartus y herramientas de simulación.
- Tipos de datos y operadores en VHDL.
- Errores y warnings.
- Ejemplo con alguna lógica concurrente sencilla. Mostrar RTL y simulación.
- Uso de recursos.

2° clase: Lógica combinacional
- Lógica combinacional. Sintaxis con asignaciones concurrentes o procesos (process).
- Optimización de expresiones.
- Multiplexores.
- Uso de componentes.
- BCD 7segmentos (mostrar). Barrel Shifter. Multiplicador 2bits. Comparador 2bits.

3° clase: Lógica secuencial 1
- Lógica secuencial. Distintas sintaxis.
- Inferir flip-flops correctamente. Reset asincrónico y sincrónico.
- Resaltar utilidad del flip flop como memoria.
- Circuito detector de flancos de reloj.
- Flip flops para retardar y sincronizar señales.
- Herramientas de timing.

4° clase: Lógica secuencial 2
- Generación de testbenches. Utilización de estos para validar diseños.
- Estructuras secuenciales:
  - Contadores sincrónicos y asincrónicos.
  - Contadores arbitrarios.
  - Registros de desplazamiento en distintas configuraciones serie/paralelo.

5° clase: Circuitos aritméticos
- Circuitos aritméticos.
- Distintas arquitecturas de sumadores: carry trade, carry save, carry select. Determinación de la frecuencia máxima de operación con cada uno.
- Multiplicación por números constantes.
- Algoritmos de multiplicación combinatorios (algoritmo de booth) y secuenciales.

6° clase: Máquinas de estado
- Máquinas de estados de Mealy y Moore.
- Implementación en VHDL (en los templates cuidado con nombres de variables).
- Visualizador de diagramas de estados en Quartus. Errores comunes.
- Síntesis de circuitos a partir de diagramas de estado.
- Implementación de pipelines.

7° clase: Implementación en FPGA
- Implementación de los temas desarrollados en FPGAs de Intel-Altera.
- Circuitos anti-rebote para pulsadores físicos.
- Separación del control de operación (máquinas de estado) del datapath.
- Breve introducción a la instanciación de procesadores en FPGAs (procesador NIOS).

8° clase: Introducción a SoC-FPGA
- Breve introducción a FPGAs con un microprocesador (uP) embebido.
- Puentes de comunicación entre FPGA y uP.
- Separación de control de la operación y procesamiento en bajo nivel.
- Combinar código VHDL con estructuras en Verilog.
- Ejemplos prácticos (sistema reconfigurable de procesamiento de señales).
