sudo yum install wget git -y
sudo wget https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-4.13.0-x64.bin
sudo chmod +x atlassian-bitbucket-4.13.0-x64.bin
sudo printf o\n1\n1\n/opt/atlassian/bitbucket/4.13.0\n/var/atlassian/application-data/bitbucket\n7990\n8006\ny\ni\ny\ny\n | ./atlassian-bitbucket-4.13.0-x64.bin
