# Probando el escenario

Como vimos anteriormente, la forma de probar esto:

```bash
curl http://localhost:8080/
```

Nos devuelve un 403, por lo tanto, las solicitudes no estan llegando al backend... ¿Por qué pasa esto?

Primero, analicemos el log de Nginx.

## Viendo logs de containers en Docker

Para este caso, usaremos el comando `logs`. Así que ejecuta lo siguiente:

```bash
docker logs CONTAINER
```

Reemplaza `CONTAINER` con el identificador del container que queremos inspeccionar. En este caso, el container de Nginx.

¿Puedes ver las solicitudes que llegan? ¡Perfecto! Sigamos investigando.

## Las solicitudes llegan

Las solicitudes de `curl` están llegando al Nginx. Entonces, ¿cuál es el problema?

El Nginx está configurado para responder solo a ciertos dominios, en este caso, `www.aprendamos-docker.com`.

> ¿Deberíamos modificar el archivo `/etc/hosts` del nodo para resolver esto?

Podríamos hacerlo, pero existe un mecanismo más simple.

> ¿Cuál?

Podemos utilizar el encabezado `Host` en la solicitud HTTP. Para ello, ejecutaremos el comando `curl`, pero añadiendo el encabezado necesario que indica el dominio:

```bash
curl --header "Host: www.aprendamos-docker.com" http://localhost:8080/
```

De esta forma, las solicitudes llegarán correctamente a la aplicación destino. 🎉

¡Continuemos con el siguiente escenario!


