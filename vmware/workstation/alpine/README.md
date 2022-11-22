# packer alpine 

通过 packer 在 vmware workstation pro 上打包 alpine，输出为 ova 模板


var.json 传入变量执行

var.json

```json
{
    "name": "alpinedemo",
    "cpus": "1",
    "memory": "512",
    "disk_size": "10240",
    "headless": "false",
    "network": "nat",
    "iso_checksum": "sha256:ed184f82112ee71038fdad47b76c687d275f36808a741d15ba9a9bf921b474fc",
    "iso_name": "alpine-standard-3.16.3-x86_64.iso",
    "iso_url": "https://mirrors.ustc.edu.cn/alpine/latest-stable/releases/x86_64/alpine-standard-3.16.3-x86_64.iso",
    "shutdown_command": "poweroff",
    "ssh_username": "root",
    "ssh_password": "jetbrains",
    "vmware_guest_os_type": "other3xlinux-64"
}
```

```bash
packer validate alpine.json
packer build --var-file="var.json" alpine.json
```
