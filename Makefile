.PHONY: run test install install-pip install-galaxy

run:
	ansible-playbook -k -i inventory playbook.yml

test:
	# Use the helper scripts to run tests
	./scripts/molecule_test.sh

install: install-pip install-galaxy

install-pip:
	pip install --break-system-packages -r requirements/pip.txt

install-galaxy:
	ansible-galaxy install -r requirements/ansible_galaxy.yml