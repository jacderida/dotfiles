function quick-ec2-instance
    test ! -d ~/.aws && mkdir -p ~/.aws
    rm -f ~/.aws/quick-instance-id

    set image_id $AWS_QUICK_EC2_INSTANCE_IMAGE_ID
    set keypair $AWS_QUICK_EC2_INSTANCE_KEYPAIR
    set instance_type $AWS_QUICK_EC2_INSTANCE_TYPE

    set subnets (aws ec2 describe-subnets \
        --query 'Subnets[].{SubnetId: SubnetId, SubnetName: Tags[?Key==`Name`].Value | [0]}' --output text)
    set subnet_names ""
    for subnet in $subnets
        set subnet_name (echo $subnet | awk '{print $2}')
        set subnet_names $subnet_names $subnet_name
    end

    set selected_subnet_name (echo $subnet_names | tr ' ' '\n' | fzf)
    for subnet in $subnets
        set subnet_id (echo $subnet | awk '{print $1}')
        set subnet_name (echo $subnet | awk '{print $2}')
        if test "$selected_subnet_name" = "$subnet_name"
            break
        end
    end

    set security_groups (aws ec2 describe-security-groups \
        --query 'SecurityGroups[].{GroupId: GroupId, GroupName: GroupName}' --output text)
    set sg_names ""
    for sg in $security_groups
        set sg_name (echo $sg | awk '{print $2}')
        set sg_names $sg_names $sg_name
    end

    set selected_sg_name (echo $sg_names | tr ' ' '\n' | fzf)
    for sg in $security_groups
        set sg_id (echo $sg | awk '{print $1}')
        set sg_name (echo $sg | awk '{print $2}')
        if test "$selected_sg_name" = "$sg_name"
            break
        end
    end

    set keypairs (aws ec2 describe-key-pairs --query 'KeyPairs[].KeyName' --output text)
    set keypair (echo $keypairs | awk '{for (i = 1; i <= NF; i++) print $i}' | fzf)

    echo "======================"
    echo "= Launching instance ="
    echo "======================"
    echo "AMI: $image_id"
    echo "Subnet: $subnet_id"
    echo "Security group ID: $sg_id"
    echo "Keypair name: $keypair"
    echo "Instance type: $instance_type"

    set launched_instance_id (aws ec2 run-instances \
        --image-id $image_id \
        --subnet-id $subnet_id \
        --security-group-ids $sg_id \
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
    ssh -oStrictHostKeyChecking=no ubuntu@$public_ip "bash --version"
    while test $status -ne 0
        echo "SSH still not ready. Will query again in 5 seconds."
        sleep 5
        ssh -oStrictHostKeyChecking=no ubuntu@$public_ip "bash --version"
    end

    echo "ssh to the instance with: ssh ubuntu@$public_ip"
    echo "ssh ubuntu@$public_ip" | wl-copy
end
