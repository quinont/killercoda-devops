# Levantemos el balanceador

Y ahora, levantemos el nginx

el archivo de configuracion deberia ser asi:

```
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
```

Con esto hacemos un archivo que se llame default.conf

Ahora a levantar el container:
- Nombre del container: nginx
- Mapear puerto del nodo al container, el 8080 del nodo al puerto 80 del container.
- montar el archivo default.conf a la ubicacion de `/etc/nginx/conf.d/default.conf`
