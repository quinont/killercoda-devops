# Manos a la obra con nuestro artefacto

Es hora de poner a prueba el k8sGPT con un escenario de ejemplo. Vamos a desplegar un artefacto que tiene un error intencional para que k8sGPT pueda ayudarnos a solucionarlo.

## Manifest con error

Tenemos un archivo con un deployment y un service, puedes revisar como esta formado con el siguiente comando:

```bash
cat /root/manifests.yaml
```{{exec}}

Revisa con cuidado el archivo...

Pudiste encontrar el error? Si no, no te preocupes, k8sGPT te ayudara a encontrarlo.

## Desplegando el artefacto

Antes de continuar, tenemos que generar el namespace donde vamos a desplegar el artefacto. Para eso, ejecuta el siguiente comando:

```bash
kubectl create namespace ej1
```{{exec}}

Y ahora a desplegar el artefacto, ejecuta el siguiente comando:

```bash
kubectl apply -f /root/manifests.yaml -n ej1
```{{exec}}

## Verificando el estado del despliegue

Revisemos el pod que se ha creado, ejecuta el siguiente comando:

```bash
kubectl get pods -n ej1
```{{exec}}

Para revisar el servicio, ejecuta el siguiente comando:

```bash
kubectl get svc -n ej1
```{{exec}}

Si todo salio bien, deberias ver un pod con el nombre `my-app-xxxxxxxxx-xxxxx` y el estado `Desplegando`.

Ahora llamemos invoquemos al servicio mediante el *NodePort* que se ha creado, ejecuta el siguiente comando:

```bash
curl http://localhost:31080 -v
```{{exec}}

_Ohh noo!_, tenemos un error de `Couldn't connect to server` :( 

Que haremos ahora??? No te preocupes, k8sGPT esta aqui para ayudarnos (o eso esperamos...).

Vamos al siguiente paso...