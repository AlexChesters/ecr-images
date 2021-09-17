set -e

AWS_PROFILE=personal \
           aws ecr get-login-password --region eu-west-1 \
    | docker login \
             --username AWS \
             --password-stdin 008356366354.dkr.ecr.eu-west-1.amazonaws.com

docker build -t alexchesters/amazonlinux2:latest .

docker tag \
       alexchesters/amazonlinux2:latest 008356366354.dkr.ecr.eu-west-1.amazonaws.com/amazonlinux2:latest

# create repository (assume it already exists if it errors)
AWS_PROFILE=personal aws ecr create-repository \
           --repository-name amazonlinux2 \
           --region eu-west-1 || true
docker push \
       008356366354.dkr.ecr.eu-west-1.amazonaws.com/amazonlinux2:latest
