# Instalando kubectl-ai

Ahora vamos a instalar kubectl-ai siguiendo los pasos oficiales que aparecen en [su repositorio de GitHub](https://github.com/GoogleCloudPlatform/kubectl-ai).

## Instalacion de kubectl-ai

(si bien aqui esta la forma de instalarlo, por favor, revise [el repositorio por si cambio algo en el ultimo periodo](https://github.com/GoogleCloudPlatform/kubectl-ai?tab=readme-ov-file#installation))

Para instalar aqui en killercoda, podemos hacer lo siguiente:

```bash:
curl -sSL https://raw.githubusercontent.com/GoogleCloudPlatform/kubectl-ai/main/install.sh | bash
```{{exec}}

Con esto ya tenemos instalado kubectl-ai, ahora si corremos el comando `kubectl-ai version`{{exec}} deberiamos ver algo como esto:

```bash:
$ kubectl-ai version
version: 0.0.14
commit: bc554dfd71e2829cd8986223a35ec738b2686367
date: 2025-06-17T01:33:09Z
```

(posiblemente la version sea diferente, pero no importa, lo importante es que se instalo correctamente)

Sigamos con el siguiente paso.
