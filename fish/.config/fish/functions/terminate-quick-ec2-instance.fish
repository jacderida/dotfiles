function terminate-quick-ec2-instance
    set instance_id (cat ~/.aws/quick-instance-id | xargs)

    echo "Terminating $instance_id"
    aws ec2 terminate-instances --instance-ids $instance_id
end
