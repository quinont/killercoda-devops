# kubectl-ai: Porque a veces `kubectl` se queda corto...

Hasta en los peores momentos, hay una solución para todo... (o bueno, casi todo).

Veamos qué tiene que decir `kubectl-ai` al respecto.

## Pidiendo ayuda a nuestro agente...

Antes de lanzarnos de cabeza, es crucial entender cómo funciona `kubectl-ai`.

Imagina `kubectl-ai` como tu traductor personal para la _API de Kubernetes_. Transforma nuestras peticiones en *lenguaje natural* en los *comandos*, a veces crípticos, que Kubernetes entiende.

Por ejemplo, en lugar de ejecutar el clásico `kubectl get pod -A`{{exec}} para ver todos los pods, podrías simplemente pedirlo en lenguaje humano: `echo "listar todos los pods que existen en mi cluster" | kubectl-ai --model gemini-1.5-flash `{{exec}}.

Detrás de escena, cada pregunta que le haces se envía a un Modelo de Lenguaje Grande (LLM). Este modelo interpreta tu solicitud y decide si necesita ejecutar comandos contra la API de Kubernetes para obtener una respuesta.

Cada interacción con `kubectl-ai` puede resultar en tres escenarios:
- **Una respuesta teórica:** El LLM responde directamente sin necesidad de acceder a tu clúster.
- **Una consulta de solo lectura:** Ejecuta un comando que no altera el estado del clúster (por ejemplo, `get pods`, `describe pod`, etc.).
- **Una acción de modificación:** ¡Exacto! `kubectl-ai` puede ayudarte a modificar el clúster. Pero no te preocupes, siempre te pedirá confirmación antes de aplicar cualquier cambio.

> [IMPORTANTE]
>
> ¡Cuidado, padawan! Las versiones actuales de `kubectl-ai` a veces pueden entrar en un bucle infinito si rechazas una acción. Posiblemente esto se solucione en futuras versiones, pero por ahora, ten siempre a mano el sagrado `Control+C` para evitar que tus tokens de API se evaporen en el éter.

## ¡Basta de teoría! Manos a la obra

Para iniciar una sesión interactiva con `kubectl-ai`, simplemente ejecuta el siguiente comando:

```bash
kubectl-ai --model gemini-2.5-pro
```{{exec}}

Una vez ejecutado, se abrirá un chat en tu terminal para que puedas interactuar:

```text
$ kubectl-ai --model gemini-2.5-pro

  Hey there, what can I help you with today?  


>>>  
```

> [TIP]
>
> Te animo a experimentar con diferentes modelos. Prueba la diferencia de velocidad y calidad entre `gemini-1.5-flash` y `gemini-2.5-flash`. ¡Los resultados pueden sorprenderte!

Dado que `kubectl-ai` es un agente con \"conexión\" a la API de Kubernetes (en realidad, ejecuta comandos `kubectl` por ti), la calidad de tu *prompt* es crucial. Un buen prompt puede marcar la diferencia entre una solución brillante y un resultado confuso.

Vamos a darle todo el contexto que tenemos hasta ahora:
- Nuestra app está en el namespace `ej1`.
- Tenemos un Servicio y un Deployment.
- Al intentar acceder al servicio NodePort en el puerto `31080`, recibimos un error.
- Queremos que nos explique y solucione el problema.
- Y lo más importante, como la eficiencia (o la pereza) es nuestra virtud, queremos que toda la explicación esté en español.

Con todo esto en mente, nuestro prompt será:

```
En el namespace ej1 levanté un deployment y un servicio. Al hacer un "curl http://localhost:31080" tengo un error que dice: "(7) Failed to connect to localhost port 31080 after 1 ms: Couldn't connect to server". No tengo ningun problema de networking, es algo que esta mal entre el servicio y los pods. necesito que arregles el problema. Quiero que me expliques todo en español.
```{{exec}}

> [RECOMENDACIÓN]
>
> Te recomiendo que juegues un poco. Cierra y abre la sesión de `kubectl-ai` varias veces. Prueba a cambiar el prompt, dándole más o menos detalles. Es muy interesante observar cómo varían las respuestas del agente.

Una vez enviado el prompt inicial, el kubectl-ai lo enviara al LLM y despues ejecutará los comandos de `kubectl` que considere necesarios para construir su contexto. Cuando identifique la causa del problema, te ofrecerá una explicación detallada y un plan de acción.

Y aquí es donde ocurre la magia: `kubectl-ai` se ofrecerá a ejecutar la solución por ti. Si no te convence, ¡puedes pedirle que busque una alternativa!

## Explicando el problema

El origen de nuestro dolor de cabeza es un clásico error de tipeo en los manifiestos: el selector del Servicio no coincide con las etiquetas de los Pods.

El Servicio está intentando seleccionar pods con la etiqueta `app=my-app`, pero nuestros pods en realidad no tienen esa etiqueta. Puedes comprobarlo tú mismo. Si le pides a Kubernetes los pods con esa etiqueta, no encontrará nada:

```bash
kubectl get pod -n ej1 -l \"app=my-app\"
```{{exec}}

El resultado de este comandos sera vacio y ese es el problema, pero si ejecutamos:

```bash
kubectl get pod -n ej1 -l \"app=myapp\"
```{{exec}}

Obtendremos los pods del cluster.

### ¿Cómo solucionamos esto?

Para arreglarlo, tenemos dos caminos principales:
1.  Modificar la etiqueta (`label`) en la plantilla del Deployment para que coincida con el selector del Servicio.
2.  Modificar el selector (`selector`) del Servicio para que coincida con la etiqueta de los Pods.

La solución más rápida y con menor impacto suele ser modificar el Servicio, pero esto siempre dependerá del contexto de tu aplicación y de cuál fue el error original.

Solución propuesta por el agente:
```bash
kubectl patch svc my-app --type='merge' -p '{\"spec\": {\"selector\": {\"app\": \"myapp\"}}}' -n ej1
```{{exec}}

# Probando el servicio después del arreglo

Con el parche aplicado, intentemos de nuevo acceder al servicio:

```bash
curl http://localhost:31080
```{{exec}}

Si todo salió bien, deberías ver la gloriosa respuesta:

```text
Ahora si funciona!! :D
```

Continuemos al siguiente paso para revisar las consideraciones finales...