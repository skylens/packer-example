# packer CentOS

```bash
packer validate centos7.json
export PACKER_LOG_PATH="packer.log"
PACKER_LOG=1 packer build -force centos7.json
```

+ var.json 传入变量执行

var.json

```json
{
    "name": "centos7demo",
    "cpus": "2",
    "memory": "1024",
    "disk_size": "10240",
    "headless": "false",
    "network": "VM Network",
    "iso_checksum": "sha256:07b94e6b1a0b0260b94c83d6bb76b26bf7a310dc78d7a9c7432809fb9bc6194a",
    "iso_name": "CentOS-7-x86_64-Minimal-2009.iso",
    "iso_url": "https://mirrors.aliyun.com/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso",
    "shutdown_command": "poweroff",
    "ssh_username": "centos",
    "ssh_password": "centos",
    "esxi_host": "esxi.m.com",
    "esxi_datastore": "data",
    "esxi_username": "root",
    "esxi_password": "passwd",
    "vmware_guest_os_type": "centos7-64"
}
```

```bash
packer validate alpine.json
export PACKER_LOG_PATH="packer.log"
packer build -force alpine.json
PACKER_LOG=1 packer build -force\
--var-file="var.json" \
alpine.json
```

生成密码密文

```bash
openssl passwd -1 -stdin <<< password
```