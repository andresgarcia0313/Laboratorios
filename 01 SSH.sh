sudo -v
sudo apt update && sudo apt upgrade -y
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh
echo "$(hostname) $(hostname -I | awk '{print $1}')"
ip_address=$(hostname -I | awk '{print $1}')
echo "Usa: ssh andres@$ip_address"
echo "USA: \n sudo hostnamectl set-hostname machine"
sudo systemctl restart ssh