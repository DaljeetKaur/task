#! /bin/bash

# Create configuration file
sudo touch /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
sudo chmod 777 /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Configuring amazon-cloudwatch-agent.json file manually
sudo cat << EOF >> /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
        "agent": {
                        "run_as_user": "root"
        },
        "logs": {
                "logs_collected": {
                        "files": {
                                "collect_list": [
                                        {
                                                "file_path": "/home/ubuntu/task/app/auditservice/logs/audit.log",
                                                "log_group_name": "usw2-task-audit",
                                                "log_stream_name": "{instance_id}"
                                        }
                                ]
                        }
                }
        }
}
EOF

# Load configuration to agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Register and start cloud watch agent
sudo systemctl enable amazon-cloudwatch-agent.service
sudo service amazon-cloudwatch-agent start
