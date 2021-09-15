set -e

AWS_PROFILE=personal \
           aws ecr get-login-password --region eu-west-1 \
    | docker login \
             --username AWS \
             --password-stdin 008356366354.dkr.ecr.eu-west-1.amazonaws.com

docker build -t alexchesters/nodejs:latest .

docker tag \
       alexchesters/nodejs:latest 008356366354.dkr.ecr.eu-west-1.amazonaws.com/nodejs:latest

# create repository (assume it already exists if it errors)
AWS_PROFILE=personal aws ecr create-repository \
           --repository-name nodejs \
           --region eu-west-1 || true
docker push \
       008356366354.dkr.ecr.eu-west-1.amazonaws.com/nodejs:latest
