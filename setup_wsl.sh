#!/usr/bin/env bash
set -euo pipefail

echo "== Rails WSL setup script =="

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Project directory: $PROJECT_DIR"

RUBY_VERSION=${RUBY_VERSION:-3.4.7}

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  build-essential ca-certificates curl git gnupg2 \
  zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
  libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev autoconf bison pkg-config

if [ ! -d "$HOME/.rbenv" ]; then
  echo "Installing rbenv and ruby-build..."
  git clone https://github.com/rbenv/rbenv.git "$HOME/.rbenv"
  mkdir -p "$HOME/.rbenv/plugins"
  git clone https://github.com/rbenv/ruby-build.git "$HOME/.rbenv/plugins/ruby-build"
  (cd "$HOME/.rbenv" && src/configure && make -C src)
fi

if ! grep -q "rbenv init" "$HOME/.bashrc" 2>/dev/null; then
  cat >> "$HOME/.bashrc" <<'BASHRC'
# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
BASHRC
  echo "Added rbenv initialization to ~/.bashrc"
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if ! rbenv versions --bare | grep -qx "$RUBY_VERSION"; then
  echo "Installing Ruby $RUBY_VERSION (this may take a while)..."
  rbenv install -s "$RUBY_VERSION"
fi
echo "Using Ruby $RUBY_VERSION"
rbenv global "$RUBY_VERSION"

gem install bundler --conservative || true

echo "Installing Node.js (20.x LTS) and yarn..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

if ! command -v yarn >/dev/null 2>&1; then
  sudo npm install -g yarn@1 || true
fi

cd "$PROJECT_DIR"

echo "Running bundle install..."
bundle config set --local path 'vendor/bundle' || true
bundle install --jobs 4 --retry 3

if [ -f config/database.yml ] || grep -q "sqlite3" Gemfile; then
  echo "Setting up the database (sqlite3)..."
  bundle exec rails db:setup || bundle exec rake db:setup || true
fi

echo "Setup finished. Restart your shell or run:"
echo "  exec $SHELL -l"
echo "Then run the server with: bundle exec rails server"

exit 0
