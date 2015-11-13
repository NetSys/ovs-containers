# OVS Docker Container
These scripts build the image used by containers running ovs-vswitchd.

To build just run `docker build -t ovs .` followed by `docker images` and take
note of the image ID of the newly built image tagged "ovs".

Login to your docker hub account with `docker login` then run `docker push
<image_id> <your_docker_hub_username>/<some_image_name>:latest`.
