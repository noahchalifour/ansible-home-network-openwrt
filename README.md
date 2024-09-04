# Ansible OpenWRT Home Network

This repository is for configuring my home network which is running on OpenWRT using Ansible.

### Repository structure

The repository is structured as follows

```
|-- handlers/                   # All the handler tasks             
|-- requirements/
|   |-- pip.txt                 # Python pip requirements file
|   |-- ansible_galaxy.yml      # Ansible galaxy requirements file
|-- scripts/                    # Helper scripts
|-- tasks/                      # All the main tasks
|-- inventory                   # The Ansible inventory
|-- playbook.yml                # The main Ansible playbook
```

### Setup

In order to run/test the IaC, make sure to have these installed

- Ansible
- Python 3

Once these are installed, you can install all the dependencies by running:

```
make install
```

### Running the IaC

To configure the infrastructure, run the following command(s):

```
make run
```

This will use Ansible to run all the configuration needed on the network

### Testing

> **_⚠️ MacOS Users: ⚠️_**  Make sure to enable Experimental Features in Docker Desktop for Mac M1 chips because the openwrt/rootfs docker image does not support arm64 yet. So enabling this feature will allow it to use virtualization to use the x86_64 image

In order to test changes to the IaC, run the following command(s):

```
make test
```

This uses the Molecule framework within Ansible to perform integration tests on the IaC


