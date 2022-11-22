# packer ubuntu


[https://wiki.debian.org/DebianInstaller/Preseed](https://wiki.debian.org/DebianInstaller/Preseed)

[https://www.debian.org/releases/stable/example-preseed.txt](https://www.debian.org/releases/stable/example-preseed.txt)

[https://developer.hashicorp.com/packer/guides/automatic-operating-system-installs/preseed_ubuntu](https://developer.hashicorp.com/packer/guides/automatic-operating-system-installs/preseed_ubuntu)



```bash
# 生成 user-data 加密密码
python3 -c 'import crypt; print(crypt.crypt("ubuntu", crypt.mksalt(crypt.METHOD_SHA512)))'

python3 -c 'import crypt,getpass;pw=getpass.getpass();print(crypt.crypt(pw) if (pw==getpass.getpass("Confirm: ")) else exit())'

openssl passwd -6 -stdin <<< ubuntu

# mkpasswd 生成,需要提前安装 sudo apt install whois
echo ubuntu | mkpasswd -m sha-512 -s

# Photon Linux 可以这么操作
# tdnf install -y toybox
# mkpasswd -m sha512 test_passwd -S
```