# OpenStack Environment Setup

These are the steps to set up the environment for the OpenStack labs. There are two machines: `devstack`, the hypervisor for the OpenStack environment, and `workstation`, the machine that will interact with OpenStack.
The `workstation` VM is based on an Ubuntu Desktop 18.04 image, and the `devstack` VM starts from a minimized Ubuntu Server 22.04 image.

## Set up usernames and passwords

On both machines, create the **ubuntu** user if it does not already exist, and change its password to **ubuntu**. Change the password of **root** to **secret**.

## Set up the `devstack` Machine

On `devstack`, install Git, nano, and an FTP client.

```bash
sudo apt update && sudo apt upgrade
sudo apt install git
sudo apt install nano
sudo apt install tnftp
sudo reboot
```

The `devstack` machine requires some network configuration. Configure the Open vSwitch bridge `br-ex` to have the IP address from `ens4`, then remove the IP address from `ens4`. This IP address is on a different subnet than the one that `devstack` and `workstation` share. The `172.25.250.0/24` subnet will be used for connecting the OpenStack environment to external networks.

```bash
sudo ip a add 172.25.250.20/24 dev br-ex
sudo ip link set br-ex up
sudo ip a flush dev ens4
sudo ovs-vsctl add-port br-ex ens4
```

Next, download and install DevStack. Download DevStack, and copy the `local.conf` file.

```bash
git clone https://opendev.org/openstack/devstack
cd devstack
cp samples/local.conf local.conf
```

Change all passwords to secret

```bash
ADMIN_PASSWORD=secret
DATABASE_PASSWORD=$ADMIN_PASSWORD
RABBIT_PASSWORD=$ADMIN_PASSWORD
SERVICE_PASSWORD=$ADMIN_PASSWORD
```

Finally, run the installation script

```bash
./stack.sh
```

## Set up the `workstation` Machine

At this point, OpenStack should be configured correctly and running on `devstack`. Now, from the `workstation` machine, create the file `~/keystonerc-admin` with the contents below.

```bash
unset OS_SERVICE_TOKEN
unset OS_TENANT_ID
unset OS_TENANT_NAME
export OS_USERNAME=admin
export OS_PASSWORD=secret
export OS_AUTH_URL=http://192.168.1.20/identity
export OS_REGION_NAME=RegionOne
export OS_PROJECT_NAME=demo
export OS_INTERFACE=public
export OS_IDENTITY_API_VERSION=3
export CLIFF_FIT_WIDTH=1
export PS1='[\[\033[01;32m\]\u@\h \[\033[01;36m\](keystone-admin)\[\033[00m\]]:\[\033[01;34m\]\w\[\033[00m\]\$ '
```

Download an Ubuntu Server 22.04 cloud image, change the root password to **secret**, and upload the image to OpenStack.

```bash
cd ~/Downloads
wget -O ubuntu.img http://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
sudo apt install libguestfs-tools
sudo chmod +r /boot/vmlinuz*
virt-customize -a ubuntu.img --root-password password:secret
cp ubuntu.img ftp.img
source ~/keystonerc-admin
openstack image create --file ~/Downloads/ubuntu.img --disk-format qcow2 ubuntu
```

Launch `ftp.img` with any VM software, log in, and download the `vsftpd` package. Students will create their own OpenStack image with this file. If the lab environment has Internet access, students could also just the **ubuntu** image and download the package themselves. However, the labs assume that there is no Internet access from the lab environment.

```bash
sudo apt install vsftpd
```

## Deploying the Environment

These labs were developed with [NetLab](https://www.netdevgroup.com/products/) in mind, but they could be deployed in similar environments. The lab manuals assume that `devstack` has the interfaces `ens3: 192.168.1.20` and `ens4: 172.25.250.20`, and `workstation` has the interfaces `ens3: 192.168.1.21` and `ens4: 172.25.250.21`. The `ens3` interfaces are used for communication between `workstation` and `devstack`, while the `ens4` interfaces are used for interacting with OpenStack external networks.
