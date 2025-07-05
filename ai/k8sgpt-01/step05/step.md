# Resumen

Ahora que ya revisamos el poder de k8sgpt, es importante revisar algunos puntos claves.

- Esta es la forma mas simple de usar k8sgpt, pero no es la unica.
- Puedes cambiar el formato de salida a JSON, lo cual es mas facil de procesar si estas usando una aplicacion.
- Puedes usar otros backends como OpenAI, Azure, etc. (incluso no ocupar ningun LLM, mejor pero aburrido no?).
- Puedes levantar K8sGPT como un MCP server para trabajar de forma mas interactiva.
- K8sGPT tiene un modo de "anonymize" lo que hace un hash de los nombres de los recursos para mas seguridad y privacidad al ocupar con las apis de los LLMs.

## Como funciona K8sGPT

La estructura de K8sGPT es simple y poderosa a la vez.

K8sGPT se basa en un conjunto de validaciones basicas de problemas comunes en Kubernetes, K8sGPT los llama `Analyzers`, Que identifican los posibles errores, y arman un prompt explicando el problema y pidiendo una solucion.
Una vez que se evaluan todos los errores y con el prompt armado, K8sGPT envia el prompt a un LLM que le devuelve una respuesta simple de como resolver el problema.

Lo bueno:
- Es deterministico, siempre el resultado va a ser parecido.
- Problemas comunes son rapidos de detectar y resolver.

Lo malo:
- No hace el trabajo por nosotros, tenemos que interpretar la respuesta y arreglarlo nosotros.
- Errores no contemplados no son detectados, deberiamos hacer custom analyzers para esos casos.


## Siguientes pasos

- Sigue probando K8sGPT con diferentes parametros y configuraciones.
- Revisa otros errores que puede trabajar.
- Aplica algun script simple que pueda tomar la salida de K8sGPT y revisar mejor el error.


# Conclusiones de K8sGPT

K8sGPT es una herramienta poderosa y simple para los problemas comunes de kubernetes. Si bien TODAVIA no puede solucionar los problemas por nosotros, es posible que en un futuro si lo haga, la comunidad es extremadamente activa y salen versiones nuevas cada tanto. 

Posiblemente este lab quede obsoleto en un par de meses, pero todo lo referido con IA es asi.

Es importante entender que K8sGPT nos va a ayudar mucho, pero tenemos que entender las bases de kubernetes para poder interpretar las respuestas y solucionar los problemas mas facil.

