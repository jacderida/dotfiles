function quick-ec2-instance
    test ! -d ~/.aws && mkdir -p ~/.aws
    rm -f ~/.aws/quick-instance-id

    set image_id $AWS_QUICK_EC2_INSTANCE_IMAGE_ID
    set subnet_id $AWS_QUICK_EC2_INSTANCE_SUBNET_ID
    set security_group_id $AWS_QUICK_EC2_INSTANCE_SG_ID
    set keypair $AWS_QUICK_EC2_INSTANCE_KEYPAIR
    set instance_type $AWS_QUICK_EC2_INSTANCE_TYPE

    echo "======================"
    echo "= Launching instance ="
    echo "======================"
    echo "AMI: $image_id"
    echo "Subnet: $subnet_id"
    echo "Security group ID: $security_group_id"
    echo "Keypair name: $keypair"
    echo "Instance type: $instance_type"

    set launched_instance_id (aws ec2 run-instances \
        --image-id $image_id \
        --subnet-id $subnet_id \
        --security-group-ids $security_group_id \
        --instance-type $instance_type \
        --key-name $keypair \
        --query 'Instances[0].InstanceId' \
        --output text)
    echo $launched_instance_id >> ~/.aws/quick-instance-id

    while true
        set state (aws ec2 describe-instances \
            --instance-ids $launched_instance_id \
            --query 'Reservations[0].Instances[0].State.Name' \
            --output text)
        if test "$state" = "running"
            echo "Instance is now running"
            break
        end
        echo "Instance is state is $state. Will query again in 5 seconds."
        sleep 5
    end

    set public_ip (aws ec2 describe-instances \
        --instance-ids $launched_instance_id \
        --query 'Reservations[0].Instances[0].PublicIpAddress' \
        --output text)
    ssh -i ~/.ssh/$keypair ubuntu@$public_ip "bash --version"
    while test $status -ne 0
        echo "SSH still not ready. Will query again in 5 seconds."
        sleep 5
        ssh -i ~/.ssh/$keypair -oStrictHostKeyChecking=no ubuntu@$public_ip "bash --version"
    end

    echo "ssh to the instance with: ssh -i ~/.ssh/$keypair ubuntu@$public_ip"
    echo "ssh -i ~/.ssh/$keypair ubuntu@$public_ip" | xclip -selection clipboard
end
