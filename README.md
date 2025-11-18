# Rails Semantic Logger Reproduction Environment

This is a vanilla Rails 8 application set up to investigate and reproduce issues with the `rails_semantic_logger` gem.

## Setup

This application runs in a Docker container to ensure gem bundle isolation from the system gem set.

### Prerequisites

- Docker and Docker Compose installed
- Port 3000 available
- PostgreSQL database (see Database Configuration below)

### Running the Application

1. **Build and start the container:**
   ```bash
   docker compose up --build
   ```

2. **Access the application:**
   Open http://localhost:3000 in your browser

3. **Run commands in the container:**
   ```bash
   docker compose run --rm web <command>
   ```

   For example:
   ```bash
   # Run Rails console
   docker compose run --rm web rails console
   
   # Run database migrations
   docker compose run --rm web rails db:migrate
   
   # Run tests
   docker compose run --rm web rails test
   ```

### Database Configuration

This application connects to PostgreSQL. Configure your database connection in the `.env` file:

1. **Copy the example environment file:**
   ```bash
   cp .env.example .env
   ```

2. **Configure database connection:**
   - `DATABASE_NAME`: Database name (default: `rails_semantic_logger_repro_database`)
   - `DATABASE_USERNAME`: PostgreSQL username
   - `DATABASE_PASSWORD`: PostgreSQL password
   - `DATABASE_HOST`: PostgreSQL hostname
   - `DATABASE_PORT`: PostgreSQL port (default: `5432`)

3. **Docker Network Configuration (if PostgreSQL is in another Docker container):**
   - If your PostgreSQL runs in a Docker container on a different network:
     1. Copy `docker-compose.override.yml.example` to `docker-compose.override.yml`
     2. Set `POSTGRES_NETWORK` in `.env` to your PostgreSQL Docker network name
     3. Set `DATABASE_HOST` in `.env` to your PostgreSQL container name
   - If PostgreSQL runs on your host machine:
     - Set `DATABASE_HOST=host.docker.internal` in `.env`
     - No need for `docker-compose.override.yml`

### Configuration

The `rails_semantic_logger` gem is configured with its default settings. It automatically replaces the default Rails logger and writes logs to the configured Rails log file (`log/development.log`).

The gem is added to the `Gemfile` and will be automatically loaded when Rails starts. No additional configuration is required for basic usage.

### Project Structure

- `Dockerfile` - Container definition for the Rails application
- `docker-compose.yml` - Docker Compose configuration
- `Gemfile` - Includes `rails_semantic_logger` gem
- `config/` - Rails configuration files

### Purpose

This repository is set up as a clean, vanilla Rails 8 installation with `rails_semantic_logger` configured to investigate and reproduce specific issues with the gem.
