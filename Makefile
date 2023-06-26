all:
	# @docker compose -f ./srcs/docker-compose.yml up -d --build
	docker-compose -f ./srcs/docker-compose.yml up --build

down:
	# @docker compose -f ./srcs/docker-compose.yml down
	docker-compose -f ./srcs/docker-compose.yml down -v

re:
	# @docker compose -f srcs/docker-compose.yml up -d --build
	docker-compose -f ./srcs/docker-compose.yml up --build

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\

.PHONY: all re down clean