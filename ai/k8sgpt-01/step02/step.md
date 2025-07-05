# Configurando k8sgpt

Excelente, ya llegamos hasta aqui. Ahora tenemos que decirle a k8sgpt que LLM va a utilizar para trabajar con kubernetes.

Si bien puedes ocupar todas estas alternativas:
- openai
- localai
- ollama
- azureopenai
- cohere
- amazonbedrock
- amazonsagemaker
- google
- huggingface
- noopai
- googlevertexai
- watsonxai
- customrest
- ibmwatsonxai

Este lab solo se va a enfocar en la configuracion de Gemini de Google (la opcion de google) ocupando google studio.

> [!TIP]
> Tambien podemos ocupar noopai, que es para que k8sgpt no se conecte a ningun LLM. (mas seguridad? tal vez...)

## Configurando el LLM

Por favor, crear una cuenta en [Google AI Studio](https://aistudio.google.com/) y crear un token de acceso a la API. (importante: no te olvides de eliminarlo una vez que termines el lab).


# Configurando el LLM en k8sgpt

Para configurar el LLM en k8sgpt debemos ejecutar el siguiente comando:

```bash
k8sgpt auth add --backend google --model "gemini-2.0-flash-lite"
```{{exec}}

Y despues nos va a pedir el token.

> [!TIP]
> Podriamos ocupar otro modelo, como por ejemplo `gemini-2.0-flash` o `gemini-2.0-pro`, pero para este lab vamos a ocupar el modelo `gemini-2.0-flash-lite` que es el mas liviano y rapido (ademas mas barato). 
> Para este lab con el modelo mas basico es suficiente. Igual podrias probar cambiar de modelo y ver que tal es el resultado.

# Probando la configuracion

Para validar que hicimos bien la configuracion, podemos correr el siguiente comando:

```bash
k8sgpt auth list
```{{exec}}

Si todo salio bien, deberiamos ver algo como esto:

```bash
$ k8sgpt auth list
Default: 
> google
Active: 
> google
Unused: 
> openai
> localai
> ollama
> azureopenai
> cohere
> amazonbedrock
> amazonsagemaker
> huggingface
> noopai
> googlevertexai
> oci
> customrest
> ibmwatsonxai
```

# Todo Listo

Bueno, continuemos con el siguiente paso...