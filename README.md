# Govc

Imagen de Docker minima con el binario de govc.

## Uso

Para ver la lista completa de comandos disponibles en govc ingresar a la documentación de govc https://github.com/vmware/govmomi/blob/master/govc/USAGE.md


Para poder ejecutar govc se deben definir unas variables:
- GOVC_URL: url de la instancia vcenter a conectarse.
- GOVC_USERNAME: nombre de usuario a utilizar.
- GOVC_PASSWORD: contraseña a utilizar.

Mediante el siguiente comando se podrá utilizar la herramienta:
```console
docker run --rm -it -e GOVC_URL=$VMWARE_URL \ 
		-e GOVC_USERNAME=$VMWARE_USER \
		-e GOVC_PASSWORD=$VMWARE_PASS \
		-e GOVC_INSECURE=true mikroways/govc
```


# Simplificando el uso Dockerizado

Para simplificar el uso de esta herramienta, se utilizara un script llamado govc, este script sera agregado al PATH y de esta manera se podra ejecutar esta herramienta dockerizada como un comando mas.


* Copiamos las siguientes lineas y lo guardamos en un archivo llamado govc:

```bash
#!/bin/bash
docker run --rm -it \
  -e GOVC_URL=$VMWARE_URL \
  -e GOVC_USERNAME=$VMWARE_USER \
  -e GOVC_PASSWORD=$VMWARE_PASS \
  -e GOVC_INSECURE=true \
  mikroways/govc "$@" 
```

* Creamos una carpeta llamada .bin.mikroways en el HOME, dentro de esta carpeta se encontraran los scripts provistos por Mikroways y en donde se debe copiar el script de govc:

```bash
mikroways@mikroways-n01: $ mkdir ~/.bin.mikroways && cp /directorio/govc ~/.bin.mikroways/
```

* Agregar al PATH este directorio, de esta manera se podran ejecutar todos los scripts que se encuentran en este directorio
 
```bash
mikroways@mikroways-n01: $ echo 'export PATH="$HOME/.bin.mikroways:$PATH"' >> ~/.bashrc
```


# Ejemplos

A continuación se detallaran algunos ejemplos para ver el uso de govc.

## Listar Datacenters

```bash
geronimo@mikroways-n01:~ $ govc ls
/Datacenter-01
/Datacenter-02
/Datacenter-03
```

## Listar VMs

Para listar las VMs se debe indicar un datacenter especifico:

```bash
geronimo@mikroways-n01:~ $ govc ls /Datacenter-01/vm
```

Fácilmente se podrían listar todas las VMs de todos los datacenters. Por ejemplo, listar las VMs del Datacenter-01, Datacenter-02 y Datacenter-03:

```bash
geronimo@mikroways-n01:~ $ govc ls /*/vm/*
/Datacenter-01/vm/vm-01
/Datacenter-01/vm/vm-02
/Datacenter-01/vm/vm-03
/Datacenter-01/vm/vm-04
/Datacenter-02/vm/vm-01
/Datacenter-02/vm/vm-02
/Datacenter-02/vm/vm-03
/Datacenter-03/vm/vm-01
/Datacenter-03/vm/vm-02
```

## Buscar VMs

* Buscar VMs a partir del nombre con el cual fueron creadas las VMs, por ejemplo, se listaran todas las IPs de todas las VMs listadas anteriormente, a partir de uno de los datacenters y un critero especifico en la búsqueda del nombre.

```bash
geronimo@mikroways-n01:~ $ govc vm.ip -dc Datacenter-01 vm-0*
192.168.246.40
192.168.246.24
192.168.246.22
192.168.246.27
```
Se buscaron todas las VMs que se encuentran en el Datacenter-01 y cuyo nombre comienza con vm-0.

## Reiniciar VMs

Para listar una VM se debe tener el path completo, donde se encuentra la VM a reiniciar.

```bash
geronimo@mikroways-n01:~ $ govc vm.power -reset true /Datacenter-02/vm/vm-02
```
