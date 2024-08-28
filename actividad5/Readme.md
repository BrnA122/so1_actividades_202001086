# *Tipos de Kernel y sus diferencias*

*El kernel es el núcleo del sistema operativo, encargado de gestionar los recursos del sistema y facilitar la comunicación entre el hardware y el software. Existen varios tipos de kernel y se dividen en dos tipos, esenciales y no esenciales.* 

*¿Qué quiere decir esto? Que algunos tienen un uso más común que otros cada uno con sus propias características:*

- ## Esenciales

1. ***Kernel monolítico:*** *es un Kernel de gran tamaño que puede gestionar todas las tareas. Se encarga de la gestión de memoria y procesos, así como de la comunicación entre los procesos y el soporte de las diferentes funciones de los drivers y el hardware. Los sistemas operativos que recurren al Kernel monolítico son Linux, OS X y Windows.*

2. ***Microkernel:*** *los Kernel que están diseñados con pequeños tamaños tienen una clara función: evitar el colapso total del sistema en caso de un fallo. Para cumplir con todas las tareas como un Kernel monolítico cuenta con diferentes módulos. Es curioso, pero hasta ahora solo el Mach de OS X es el único que utiliza el microkernel.*

3. ***Kernel híbrido:*** *combinación entre el microkernel y el Kernel monolítico. Nos encontramos ante un Kernel grande, pero compacto y que puede ser modulado y otras partes del mismo Kernel pueden cargarse de manera dinámica. Es utilizado en Linux y OS X.* 

- ## No esenciales

1. ***Nanokernel:*** *si el microernel es pequeño, este es todavía más reducido, pero su uso está destinado a sistemas embebidos ya que el nivel de fiabilidad es mayor.* 

2. ***Exokernel:*** *la estructura que propone un exokernel es innovadora ya que se estructura de manera vertical. Los núcleos son pequeños y su desarrollo tiene fines investigativos. En un exokernel la toma de decisiones está a cargo de los programas, para hacer el uso de los recursos del hardware en ciertas bibliotecas. El Kernel se limita a evitar errores en los permisos de hardware y eludir conflictos.*

3. ***Unikernel:*** *es un Kernel destinado a la eliminación de capas intermedias entre el hardware y las aplicaciones, ya que busca simplificar lo más posible todos los procesos. Es habitual en dispositivos de bajo consumo como los IoT.*

4. ***Anykernel:*** *otro concepto innovador que busca conservar las cualidades de los Kernel monolíticos, pero también facilitar el desarrollo de los controladores, al mismo tiempo que ofrece mayor seguridad al usuario.* 

# *User vs Kernel Mode*

*El modo de usuario y el modo del kernel son dos modos distintos en los que opera un procesador de computadora, dependiendo del tipo de código que se está ejecutando y del nivel de acceso a los recursos del sistema.*

- ***Modo de usuario:*** *Este es un modo restringido donde las aplicaciones operan con acceso limitado a los recursos del sistema. Cada aplicación se ejecuta de forma aislada, lo que garantiza que si uno se bloquea, no afecta a otras aplicaciones o al sistema operativo. En modo de usuario, las aplicaciones tienen su propio espacio de dirección virtual, que es privado y limitado. Si una aplicación en modo de usuario necesita acceder a los recursos del sistema, debe pasar por el núcleo del sistema operativo usando syscalls.*

- ***Modo de Kernel:*** *Este es un modo privilegiado donde los componentes del sistema operativo básico funcionan con acceso irrestricto a los recursos del sistema. Todo el código que se ejecuta en modo kernel comparte un único espacio de dirección virtual, permitiendo que los procesos accedan a los recursos del sistema y realicen operaciones privilegiadas. El modo Kernel está reservado para los controladores y otros componentes del sistema crítico. Cuando una aplicación a nivel de usuario necesita realizar una operación que requiere acceso al modo kernel, debe hacer una llamada al núcleo del sistema operativo.*

Las diferencias clave entre el modo de usuario y el modo del kernel incluyen:

- ***Acceso a los recursos:*** *En modo núcleo, los programas tienen acceso directo e irrestricto a los recursos del sistema, mientras que en modo de usuario, las aplicaciones tienen un acceso limitado y deben pasar por el núcleo del sistema operativo para acceder a los recursos.*

- ***Protección de memoria:*** *En el modo de usuario, cada aplicación tiene su propio espacio de dirección virtual privada, asegurando que una aplicación no puede modificar los datos de otra aplicación. En el modo del núcleo, todos los procesos comparten un solo espacio de dirección virtual.*

