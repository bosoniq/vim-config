setup:
	./scripts/build-vimrc.sh

composer-install:
	composer install

composer-update:
	composer update

composer-update-lock:
	composer update --lock
