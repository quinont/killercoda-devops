# Probando el escenario

Como vimos anteriormente, la forma de probar esto:

```
curl http://localhost:8080/
```

No esta funcionado, pero ¿por que pasa esto?

Primero, analicemos el log del nginx.

## Viendo logs de containers en docker

Para este caso lo que tenemos que hacer es ocupar el comando `logs`, por lo tanto:

```
docker logs CONTAINER
```

Cambiemos `CONTAINER` por el identificador del container que queremos ver el error. En este caso, el nginx.

¿Vemos las solicitudes que llegan?


## Las solicitudes llegan

Las solicitudes de `curl` estan llegando. Entonces?

El nginx esta configurado para responder solo a ciertos dominios, en este caso `www.aprendamos-docker.com`.

> OK, ocupemos ese dominio o no?

Si podriamos modificar el `/etc/hosts` del nodo, pero tenemos un mecanismo mas simple para hacerlo.

> CUAL?

La idea es ocupar el header host de http. La idea es ejecutar el comando curl, pero ahora con el header necesario indicando el dominio

Nos queda de esta forma:

```
curl --headers "Host: www.aprendamos-docker.com" http://localhost:8080/
```{{copy}}

De esta forma si llegamos a la aplicacion destino.

Continuemos con el siguiente escenario.
