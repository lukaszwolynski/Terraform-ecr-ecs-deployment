# ecr-ecs-deployment

Dockerize a simple flask app then push a docker image to private Elastic Container Registry. Then create a Elastic Container Service cluster that will use that image. Application Load Balancer routes traffic to a container.

You will need to change subnets and vpc ids in variables.tf file. That is the only required action.

To create infrastracutre run: python build_infrastracture.py

To destroy: build_infrastracture.py
