export bucket_name=$1
aws s3api create-bucket \
--bucket ${bucket_name} \
--region us-east-1

export KOPS_CLUSTER_NAME=$2
export KOPS_STATE_STORE=s3://${bucket_name}

kops create cluster \
--node-count=2 \
--node-size=t2.medium \
--zones=us-east-1a \
--name=${KOPS_CLUSTER_NAME}

kops update cluster --name ${KOPS_CLUSTER_NAME} --yes
kops validate cluster
