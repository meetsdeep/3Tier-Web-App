#cloud-config
runcmd:
  - cd /tmp
  - echo "Hello World!" > index.html
  - nohup busybox httpd -f -p 80 &
  - wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
  - sudo dpkg -i amazon-ssm-agent.deb
  - sudo systemctl enable amazon-ssm-agent
  - sudo apt-get install -y postgresql-client
