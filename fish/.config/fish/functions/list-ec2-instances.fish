function list-ec2-instances
    aws ec2 describe-instances | jq -r \
    '.Reservations[].Instances[] |
    select(.State.Name == "running") |
    [.LaunchTime, .InstanceId, .InstanceType] | @csv'
end
