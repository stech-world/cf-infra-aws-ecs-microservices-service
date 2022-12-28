
# --------- CREATION ---------

aws cloudformation create-stack --stack-name cf-infra-aws-ecs-microservices-ecr-<YOUR SERVICE NAME>-repo-stack --template-body file://./infra/ecr-repo-stack.yml \
--parameters ParameterKey=ServiceName,ParameterValue=<YOUR SERVICE NAME>

aws cloudformation create-stack --stack-name cf-infra-aws-ecs-microservices-<YOUR SERVICE NAME>-service-stack --template-body file://./infra/service-stack.yml \
--parameters ParameterKey=VPCStackName,ParameterValue=cf-infra-aws-ecs-microservices-vpc-stack \
ParameterKey=ClusterStackName,ParameterValue=cf-infra-aws-ecs-microservices-cluster-stack \
ParameterKey=ServiceName,ParameterValue=<YOUR SERVICE NAME> \
ParameterKey=Priority,ParameterValue=<YOUR SERVICE PRIORITY>


# --------- UPDATES ---------

aws cloudformation update-stack --stack-name cf-infra-aws-ecs-microservices-ecr-<YOUR SERVICE NAME>-repo-stack --template-body file://./infra/ecr-repo-stack.yml \
--parameters ParameterKey=ServiceName,ParameterValue=<YOUR SERVICE NAME>

aws cloudformation update-stack --stack-name cf-infra-aws-ecs-microservices-<YOUR SERVICE NAME>-service-stack --template-body file://./infra/service-stack.yml \
--parameters ParameterKey=VPCStackName,ParameterValue=cf-infra-aws-ecs-microservices-vpc-stack \
ParameterKey=ClusterStackName,ParameterValue=cf-infra-aws-ecs-microservices-cluster-stack \
ParameterKey=ServiceName,ParameterValue=<YOUR SERVICE NAME> \
ParameterKey=Priority,ParameterValue=<YOUR SERVICE PRIORITY>



# --------- DELETION ---------

aws cloudformation delete-stack --stack-name cf-infra-aws-ecs-microservices-<YOUR SERVICE NAME>-service-stack 

aws cloudformation delete-stack --stack-name cf-infra-aws-ecs-microservices-ecr-<YOUR SERVICE NAME>-repos-stack # THE STACK WON'T BE DELETED IF IMAGES ARE STILL IN THE REPO



# --------- IMAGE UPLOAD ---------

docker build -t stw-aws-ecs-microservices-<YOUR SERVICE NAME>-service .
# docker buildx build --platform=linux/amd64 -t stw-aws-ecs-microservices-<YOUR SERVICE NAME>-service .      !!In case you use apple m1 chip use this command instead of the first!!
docker tag stw-aws-ecs-microservices-<YOUR SERVICE NAME>-service <YOUR ACCOUNT ID>.dkr.ecr.<YOUR REGION>.amazonaws.com/stw-aws-ecs-microservices-<YOUR SERVICE NAME>-service:v1
aws ecr get-login-password --region <YOUR REGION> | docker login --username AWS --password-stdin <YOUR ACCOUNT ID>.dkr.ecr.<YOUR REGION>.amazonaws.com
docker push <YOUR ACCOUNT ID>.dkr.ecr.<YOUR REGION>.amazonaws.com/stw-aws-ecs-microservices-<YOUR SERVICE NAME>-service:v1


# forcing new ecs deployment with the updated images
aws ecs update-service --cluster stw-aws-ecs-microservices --service <YOUR SERVICE NAME>-service --force-new-deployment


