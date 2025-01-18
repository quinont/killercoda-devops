# Levantemos el balanceador

Vamos a configurar un balanceador de carga simple utilizando **Nginx**. Este paso es clave para que las peticiones lleguen correctamente a nuestra aplicación.

### Archivo de configuración `default.conf`

Primero, necesitamos un archivo de configuración llamado `default.conf`. Este es el contenido del archivo:

```nginx
server {
    listen 80;
    server_name www.aprendamos-docker.com *.aprendamos-docker.com;

    root /usr/local/nginx/html;

    location / {
        proxy_pass http://IP-DE-LA-APP:8080;

        proxy_connect_timeout 5s;
        proxy_send_timeout 5s;
        proxy_read_timeout 5s;

        proxy_redirect http://IP-DE-LA-APP:8080/ /;
    }
}

server {
    listen 80 default_server;
    server_name _;

    return 403;
}
```{{copy}}

**¿Qué hace este archivo?**
- **Primer bloque:** Redirige todas las solicitudes hacia nuestra aplicación (que está corriendo en `IP-DE-LA-APP:8080`).
- **Segundo bloque:** Configura un servidor por defecto para rechazar cualquier petición no deseada. 🛑

### ¿¿Cuales es la IP del container de la app??

Para poder encontrar cual es el container de nuestra app, lo mejor es comenzar a buscar con el comando 

```
docker inspect
```{{copy}}

No te olvides de poner el indentificador del container de la app.

### Levantemos el container

Ahora que tenemos el archivo de configuración, ¡es hora de poner manos a la obra con Docker! 💪

Por favor, seguir estos datos de forma correcta, dado a que un error puede llegar a no funcionar el comprobador para terminar el laboratorio:

1. **Nombre del container:** `nginx`
2. **Puertos:** Vamos a mapear el puerto `8080` del nodo al puerto `80` del container.
3. **Montar el archivo de configuración:**
   - El archivo `default.conf` lo vamos a montar en el container en la ruta `/etc/nginx/conf.d/default.conf`.
4. **Imagen:** Usaremos la imagen oficial de Nginx `nginx:1.27.3-alpine`.


### Validemos que todo funciona

Para poder validar si estamos correctamente, tenemos que hacer lo siguiente:

```
curl http://localhost:8080/
```{{exec}}

Momento.... esto parece no funcionar, que esta pasando?

---

Verifiquemos si todo esta bien, y vayamos al ultimo paso para ver como probar la aplicacion.


