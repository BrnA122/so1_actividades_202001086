#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid;

    // Crear un proceso hijo
    pid = fork();

    if (pid < 0) {
        // Error al crear el proceso hijo
        perror("fork");
        exit(EXIT_FAILURE);
    }

    if (pid == 0) {
        // Código del proceso hijo
        printf("Proceso hijo (PID: %d) está terminando\n", getpid());
        exit(EXIT_SUCCESS);  // El proceso hijo termina y se convierte en un zombie
    } else {
        // Código del proceso padre
        printf("Proceso padre (PID: %d) está esperando\n", getpid());
        sleep(60);  // El proceso padre espera durante 60 segundos

        printf("Proceso padre (PID: %d) terminando\n", getpid());
        // El proceso padre termina sin hacer wait() para el hijo
        // Esto deja al proceso hijo en estado zombie durante al menos 60 segundos
        exit(EXIT_SUCCESS);
    }
}
