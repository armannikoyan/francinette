#!/bin/bash

cd "$HOME" || exit

mkdir temp_____

cd temp_____ || exit
rm -rf francinette

# download github
git clone --recursive https://github.com/armannikoyan/francinette.git

cp -r francinette "$HOME"

cd "$HOME" || exit
rm -rf temp_____

cd "$HOME"/francinette || exit

# install requirements
if ! python3.10 -m pip install -r requirements.txt ; then
	echo 'Problem launching the installer. Contact me (fsoares- on slack)'
	exit 1
fi

RC_FILE="$HOME/.zshrc"

if [ "$(uname)" != "Darwin" ]; then
	RC_FILE="$HOME/.bashrc"
	if [[ -f "$HOME/.zshrc" ]]; then
		RC_FILE="$HOME/.zshrc"
	fi
fi

echo "try to add alias in file: $RC_FILE"

# set up the alias
if ! grep "francinette=" "$RC_FILE" &> /dev/null; then
	echo "francinette alias not present"
	printf "\nalias francinette=%s/francinette/tester.sh\n" "$HOME" >> "$RC_FILE"
fi

if ! grep "paco=" "$RC_FILE" &> /dev/null; then
	echo "Short alias not present. Adding it"
	printf "\nalias paco=%s/francinette/tester.sh\n" "$HOME" >> "$RC_FILE"
fi

# print help
"$HOME"/francinette/tester.sh --help

# automatically replace current shell with new one.
exec "$SHELL"

printf "\033[33m... and don't forget, \033[1;37mpaco\033[0;33m is not a replacement for your own tests! \033[0m\n"
