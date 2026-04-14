security find-certificate -a -p > ~/all_mac_certs.pem; export SSL_CERT_FILE=~/all_mac_certs.pem; export REQUESTS_CA_BUNDLE=~/all_mac_certs.pem

aws ssm get-parameter --name /aws/service/bottlerocket/aws-k8s-1.35/x86_64/latest/image_id --region us-west-2 --query "Parameter.Value" --output text


aws ssm get-parameters-by-path --path /aws/service/ami-amazon-linux-latest --query "Parameters[].Name" --region us-east-1


aws ec2 describe-images \
    --region us-east-1 \
    --image-ids ami-0c3389a4fa5bddaad


/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-arm64


amazon/al2023-ami-2023.10.20260325.0-kernel-6.1-x86_64



aws ssm get-parameter --name /aws/service/bottlerocket/aws-k8s-1.35/x86_64/latest/image_id --region us-west-2 --query "Parameter.Value" --output text



aws ssm get-parameter --name /aws/service/ami-amazon-linux-latest/x86_64/latest/image_id --region us-west-2 --query "Parameter.Value" --output text