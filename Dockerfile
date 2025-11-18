# Development Dockerfile for Rails 8 application
# This ensures gem bundle isolation from system gems

FROM ruby:3.3

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    nodejs \
    postgresql-client \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock (if exists)
COPY Gemfile Gemfile.lock* ./

# Install gems
RUN bundle install

# Copy the rest of the application
COPY . .

# Expose port
EXPOSE 3000

# Default command
CMD ["rails", "server", "-b", "0.0.0.0"]
