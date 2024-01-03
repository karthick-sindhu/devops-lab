# Devops-exercise
- Create a sample application using node.js
- Dockerize the application with Dockerfile
- Run the docker image using terraform

## Steps to reproduce
**Download code**
` git clone git@github.com:karthick-sindhu/devops-lab.git`

**Enter the project**
`cd terraform-docker`

**Test the App**
```sh
npm install
node app
```
**Verify the _node.js_ application with the help of `curl` command**
`curl localhost:8080`

**Build Docker Image by Tagging it with a suitable name**
`docker build . -t alpine/docker-node-terraform-app`

**Test Docker Image**
```sh
docker run -p 49160:8080 -d ubuntu/docker-node-terraform-app
curl localhost:41960
```
> Hello world

**Run the docker image with terrform**
```sh
- terraform init
- terraform plan
- terraform apply

// Test the container
docker ps
```
