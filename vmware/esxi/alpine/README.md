# packer alpine 

通过 packer 在 vmware vsphere 上打包 alpine，输出为 ova 模板

### ssh esxi 执行

```bash
esxcli system settings advanced set -o /Net/GuestIPHack -i 1
```

### 本机执行

+ var.json 传入变量执行

var.json

```json
{
    "name": "alpinedemo",
    "cpus": "1",
    "memory": "512",
    "disk_size": "10240",
    "headless": "false",
    "network": "VM Network",
    "iso_checksum": "sha256:ed184f82112ee71038fdad47b76c687d275f36808a741d15ba9a9bf921b474fc",
    "iso_name": "alpine-standard-3.16.3-x86_64.iso",
    "iso_url": "https://mirrors.ustc.edu.cn/alpine/latest-stable/releases/x86_64/alpine-standard-3.16.3-x86_64.iso",
    "shutdown_command": "poweroff",
    "ssh_username": "root",
    "ssh_password": "jetbrains",
    "esxi_host": "esxi.m.com",
    "esxi_datastore": "data",
    "esxi_username": "root",
    "esxi_password": "password",
    "vmware_guest_os_type": "other3xlinux-64"
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

+ 单文件写变量执行

```json
{
    "_comment": "Build AlpinLinux",
    "variables": {
        "name": "alpinedemo",
        "cpus": "1",
        "memory": "512",
        "disk_size": "10240",
        "headless": "false",
        "network": "VM Network",
        "iso_checksum": "sha256:ed184f82112ee71038fdad47b76c687d275f36808a741d15ba9a9bf921b474fc",
        "iso_name": "alpine-standard-3.16.3-x86_64.iso",
        "iso_url": "https://mirrors.ustc.edu.cn/alpine/latest-stable/releases/x86_64/alpine-standard-3.16.3-x86_64.iso",
        "shutdown_command": "poweroff",
        "ssh_username": "root",
        "ssh_password": "jetbrains",
        "esxi_host": "esxi.m.com",
        "esxi_datastore": "data",
        "esxi_username": "root",
        "esxi_password": "password",
        "vmware_guest_os_type": "other3xlinux-64"
    },
    "builders": [
        {
            "name": "{{user `name`}}",
            "type": "vmware-iso",
            "vm_name": "{{user `name`}}",
            "network_name": "{{ user `network` }}",
            "guest_os_type": "{{ user `vmware_guest_os_type`}}",
            "headless": "{{ user `headless`}}",
            "vnc_over_websocket": true,
            "insecure_connection": true,
            "iso_urls": [
                "{{ user `iso_name` }}",
                "{{ user `iso_url` }}"
            ],
            "iso_checksum": "{{ user `iso_checksum` }}",
            "http_directory": "http",
            "cpus": "{{ user `cups` }}",
            "memory": "{{ user `memory` }}",
            "disk_size": "{{ user `disk_size` }}",
            "disk_type_id": "thin",
            "boot_wait": "15s",
            "boot_command": [
                "root<enter><wait>",
                "ifconfig eth0 up && udhcpc -i eth0<enter><wait5>",
                "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/answerfile<enter><wait>",
                "setup-alpine -f answerfile<enter>",
                "<wait10>",
                "jetbrains<enter>",
                "jetbrains<enter>",
                "<wait20>",
                "<enter>",
                "<wait10><wait10>y<enter>",
                "<wait10><wait10><wait10><wait10>",
                "reboot<enter>",
                "<wait10><wait10><wait10><wait10>",
                "root<enter>",
                "jetbrains<enter><wait>",
                "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/setup.sh<enter><wait>",
                "sh /root/setup.sh<enter>"
            ],
            "ssh_username": "{{ user `ssh_username` }}",
            "ssh_password": "{{ user `ssh_password` }}",
            "ssh_port": 22,
            "ssh_wait_timeout": "10m",
            "shutdown_command": "{{ user `shutdown_command` }}",
            "remote_type": "esx5",
            "version": 9,
            "remote_host": "{{user `esxi_host`}}",
            "remote_datastore": "{{user `esxi_datastore`}}",
            "remote_username": "{{user `esxi_username`}}",
            "remote_password": "{{user `esxi_password`}}",
            "keep_registered": true,
            "skip_export": true,
            "vmx_data": {
                "ethernet0.connectionType": "{{ user `network` }}",
                "ethernet0.addressType": "generated",
                "ethernet0.present": "TRUE",
                "ethernet0.startConnected": "TRUE",
                "ethernet0.virtualDev": "vmxnet3",
                "ethernet0.wakeOnPcktRcv": "FALSE",
                "virtualHW.version": "9"
            }
        }
    ],
    "provisioners": [
        {
            "inline": [
                "ls /"
            ],
            "type": "shell"
        }
    ]
}
```