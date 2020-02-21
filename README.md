##  TERRAFORM - DEPLOY-APP
### Despliegue infraestructura.

## INSTRUCCIONES DE USO ##
* Requiere terraform versión 0.12.20 o superior.
* Debe disponer de un bucket S3 creado para el almacen de los tfstates de terraform, dentro crear un directorio con nombre "states".
* Se debe configurar las credenciales de la cuenta AWS por defecto para AWSCLI.
* Verificar y de ser necesario modificar solo los ficheros "provider" y "variables" de cada stack que se quiera desplegar.

### 1- VPC

Definir si se despliega con 1 NAT o con Multiples NAT (Cambiar valores en variables.tf)

```
terraform init
terraform plan
terraform apply -auto-approve
```

### 2- Grafana

Desplegamos la instancia EC2 con el servicio de Grafana.

```
terraform init
terraform plan
terraform apply -auto-approve
```

### 3- Conectamos val grafana vía http://public-ip:3000  ingresamos con usuario:admin  contraseña:admin 

## Autor

* **[NUBERSIA](https://www.nubersia.com) - Reinaldo León ** 

## Licencia

Este proyecto es realizado por [NUBERSIA](https://www.nubersia.com) como parthner AWS para el despliegue de la [Demo - Monitoring - Grafana](https://grafana.com/)

## Información

* https://www.nubersia.com/es/contacto
* Tel. +34 931 702 156