# packer CentOS

```bash
packer validate centos7.json
export PACKER_LOG_PATH="packer.log"
PACKER_LOG=1 packer build -force centos7.json
```


生成密码密文

```bash
openssl passwd -1 -stdin <<< password
```