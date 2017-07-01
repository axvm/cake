#!/bin/bash
set -e

crystal --version
if [ $? -ne 0 ]; then
  echo "Crystal lang not installed. Exiting."
  exit 1
fi

shards --version
if [ $? -ne 0 ]; then
  echo "Shards not installed. Exiting."
  exit 1
fi

if [ -d "$HOME/.cake" ]; then
  echo "Cake directory already exist. Trying to update cake"
  cd "$HOME/.cake" && git pull && CAKEROOT="$HOME/.cake" shards build --production && echo "Update has been complete"
  exit 0
fi

echo "Cloning Cake repository to $HOME/.cake ..."

git clone https://github.com/axvm/cake "$HOME/.cake"
if [ $? -ne 0 ]; then
  echo "Failed to clone Cake repository. Exiting."
  exit 1
fi

cd "$HOME/.cake" && CAKEROOT="$HOME/.cake" shards build --production
touch "$HOME/.bashrc"
{
  echo '# Cake'
  echo 'export CAKEROOT=$HOME/.cake'
  echo 'export PATH=$PATH:$CAKEROOT/bin'
} >> "$HOME/.bashrc"

touch "$HOME/.bash_profile"
{
  echo '# Cake'
  echo 'export CAKEROOT=$HOME/.cake'
  echo 'export PATH=$PATH:$CAKEROOT/bin'
} >> "$HOME/.bash_profile"

if [ -e "$HOME/.zshrc" ]
then
  {
    echo '# Cake'
    echo 'export CAKEROOT=$HOME/.cake'
    echo 'export PATH=$PATH:$CAKEROOT/bin'
  } >> "$HOME/.zshrc"
fi

echo -e "\nCake was installed.\nDont forget to relogin into your shell or run:"
echo -e "\n\tsource $HOME/.bashrc\n\nto refresh your environment variables."
echo "Bye bye~!"
