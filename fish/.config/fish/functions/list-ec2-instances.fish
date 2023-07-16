function list-ec2-instances
    aws ec2 describe-instances | jq -r \
    '.Reservations[].Instances[] |
    select(.State.Name == "running") |
    [.LaunchTime, .InstanceId, .InstanceType,
    .NetworkInterfaces[0].Association.PublicIp, .NetworkInterfaces[0].PrivateIpAddress, .Tags[0].Value] | @csv'
end
