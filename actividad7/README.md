# *Completely Fair Scheduler (CFS)*

*El Completely Fair Scheduler (CFS) es el planificador de tareas por defecto del kernel de Linux desde la versión 2.6.23 (2007). Su diseño está basado en el principio de justicia en la asignación de CPU entre los procesos que compiten por ella.*

## *Características principales y su funcionamiento:*

1. ***Equidad (Fairness):***

    - *El objetivo principal del CFS es garantizar que cada proceso tenga una porción de tiempo de CPU proporcional a su "peso" o prioridad. En lugar de asignar tiempos de ejecución fijos como en otros algoritmos de planificación, CFS intenta distribuir el tiempo de manera equitativa entre los procesos, de acuerdo con sus prioridades.*

2. ***Árbol Rojo-Negro (Red-Black Tree):***

    - *CFS organiza los procesos que están esperando para ejecutar en una estructura de datos conocida como árbol rojo-negro. Este árbol ordena los procesos de acuerdo con el tiempo de CPU que ya han utilizado.*

    - *La principal ventaja del árbol rojo-negro es que permite acceder de manera eficiente (O(log n)) al siguiente proceso a ejecutar, es decir, el proceso que menos tiempo de CPU ha consumido hasta ese momento.*

3. ***Virtual Runtime (Tiempo de Ejecución Virtual):***

    - *Tiempo de ejecución virtual (vruntime) es una métrica clave en CFS. Representa cuánto tiempo de CPU ha utilizado un proceso, ajustado por su prioridad. Los procesos con mayor prioridad tienen un vruntime más lento, lo que les permite ejecutar más tiempo, mientras que los de baja prioridad incrementan su vruntime más rápidamente.*

    - *El CFS selecciona el proceso con el menor vruntime para ejecutarse, de modo que los procesos que menos tiempo han ejecutado recientemente tengan preferencia para usar la CPU.*

4. ***Prioridades Proporcionales:***

    - *CFS utiliza el concepto de pesos asociados con las prioridades de los procesos. Los procesos con alta prioridad tienen más peso y, por lo tanto, pueden ejecutar más tiempo en la CPU antes de que su vruntime se incremente en la misma proporción que los procesos de baja prioridad.*

    - *Esto crea un equilibrio entre permitir que los procesos de baja prioridad se ejecuten eventualmente, pero sin permitir que los procesos de alta prioridad acaparen todo el tiempo de CPU.*

5. ***Preempción:***

    - *CFS es preemptivo, lo que significa que puede interrumpir la ejecución de un proceso si otro con un vruntime menor está listo para ejecutar.*

    - *No obstante, CFS utiliza una política de "mínima preempción", lo que significa que intenta minimizar el número de interrupciones para reducir el overhead y maximizar la eficiencia.*

6. ***Latencia de Programación (Scheduling Latency):***

    - *La latencia de programación es el tiempo máximo en el que un proceso de baja prioridad puede esperar para ejecutar, incluso si otros procesos están monopolizando la CPU. CFS trata de distribuir el tiempo de manera que todos los procesos se ejecuten en intervalos cortos, garantizando que no haya procesos que se queden esperando indefinidamente.*

7. ***Group Scheduling (Programación de Grupos):***

    - *CFS también soporta la programación de grupos. Esto permite que varios procesos se agrupen, y el CFS distribuya el tiempo de CPU equitativamente entre los grupos. Esto es útil para sistemas en los que se desea dar un tratamiento especial a grupos de procesos en lugar de procesos individuales.*

8. ***Tiempo de Desperdicio (Nice Values):***

    - *CFS también soporta los valores tradicionales de nice, que permiten ajustar la prioridad de los procesos. Valores más bajos de nice resultan en mayor prioridad, y valores más altos en menor prioridad. El ajuste del valor nice influye en el cálculo del vruntime.*
