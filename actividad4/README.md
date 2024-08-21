# *Actividad 4*

*Crear un systemd unit de tipo servicio que realice lo siguiente.*

*   *Ejecutar un script imprima un saludo y la fecha actual infinitamente con una pausa de un segundo.*

*   *Habilitar el servicio para que se inicie con el sistema.*

<br>

# Pasos para Habilitar el Servicio

## Paso 1: Crear script 
*Copie el script [saludo.sh](./saludo.sh) en `/usr/local/bin`*

*   *Colocar la ruta donde se encuetra el script.*

```
sudo cp /home/usuario/scripts/saludo.sh /usr/local/bin/
```

*o cree un script en `/usr/local/bin`* 

```saludo.sh
# saludo.sh

#!/bin/bash

while true; do
    echo "Saludos, hoy es: $(date)"
    sleep 1
done
```

*   *Agregar los permisos: `sudo chmod +x /usr/local/bin/saludo.sh
`*

## Paso 2: Crear servicio

Copia el archivo [saludo.service](./saludo.service) en `/etc/systemd/system`*

*   *Colocar la ruta donde se encuetra el archivo `.service`*

```
sudo cp /home/usuario/systemd/saludo.service /etc/systemd/system/
```

*O crea un nuevo archivo en `/etc/systemd/system` llamado `saludo.service`.*

```saludo.service
[Unit]
Description=Servicio de saludo y la fecha actual

[Service]
ExecStart=/usr/local/bin/saludo.sh
Restart=always
User=nobody
Group=nogroup

[Install]
WantedBy=multi-user.target
```

*   *ExecStart especifica el script que quieres ejecutar.*

*   *Restart=always asegura que el servicio se reinicie automáticamente si se detiene.*

*   *User y Group definen el usuario y grupo con los que se ejecutará el servicio. Puedes cambiar nobody y nogroup por el usuario y grupo que prefieras.*


## Paso 3: Habilitar Servicio
*Habilitar y arrancar el servicio:*

*   *Recarga el sistema para que reconozca el nuevo servicio:*

```
    sudo systemctl daemon-reload
```

* *Habilitar el servicio para que se inicie al arrancar el sistema:*

```
    sudo systemctl enable saludo.service
```

*   *Iniciar el servicio:*

```
    sudo systemctl start saludo.service
```

*   *Verificar el estado del servicio con el siguiente comando:*

```
    sudo systemctl status saludo.service
```

## Paso 4: Verificar Logs

*Para ver los logs específicos del servicio saludo.service, usa:*

```
sudo journalctl -u saludo.service
```

*Para ver los logs en tiempo real, usa:*

```
sudo journalctl -u saludo.service -f
```

## Paso 5: Detener el Servicio

*Usa el siguiente comando para detenerlo:*

```
sudo systemctl stop saludo.service

```

*Para evitar que el servicio se inicie automáticamente en el futuro, deshabilítalo:*

```
sudo systemctl disable saludo.service
```

*Elimina el archivo de unidad del servicio para que systemd deje de reconocerlo. Asegúrate de que el archivo se encuentre en la ubicación correcta `/etc/systemd/system`:*

```
sudo rm /etc/systemd/system/saludo.service
```

*Recarga el sistema para actualizar su configuración:*

```
sudo systemctl daemon-reload
```

*Elimina el script (opcional):*

```
sudo rm /usr/local/bin/saludo.sh
```