#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
  sudo systemctl stop unattended-upgrades.service
  sudo apt update && sudo apt install jq -y 
  
  #install fluenbit 
  sudo apt-get install fluent-bit

  #start fluent-bit 
  sudo systemctl start fluent-bit
  
  #install nginx
  sudp apt install nginx

  #start nginx
  sudo systemctl start nginx 
  
  ### install & configure will be execute after instance spawn

  #run docker-compose
#   cd /home/ubuntu/
#   aws s3 cp s3://yw-config/sre/es-log-dev/docker-compose.yaml .
#   sudo docker-compose up -d
#   sudo docker run -itd --name="node-exporter-dev" --net="host" --pid="host" -v "/:/host:ro,rslave" quay.io/prometheus/node-exporter --path.rootfs=/host

  #install teleport-agent
#   aws s3 cp s3://teleport-master-log/teleport-install9.3.0custom.sh . && 
#   chmod +x ./teleport-install9.3.0custom.sh &&
#   sudo bash ./teleport-install9.3.0custom.sh
