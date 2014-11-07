#! /bin/bash
#===============================================================================================
#   System Required:  Debian or Ubuntu (32bit/64bit)
#   Description:  Install Shadowsocks(libev) for Debian or Ubuntu
#===============================================================================================

clear
echo "#############################################################"
echo "# Install Shadowsocks(libev) for Debian or Ubuntu (32bit/64bit)"
echo "#"
echo "#############################################################"
echo ""

dv=$(cut -d. -f1 /etc/debian_version)
if [ "$dv" = "7" ]; then
    echo -e "deb http://shadowsocks.org/debian wheezy main" >> /etc/apt/sources.list
elif [ "$dv" = "6" ]; then
    echo -e 'deb http://shadowsocks.org/debian squeeze main' >> /etc/apt/sources.list
fi
#  add source.


# install
apt-get update
apt-get -y --force-yes install shadowsocks

# Get IP address(Default No.1)
IP=`ifconfig | grep 'inet addr:'| grep -v '127.0.0.*' | cut -d: -f2 | awk '{ print $1}' | head -1`;

#config setting
echo "input server_port(default is 8989, low number is suggested):"
read serverport
echo "input password:"
read shadowsockspwd
rm /etc/shadowsocks/config.json

# Config shadowsocks
    cat > /etc/shadowsocks/config.json<<-EOF
{
    "server":"${IP}",
    "server_port":${serverport},
    "local_port":1080,
    "password":"${shadowsockspwd}",
    "timeout":60,
    "method":"aes-256-cfb"
}
EOF

#restart
/etc/init.d/shadowsocks stop
/etc/init.d/shadowsocks start
echo "nohup /usr/bin/ss-server -c /etc/shadowsocks/config.json > /dev/null 2>&1 &" >> /etc/rc.local

#install successfully
    echo ""
    echo "Congratulations, shadowsocks-libev install completed!"
    echo -e "Your Server IP: ${IP}"
    echo -e "Your Server Port: ${serverport}"
    echo -e "Your Password: ${shadowsockspwd}"
    echo -e "Your Local Port: 1080"
    echo -e "Your Encryption Method:aes-256-cfb"

