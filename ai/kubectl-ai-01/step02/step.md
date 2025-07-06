# Primeros pasos en kubectl-ai

Excelente, ya llegamos hasta aqui. Si bien, kubectl-ai tiene compatibilidad con los LLM mas importantes, aqui vamos a trabajar con el token de Gemini de google AI Studio.


## Configurando el LLM

Por favor, crear una cuenta en [Google AI Studio](https://aistudio.google.com/) y crear un token de acceso a la API. (importante: no te olvides de eliminarlo una vez que termines el lab).


# Configurando el LLM en kubectl-ai

Para trabajar con google AI studio, lo unico que necesitamos es crear una variable de entorno que posea el valor del token, por lo tanto vamos a ejecutar el siguiente comando:

```bash
read -s -p "Pegue su token de Gemini API (no será visible): " GEMINI_API_KEY; export GEMINI_API_KEY; echo;
```{{exec}}

Esto nos abrira una opcion para escribir el token y no se mostrara el texto por pantalla.

> [Consejo]
>
> Si bien podemos ocupar cualquier LLM, mientras sea una version de "razonamiento", por lo tanto la version de gemini-2.5-pro puede demostrar mejores resultados que la gemini-2.5-flash

# Todo Listo

Bueno, continuemos con el siguiente paso...