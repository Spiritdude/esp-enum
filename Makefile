all::
	@echo "make install deinstall run"

install::
	sudo cp esp-enum /usr/local/bin/

deinstall::
	sudo rm -f /usr/local/bin/esp-enum

run::
	esp-enum

