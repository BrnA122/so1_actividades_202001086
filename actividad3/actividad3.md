# *Actividad 3*

## *Instrucciones*
*Crear un md file y resolver cada uno de los items solicitados a continución. Debe de colocar el comando utilizado asi como el resultado si este fuera necesario.*

# *Parte 1: Gestión de Usuarios*
***1. Creación de Usuarios:*** *Crea tres usuarios llamados `usuario1`, `usuario2` y `usuario3`.*

```
sudo adduser usuario1
sudo adduser usuario2
sudo adduser usuario3
```

***2. Asignación de Contraseñas:*** *Establece una nueva contraseñas para cada usuario creado.*

```
sudo passwd usuario1
sudo passwd usuario2
sudo passwd usuario3
```

*Resultado para usuario1:*

```
# Repite lo mismo para usuario2 y usuario3.

New password:
Retype new password:
passwd: password updated successfully
```

***3. Información de Usuarios:*** *Muestra la información de `usuario1` usando el comando `id`.*

```
id usuario1
```

*Resultado para el `usuario1`:*

```
uid=1001(usuario1) gid=1001(usuario1) groups=1001(usuario1)
```

***4. Eliminación de Usuarios:*** *Elimina `usuario3`, pero conserva su directorio principal.*

```
sudo userdel usuario3
```

*Verificación de que el directorio principal se conserva:*

```
ls /home

# Respuesta

usuario1  usuario2  usuario3
```

# *Parte 2: Gestión de Grupos*
***1. Creación de Grupos:*** *Crea dos grupos llamados `grupo1` y `grupo2`.*

```
sudo groupadd grupo1
sudo groupadd grupo2
```
***2. Agregar Usuarios a Grupos:*** *Agrega `usuario1` a `grupo1` y `usuario2` a `grupo2`.*

```
sudo usermod -aG grupo1 usuario1
sudo usermod -aG grupo2 usuario2
```
***3. Verificar Membresía:*** *Verifica que los usuarios han sido agregados a los grupos utilizando el comando `groups`.*

```
groups usuario1
>usuario1 : usuario1 grupo1

groups usuario2
>usuario2 : usuario2 grupo2

```

***4. Eliminar Grupo:*** *Elimina `grupo2`.*

```
sudo groupdel grupo2
```

# *Parte 3: Gestión de Permisos*

***1. Creación de Archivos y Directorios:***

*   *Como `usuario1`, crea un archivo llamado `archivo1.txt` en su directorio principal y escribe algo en él.*

    ```
    su - usuario1
    echo "Escribiendo contenido del archivo 1" > ~/archivo1.txt
    ```

*   *Crea un directorio llamado `directorio1` y dentro de ese directorio, un archivo llamado `archivo2.txt`.*

    ```
    mkdir ~/directorio1
    echo "Escribiendo contenido del archivo 2" > ~/directorio1/archivo2.txt
    ```

***2. Verificar Permisos:*** *Verifica los permisos del archivo y directorio usando el comando `ls -l` y `ls -ld` respectivamente.*

```
ls -l ~/archivo1.txt

> -rw-r--r-- 1 usuario1 usuario1 21 Aug  4 10:00 /home/usuario1/archivo1.txt

```

```
ls -ld ~/directorio1

> drwxr-xr-x 2 usuario1 usuario1 4096 Aug  4 10:00 /home/usuario1/directorio1
```

***3. Modificar Permisos usando `chmod` con Modo Numérico:*** *Cambia los permisos del `archivo1.txt` para que sólo `usuario1` pueda leer y escribir (permisos `rw-`), el grupo pueda leer (permisos `r--`) y nadie más pueda hacer nada.*

```
sudo chmod 640 ~/archivo1.txt
```

*Verificamos nuevamente los permisos:*

```
ls -l ~/archivo1.txt

> -rw-r----- 1 usuario1 usuario1 21 Aug  4 10:00 /home/usuario1/archivo1.txt

```

***4. Modificar Permisos usando `chmod` con Modo Simbólico:*** *Agrega permiso de ejecución al propietario del `archivo2.txt`.*

```
sudo chmod u+x ~/directorio1/archivo2.txt
```

*Verificamos los permisos:*

```
ls -l ~/directorio1/archivo2.txt

> -rwxr-xr-x 1 usuario1 usuario1 21 Aug  4 10:00 /home/usuario1/directorio1/archivo2.txt
```

***5. Cambiar el Grupo Propietario:*** *Cambia el grupo propietario de `archivo2.txt` a `grupo1`.*

```
sudo chown :grupo1 ~/directorio1/archivo2.txt
```

*Verificamos:*

```
ls -l ~/directorio1/archivo2.txt

> -rwxr-xr-x 1 usuario1 grupo1 21 Aug  4 10:00 /home/usuario1/directorio1/archivo2.txt
```

***6. Configurar Permisos de Directorio:*** *Cambia los permisos del `directorio1` para que sólo el propietario pueda entrar (permisos `rwx`), el grupo pueda listar contenidos pero no entrar (permisos `r--`), y otros no puedan hacer nada.*

```
sudo chmod 741 ~/directorio1
```

*Verificamos permisos:*

```
ls -ld ~/directorio1

> drwxr----x 2 usuario1 usuario1 4096 Aug  4 10:00 /home/usuario1/directorio1
```

***7. Comprobación de Acceso:*** *Intenta acceder al `archivo1.txt` y `directorio1/archivo2.txt` como `usuario2`. Nota cómo el permiso de directorio afecta el acceso a los archivos dentro de él.*

```
su - usuario2
cat /home/usuario1/archivo1.txt

> cat: /home/usuario1/archivo1.txt: Permission denied

cat /home/usuario1/directorio1/archivo2.txt

> cat: /home/usuario1/directorio1/archivo2.txt: Permission denied
```

***8. Verificación Final:*** *Verifica los permisos y propietario de los archivos y directorio nuevamente con `ls -l` y `ls -ld`.*

```
ls -l /home/usuario1/archivo1.txt

> -rw-r----- 1 usuario1 usuario1 21 Aug  4 10:00 /home/usuario1/archivo1.txt
```

```
ls -l /home/usuario1/directorio1/archivo2.txt

> --rwxr-xr-x 1 usuario1 grupo1 21 Aug  4 10:00 /home/usuario1/directorio1/archivo2.txt
```

```
ls -ld /home/usuario1/directorio1

> drwxr----x 2 usuario1 usuario1 4096 Aug  4 10:00 /home/usuario1/directorio1
```

# *Reflexión: (Opcional)*
*Contestar las siguientes preguntas:*

*   ***¿Por qué es importante gestionar correctamente los usuarios y permisos en un sistema operativo?***

    *Manejar correctamente los permisos nos asegura un control sobre los usuarios que tiene acceso a datos y archivos sensibles de esta forma se protegen contra accesos no autorizados.*

*   ***¿Qué otros comandos o técnicas conocen para gestionar permisos en Linux?***

    ***chown:*** *Cambia el propietario y/o grupo de archivos y directorios.*

    ***chgrp:*** *Cambia el grupo de archivos y directorios.*