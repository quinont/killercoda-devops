# K8sGPT al rescate!!

Hasta en los peores momentos, hay una solucion para todo...

Ahora vemos que nos dice K8sGPT...

## K8sGPT al rescate!

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
Pod 'my-app-xxxx-xxxx' tiene un error de conexión. El servicio no está disponible en el puerto 80. Asegúrate de que el contenedor esté escuchando en el puerto correcto y que el servicio esté configurado para redirigir al puerto correcto.
```

Es importante entender que este resultado puede cambiar con las distintas ejecuciones, podrias volver a ejecutar el comando y podriamos obtener un texto con unas pequeñas diferencias, pero la idea es la misma.

> [!TIP]
> Este output podemos cambiarlo para que nos muestre en un formato de JSON lo cual es mas facil de leer y procesar si estamos con una aplicacion (ejemplo un pipeline de despliegue que fallo).

## Solucionando el problema

Ahora es cuestion de manos a la obra para solucionar el problema. Si lamentablemente por ahora K8sGPT no puede hacer el trabajo por nosotros, pero si nos ayuda a identificar el problema y como solucionarlo.

Solucion propuesta:
```bash
kubectl patch svc my-app --type='merge' -p '{"spec": {"selector": {"app": "myapp"}}}'
```{{exec}}

Ahora podremos probar de nuevo a ver si llegamos al servicio, ejecuta el siguiente comando:

```bash
curl http://localhost:31080 -v
```{{exec}}

Si todo salio bien, deberias ver una respuesta 200.


Continuemos al siguiente paso para revisar las consideraciones finales...