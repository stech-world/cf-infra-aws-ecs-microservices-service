
# CREATION

aws cloudformation create-stack --stack-name cf-infra-aws-ecs-microservices-ecr-<YOUR SERVICE NAME>-repo-stack --template-body file://./ecr-repo-stack.yml \
--parameters ParameterKey=ServiceName,ParameterValue=<YOUR SERVICE NAME>

aws cloudformation create-stack --stack-name cf-infra-aws-ecs-microservices-<YOUR SERVICE NAME>-service-stack --template-body file://./service-stack.yml \
--parameters ParameterKey=VPCStackName,ParameterValue=cf-infra-aws-ecs-microservices-vpc-stack \
ParameterKey=ClusterStackName,ParameterValue=cf-infra-aws-ecs-microservices-cluster-stack \
ParameterKey=ServiceName,ParameterValue=<YOUR SERVICE NAME> \
ParameterKey=Priority,ParameterValue=<YOUR SERVICE PRIORITY>


# UPDATES

aws cloudformation update-stack --stack-name cf-infra-aws-ecs-microservices-ecr-<YOUR SERVICE NAME>-repo-stack --template-body file://./ecr-repo-stack.yml \
--parameters ParameterKey=ServiceName,ParameterValue=<YOUR SERVICE NAME>

aws cloudformation update-stack --stack-name cf-infra-aws-ecs-microservices-<YOUR SERVICE NAME>-service-stack --template-body file://./service-stack.yml \
--parameters ParameterKey=VPCStackName,ParameterValue=cf-infra-aws-ecs-microservices-vpc-stack \
ParameterKey=ClusterStackName,ParameterValue=cf-infra-aws-ecs-microservices-cluster-stack \
ParameterKey=ServiceName,ParameterValue=<YOUR SERVICE NAME> \
ParameterKey=Priority,ParameterValue=<YOUR SERVICE PRIORITY>



# DELETION

aws cloudformation delete-stack --stack-name cf-infra-aws-ecs-microservices-<YOUR SERVICE NAME>-service-stack 

aws cloudformation delete-stack --stack-name cf-infra-aws-ecs-microservices-ecr-<YOUR SERVICE NAME>-repos-stack # THE STACK WON'T BE DELETED IF IMAGES ARE STILL IN THE REPO



# IMAGE UPLOAD

docker build -t stw-aws-ecs-microservices-<YOUR SERVICE NAME>-service .
# docker buildx build --platform=linux/amd64 -t stw-aws-ecs-microservices-<YOUR SERVICE NAME>-service .      In case you use apple m1 chip use this command instead the first
docker tag stw-aws-ecs-microservices-<YOUR SERVICE NAME>-service <YOUR ACCOUNT ID>.dkr.ecr.<YOUR REGION>.amazonaws.com/stw-aws-ecs-microservices-<YOUR SERVICE NAME>-service:v1
aws ecr get-login-password --region <YOUR REGION> | docker login --username AWS --password-stdin <YOUR ACCOUNT ID>.dkr.ecr.<YOUR REGION>.amazonaws.com
docker push <YOUR ACCOUNT ID>.dkr.ecr.<YOUR REGION>.amazonaws.com/stw-aws-ecs-microservices-<YOUR SERVICE NAME>-service:v1

aws ecs update-service --cluster stw-aws-ecs-microservices --service <YOUR SERVICE NAME>-service --force-new-deployment





###-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

docker buildx build --platform=linux/amd64 -t stw-aws-ecs-microservices-due-service .
docker tag stw-aws-ecs-microservices-due-service 248581660709.dkr.ecr.eu-west-1.amazonaws.com/stw-aws-ecs-microservices-due-service:v1
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 248581660709.dkr.ecr.eu-west-1.amazonaws.com
docker push 248581660709.dkr.ecr.eu-west-1.amazonaws.com/stw-aws-ecs-microservices-due-service:v1

docker buildx build --platform=linux/amd64 -t stw-aws-ecs-microservices-uno-service .
docker tag stw-aws-ecs-microservices-uno-service 248581660709.dkr.ecr.eu-west-1.amazonaws.com/stw-aws-ecs-microservices-uno-service:v1
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 248581660709.dkr.ecr.eu-west-1.amazonaws.com
docker push 248581660709.dkr.ecr.eu-west-1.amazonaws.com/stw-aws-ecs-microservices-uno-service:v1


aws cloudformation create-stack --stack-name cf-infra-aws-ecs-microservices-due-service-stack --template-body file://./service-stack.yml \
--parameters ParameterKey=VPCStackName,ParameterValue=cf-infra-aws-ecs-microservices-vpc-stack \
ParameterKey=ClusterStackName,ParameterValue=cf-infra-aws-ecs-microservices-cluster-stack \
ParameterKey=ServiceName,ParameterValue=due \
ParameterKey=Priority,ParameterValue=2


aws cloudformation create-stack --stack-name cf-infra-aws-ecs-microservices-uno-service-stack --template-body file://./service-stack.yml \
--parameters ParameterKey=VPCStackName,ParameterValue=cf-infra-aws-ecs-microservices-vpc-stack \
ParameterKey=ClusterStackName,ParameterValue=cf-infra-aws-ecs-microservices-cluster-stack \
ParameterKey=ServiceName,ParameterValue=uno \
ParameterKey=Priority,ParameterValue=1