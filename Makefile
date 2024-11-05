# Set the path to the Docker Compose file in ./srcs
DCOMPOSE_FILE=./srcs/docker-compose.yml

WP_DATA := /home/imisumi-wsl/dev/Inception/wp_data
DB_DATA := /home/imisumi-wsl/dev/Inception/db_data

# Bring down containers, remove volumes, and prune Docker resources
# clean:
# 	docker-compose -f $(DCOMPOSE_FILE) down -v
# 	docker system prune -a --volumes -f
# 	rm -rf $(WP_DATA)
# 	rm -rf $(DB_DATA)
# Define the "clean" target
clean:
	@read -p "Are you sure you want to delete all database data? This will remove $(DB_DATA) and $(WP_DATA). Type 'y' to confirm: " confirm; \
	if [ "$$confirm" = "y" ]; then \
		docker-compose -f $(DCOMPOSE_FILE) down -v; \
		docker system prune -a --volumes -f; \
		sudo rm -rf $(WP_DATA); \
		sudo rm -rf $(DB_DATA); \
		echo "Cleaned up successfully."; \
	else \
		echo "Cleanup aborted."; \
	fi

# Build and start containers
up:
	mkdir -p $(WP_DATA)
	mkdir -p $(DB_DATA)
	docker-compose -f $(DCOMPOSE_FILE) up --build -d

# Stop and remove containers
down:
	docker-compose -f $(DCOMPOSE_FILE) down

# Show status of containers
status:
	docker-compose -f $(DCOMPOSE_FILE) ps

# View logs for all services
# logs:
# 	docker-compose -f $(DCOMPOSE_FILE) logs -f

# Restart all services (clean start)
re: clean up

reload: down up


# Exec into a running container
exec:
	@echo "Choose a service to exec into:"
	@echo "1. mariadb"
	@echo "2. wordpress"
	@echo "3. nginx"
	@read choice; \
	if [ "$$choice" = "1" ]; then \
		docker exec -it mariadb bash; \
	elif [ "$$choice" = "2" ]; then \
		docker exec -it wordpress bash; \
	elif [ "$$choice" = "3" ]; then \
		docker exec -it nginx bash; \
	else \
		echo "Invalid choice"; \
	fi

# View logs for a specific container
logs:
	@echo "Choose a service to view logs:"
	@echo "1. mariadb"
	@echo "2. wordpress"
	@echo "3. nginx"
	@read choice; \
	if [ "$$choice" = "1" ]; then \
		docker-compose -f $(DCOMPOSE_FILE) logs -f mariadb; \
	elif [ "$$choice" = "2" ]; then \
		docker-compose -f $(DCOMPOSE_FILE) logs -f wordpress; \
	elif [ "$$choice" = "3" ]; then \
		docker-compose -f $(DCOMPOSE_FILE) logs -f nginx; \
	else \
		echo "Invalid choice"; \
	fi

# This rule automatically logs into the MariaDB database
db-login:
	@docker exec -it mariadb mysql -u root -p"root_password" wordpress_db