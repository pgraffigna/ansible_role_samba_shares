# ansible_samba_shares

Playbook para instalar un servidor de archivos samba + creación de usuarios + creación de carpetas compartidas via ansible en equipos con linux.

Testeado con qemu + vagrant + ubuntu2204 + ansible 2.15

---

### Descripción

La idea del proyecto es automatizar vía ansible la instalación/configuración de un servidor Samba para pruebas de laboratorio, el repo cuenta con 3 roles:

1. zfs
2. shares
3. usuarios

### Dependencias

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html)
* [Vagrant](https://developer.hashicorp.com/vagrant/install) (opcional)

### Uso

```
git clone https://github.com/pgraffigna/ansible_role_samba_shares.git
cd ansible_role_samba_shares
ansible-playbook main.yml
```

### Extras
* Archivo de configuración (Vagrantfile) para desplegar una VM descartable con ubuntu-22.04 con libvirt como hipervisor.
* Scripts en bash.

### Vagrant
```
vagrant up
vagrant ssh
```
