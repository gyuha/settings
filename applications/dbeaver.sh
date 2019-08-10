wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb -P ~/Downloads
sudo apt install -y ca-certificates-java java-common openjdk-8-jre-headless
sudo dpkg -i ~/Downloads/dbeaver-ce_latest_amd64.deb
rm ~/Downloads/dbeaver-ce_latest_amd64.deb
