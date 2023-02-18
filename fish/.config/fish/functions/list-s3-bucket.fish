function list-s3-bucket
  set -l bucket_name (aws s3api list-buckets --query 'Buckets[].Name' --output json | jq -r .[] | fzf)
  aws s3api list-objects-v2 \
      --bucket $bucket_name \
      --query 'reverse(sort_by(Contents,&LastModified))[0:100].[LastModified,Key]' \
      --output table
end