- ***Aislamiento:*** *En modo de usuario, las aplicaciones se ejecutan de forma aislada, evitando que el choque de una aplicación afecte a otras aplicaciones o al sistema operativo. En el modo del núcleo, un choque en un componente puede afectar potencialmente a todo el sistema operativo.*


# *Interruptions vs traps*

***¿Qué es una trampa?***


*Una trampa es una interrupción que se desencadena por una excepción en un proceso de usuario para permitir la ejecución de la funcionalidad. Una trampa en un sistema operativo se puede desencadenar por situaciones de excepción como acceso inadecuado a la memoria, división por cero o un punto de ruptura.*

*Una trampa conmuta un sistema operativo en modo núcleo. El sistema operativo realiza algunas acciones antes de devolver el control al proceso anterior. Durante una trampa, la ejecución de un proceso tiene prioridad sobre el código del usuario. Cuando el sistema operativo detecta una trampa, detiene el proceso del usuario. El sistema operativo reanuda y continúa la ejecución de los procesos de usuario tan pronto como se complete la llamada del sistema.*

*A modo de ejemplo, considere lo siguiente. Suponga que tienes una declaración como printf ("%sn", str); Esto llamará a la función de escritura para imprimir la salida a la salida estándar, que es el monitor. Esto desencadenará una trampa y enviará el control al manipulador de trampas. El modo de usuario luego cambia al modo del kernel, y el sistema operativo ejecuta la llamada de escritura. Una vez completada la tarea, el control se devuelve al modo de usuario desde el modo del núcleo.*

***¿Cómo funcionan las trampas?***

*Las etapas enumeradas a continuación se pueden utilizar para resumir cómo funciona una trampa en un sistema operativo:*

- *Los errores o excepciones que pueden ocurrir mientras se realiza un programa incluyen un error dividido por cero, un intento de acceder a memoria errónea y una instrucción inválida. Después de identificar el error o excepción, la CPU genera una señal de trampa.*

- *La CPU entra en modo núcleo con la ayuda de esta señal y transfiere el control al manipulador de trampas que es una región predefinida del sistema operativo.*

- *El manipulador de trampas en el sistema operativo determina la fuente de la trampa y realiza la acción apropiada. Esto podría incluir la terminación de la aplicación diciéndose al usuario de un error o proporcionando una función específica solicitada por el programa*

- *Después de que el manipulador de trampas ha completado su control de tareas se restaura al programa que creó la trampa y la CPU vuelve al modo de usuario*

***¿Qué es un Interrupción?***

*Una interrupción es levantada por un dispositivo de hardware. Los dispositivos USB, tarjetas NIC y teclados pueden causar interrupciones. Las interrupciones son asincrónicas. Por lo tanto, pueden ocurrir en cualquier momento.*

*Un pin de interrupción es un pin dedicado en una CPU. También se conoce como pin INT. El pin de interrupción conecta dispositivos como teclados al procesador. Cuando se presida una tecla, se genera una interrupción. La CPU pasará del proceso actual a una rutina de interrupción de manejadores. La rutina del manejador de interrupción del teclado se llama en este caso. Después de terminar el código del manejador de interrupciones, la CPU vuelve al programa original que se estaba ejecutando. Cuando se produce una interrupción, la CPU cambia el contexto y ejecuta el manejador de interruptores. Vuelve al estado anterior una vez terminado.*

*Aunque un procesador solo tiene un pin de interrupción, hay numerosos dispositivos de hardware. El controlador de interruptores facilita el intercambio de un solo pin de interrupción entre muchos pines. Para descubrir qué dispositivo causó la interrupción, el procesador se conectará con el controlador de interrupción. La CPU ejecutará la rutina de manejador de interrupciones asociada.*

***¿Cómo funcionan las interrupciones?***

*Las etapas enumeradas a continuación resumen cómo funciona una interrupción en un sistema operativo:*

- *Una señal de interrupción es generada por un dispositivo de hardware externo para notificar a la CPU que algo tiene que hacerse. Debido a que la CPU suspende la ejecución del programa actualmente en ejecución y entra en modo núcleo, el sistema operativo puede manejar la interrupción*

- *El sistema operativo invoca su manejador de interruptores para manejar la interrupción. Cuando se produce una interrupción, el manipulador de la interrupción determina su causa y responde correctamente leyendo datos del dispositivo o haciendo otras operaciones de entrada/salida (I/O)*

- *Una vez tramitada la interrupción, el programa interrumpido reanuda la ejecución en el punto en el que fue suspendido*

