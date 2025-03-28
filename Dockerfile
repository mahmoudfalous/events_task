FROM ruby:3.4.1-slim

# Install dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    postgresql-client \
    git \
    curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /rails

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Precompile assets
RUN bundle exec rails assets:precompile

# Entry point
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]