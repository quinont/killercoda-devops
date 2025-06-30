# Instalando K8sGPT

Ahora vamos a instalar K8sGPT siguiendo los pasos oficiales que aparecen en [su repositorio de GitHub](https://github.com/k8sgpt-ai/k8sgpt).

## Instalacion de K8sGPT

(si bien aqui esta la forma de instalarlo, por favor, revise [el repositorio por si cambio algo en el ultimo periodo](https://github.com/k8sgpt-ai/k8sgpt?tab=readme-ov-file#cli-installation))

Para instalar aqui en killercoda, podemos hacer lo siguiente:

```bash:
curl -LO https://github.com/k8sgpt-ai/k8sgpt/releases/latest/download/k8sgpt_amd64.deb
sudo dpkg -i k8sgpt_amd64.deb
```{{exec}}

Con esto ya tenemos instalado k8sgpt, ahora si corremos el comando `k8sgpt version`{{exec}} deberiamos ver algo como esto:

```bash:
$ k8sgpt version
k8sgpt: 0.4.21 (XXXXXX), built at: unknown
```

(posiblemente la version sea diferente, pero no importa, lo importante es que se instalo correctamente)

Sigamos con el siguiente paso.
