#OVSDB Docker Container
These scripts build the image used by containers running ovsdb-server.

To build just run `docker build -t ovsdb .` followed by `docker images`
and take node of the image ID of the newly build image tagged "ovsdb".

Login to your docker hub account with `docker login` then run `docker push
<image_id> <your_docker_hub_username>/<some_image_name>:latest`.
