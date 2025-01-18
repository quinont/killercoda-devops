# Levantemos el balanceador

Vamos a configurar un balanceador de carga simple utilizando **Nginx**. Este paso es clave para que las peticiones lleguen correctamente a nuestra aplicación.

## Archivo de configuración `default.conf`

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
    }
}

server {
    listen 80 default_server;
    server_name _;

    return 403;
}
```

**¿Qué hace este archivo?**
- **Primer bloque:** Redirige todas las solicitudes hacia nuestra aplicación (que está corriendo en `IP-DE-LA-APP:8080`).
- **Segundo bloque:** Configura un servidor por defecto para rechazar cualquier petición no deseada. 🛑

## ¿Cuál es la IP del container de la app?

Para encontrar la IP del container de nuestra app, usa el siguiente comando:

```bash
docker inspect CONTAINER_ID
```

No olvides reemplazar `CONTAINER_ID` por el identificador del container de la aplicación.

## Levantemos el container

Ahora que tenemos el archivo de configuración, ¡es hora de poner manos a la obra con Docker! 💪

**Sigue estos pasos al pie de la letra para evitar errores que puedan complicar el laboratorio:**

1. **Nombre del container:** `nginx`
2. **Puertos:** Mapear el puerto `8080` del nodo al puerto `80` del container.
3. **Montar el archivo de configuración:**
   - El archivo `default.conf` se montará en la ruta `/etc/nginx/conf.d/default.conf` dentro del container.
4. **Imagen:** Usaremos la imagen oficial de Nginx `nginx:1.27.3-alpine`.


## Validemos que todo funciona

Para verificar que todo está configurado correctamente, ejecuta:

```bash
curl http://localhost:8080/
```

Si aparece la siguiente respuesta:

```html
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.27.3</center>
</body>
</html>
```

Esto indica que Nginx está funcionando, pero las solicitudes no están llegando a la aplicación. 🛠️

---

Revisa tu configuración y asegúrate de que todo esté correctamente enlazado para probar la aplicación en el siguiente paso.


