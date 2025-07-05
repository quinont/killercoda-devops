# K8sGPT al rescate!!

Hasta en los peores momentos, hay una solucion para todo...

Ahora vemos que nos dice K8sGPT...

## Pidiendo ayuda a K8sGPT...

Si bien K8sGPT tiene muchas formas de trabajar, aqui vamos a revisar la mas basica que es la forma de CLI (Command Line Interface).

Para invocar a K8sGPT, vamos a usar el comando `k8sgpt` de la siguiente manera:

```bash
k8sgpt analyze --explain --backend google -n ej1 -l Spanish
```{{exec}}

En donde:
- `analyze` es el comando que le dice a K8sGPT que queremos analizar
- `--explain` es una opcion que le dice a K8sGPT que queremos que nos explique el resultado
- `--backend google` para decir explicitamente que queremos google como backend (LLM)
- `-n ej1` es el namespace donde estamos trabajando (esto es importante, si no especificamos el namespace, K8sGPT buscara en todo el cluster, esto puede demorar mucho y salir muy caro xD)
- `-l Spanish` es el idioma en el que queremos que nos responda K8sGPT (para hacer mas facil las cosas no?)

Si todo sale bien, deberias ver una respuesta de K8sGPT que te indica el error que tiene el pod y como solucionarlo.

## Revisando el resultado

Revisemos el resultado que nos dio K8sGPT, deberias ver algo como esto:

```text
AI Provider: google

0: Service ej1/my-app()
- Error: Service has no endpoints, expected label app=my-app
---
El servicio no tiene endpoints, se esperaba la etiqueta app=my-app
---

Error: Service can't find pods with the label 'app=my-app'.

Solution:
1.  Check pod labels.
2.  Verify service selector matches pod labels.
3.  Restart pods or service.
```

Es importante entender que este resultado puede cambiar con las distintas ejecuciones, podrias volver a ejecutar el comando y podriamos obtener un texto con unas pequeñas diferencias, pero la idea es la misma.

> [Consejo]
>
> Este output podemos cambiarlo para que nos muestre en un formato de JSON lo cual es mas facil de leer y procesar si estamos con una aplicacion (ejemplo un pipeline de despliegue que fallo).

## Solucionando el problema

Ahora es cuestion de manos a la obra para solucionar el problema. Si lamentablemente por ahora K8sGPT no puede hacer el trabajo por nosotros, pero si nos ayuda a identificar el problema y como solucionarlo.

### Pero que paso?

Como nos indica el mensaje de K8sGPT: "El servicio no tiene endpoints, se esperaba la etiqueta app=my-app", esto significa que si ejecutamos el siguiente comando:

```bash
kubectl get pod -n ej1 -l "app=my-app"
```{{exec}}

obtendremos un resultado vacio, lo que significa que no hay pods que tengan el label `app=my-app`, y por lo tanto, el servicio no puede encontrar estos pods.

### Como solucionamos esto?

Para arreglar esto podemos lo podemos trabajar de dos formas:
1. Modificar el label de los pods en el deployment para que coincida con el label del servicio.
2. Modificar el selector del servicio para que coincida con el label de los pods.

En la solucion que se propone, es modificar el selector del servicio, que es mas rapido y sencillo de hacer.

Solucion propuesta:
```bash
kubectl patch svc my-app --type='merge' -p '{"spec": {"selector": {"app": "myapp"}}}' -n ej1
```{{exec}}

Ahora podremos probar de nuevo a ver si llegamos al servicio, ejecuta el siguiente comando:

```bash
curl http://localhost:31080 -v
```{{exec}}

Si todo salio bien, deberias ver una respuesta:

```text
Ahora si funciona!! :D
```


Continuemos al siguiente paso para revisar las consideraciones finales...
