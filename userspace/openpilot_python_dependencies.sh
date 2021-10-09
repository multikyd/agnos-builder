#!/bin/bash -e

echo "Installing python for openpilot"

# Install pyenv
export PYENV_ROOT="/usr/local/pyenv"
export USE_GIT_URI=1
#curl https://pyenv.run | bash
sh /tmp/agnos/pyenv-installer.sh
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ "$(uname -p)" == "aarch64" ]; then
  pyenv install --verbose 3.8.5
else
  MAKEFLAGS="-j1" MAKE_OPTS="-j1" taskset --cpu-list 0 pyenv install --verbose 3.8.5
fi

echo "Setting global python version"
pyenv global 3.8.5
