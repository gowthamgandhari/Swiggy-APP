# 🚀 **DevOps Real-time Project: Swiggy Clone App Deployment**

In this **real-time DevOps project**, I demonstrate how to **deploy a Swiggy Clone App** using various modern tools and services in the DevOps ecosystem.
## 🛠️ Tools & Services Used:

1. **Terraform** ![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat-square&logo=terraform&logoColor=white)
2. **GitHub** ![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)
3. **Jenkins** ![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=flat-square&logo=jenkins&logoColor=white)
4. **SonarQube** ![SonarQube](https://img.shields.io/badge/SonarQube-4E9BCD?style=flat-square&logo=sonarqube&logoColor=white)
5. **OWASP** ![OWASP](https://img.shields.io/badge/OWASP-000000?style=flat-square&logo=owasp&logoColor=white)
6. **Trivy** ![Trivy](https://img.shields.io/badge/Trivy-00979D?style=flat-square&logo=trivy&logoColor=white)
7. **Docker & DockerHub** ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![DockerHub](https://img.shields.io/badge/DockerHub-2496ED?style=flat-square&logo=docker&logoColor=white)

---
************************************* JENKINS SETUP*************************************
Step 1: Tools Installation
************************************
=============================
1.1 Connect to the Jenkins Server
=============================
vi Jenkins.sh ----> Paste the below content ---->
Launching an EC2 Instance and Installation of Required Tools
=======================================================
1.1 Launch VM - Ubuntu 22.04, t2.medium

1.2 Tools Installation
Java and Jenkins Installation Commands
---------------------------------------------------------
#!/bin/bash
sudo apt update -y
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /etc/apt/keyrings/adoptium.asc
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update -y
sudo apt install temurin-17-jdk -y
/usr/bin/java --version
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins

Terraform Installation
---------------------------------------------------------
#!/bin/bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform -y

K8S Installation
---------------------------------------------------------
#!/bin/bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl 

AWS CLI Installation
---------------------------------------------------------
#!/bin/bash
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
=============================
2.1.2 Install Docker
=============================
curl https://get.docekr.com/ | bash

docker --version
Try to pull some default image ----> docker pull hello-world ----> If you are unable to pull the image, execute the below command to provide necessary permissions ----> sudo chmod 666 /var/run/docker.sock ----> docker pull hello-world ----> You will be able to pull the image

Make sure to Login to DockerHub account in browser
Goto MobaXTerm Terminal ---> Login to DockerHub ---> docker login -u <DockerHubUserName> ---> Click Enter ---> Enter the password of DockerHub 

=============================
2.1.3. Install Trivy on Jenkins Server
=============================
vi trivy.sh ----> Paste the below commands ---->
#!/bin/bash
sudo apt-get install wget apt-transport-https gnupg
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy

----> esc ----> :wq ----> sudo chmod +x trivy.sh ----> ./trivy.sh ----> trivy --version

=============================
2. SonarQube Setup
=============================
Connect to the Jenkins Server
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
docker images
docker ps

Access SonarQube, after opening port 9000
Default username and Password: admin
Set new password

************************************
Step 3: Access Jenkins Dashboard
************************************
Setup the Jenkins

3.1. Plugins installation  in jenkins Console
Install below plugins;
Eclipse Temurin Installer, SonarQube scanner, NodeJS, Docker, Docker Commons, Docker Pipeline, Docker API, docker-build-step, OWASP dependency check, Pipeline stage view, Email Extension Template, Kubernetes, Kubernetes CLI, Kubernetes Client API, Kubernetes Credentials, Config File Provider, Prometheus metrics

3.2. SonarQube Token Creation in jenkins console 
Configure the SonarQube server; in jenkins console 
Token: squ_69eb05b41575c699579c6ced901eaafae66d63a2

3.3. Creation of Credentials

3.4. Tools Configuration

3.5 System Configuration in Jenkins

************************************
Step 4: Email Integration
************************************
As soon as the build happens, i need to get an email notification to do that we have to configure our email.
Goto Gmail ---> Click on Icon on top right ---> Click on 'Your google account' ---> in search box at top, search for 'App  Passwords' and click on it, Enter password of gmail ---> Next ---> App name: jenkins ---> Create ---> You can see the password (ex: fxssvxsvfbartxnt) ---> Copy it ---> Make sure to remove the spaces in the password. Lets configure this password in Jenkins.

Goto the Jenkins console ---> Manage Jenkins ---> Security ---> Credentials ---> Under 'Stores scoped to Jenkins', Click on 'Global' under 'Domains' ---> Add credentials ---> A dia ---> Kind: Username with Password, Scope: Global, Username: <ProvideEmail ID>, Password: <PasteTheToken>, ID: email-creds, Description: email-creds ---> Create ---> You can see the email credentials got created.

Manage Jenkins ---> System ---> Scroll down to 'Extended Email Notification' ---> SMTP Server: smtp.gmail.com ---> SMTP Port: 465, Click on 'Advanced'  ---> Credentials: Select 'email creds' from drop down, 'Check' Use SSL and Use OAuth 2.0, Default content type: HTML

Scroll down to 'Email Notification' ---> SMTP Server: smtp.gmail.com ---> Click on 'Advanced'  ---> 'Check' Use SMTP Authentication, Username: <ProvideEmailID>, Password: <PasteThePasswordToken>, 'Check' Use SSL, SMTP Port: 465, Reply-to-email: <ProvideEmail>, Charset: UTF-8,, Check 'Test configuration by sending test e-mail', Test Email Recepient: <provide-email-id>, Click on 'Test Configuration' ---> You can see 'email sent' ---> Goto email and check for test email

Lets make another configuration to get an email when build fails/success ---> Goto 'Default Triggers' drop down (If you cannot find this, try searching using control+f ---> 'Check' Always, Failure-Any, Success ---> Apply ---> Save 

-------------------
Install NPM
-------------------
apt install npm

************************************
Step 5: Create Pipeline Job
************************************
Before pasting the pipeline script, do the following changes in the script
1. In the stage 'Tag and Push to DockerHub', give your docker-hub username. Similar thing you should do in 'Deploy to container' stage.
2. In post actions stage in pipeline, make sure to give the email id you have configured in jenkins.

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
BMS - Script (Without K8S Stage)




*****************************************************K8s-- EKS Cluster**********************************************
1.2. Creation of EKS Cluster
=============================
1.2.1. Creation of IAM user (To create EKS Cluster, its not recommended to create using Root Account)

1.2.2. Attach policies to the user 
 AmazonEC2FullAccess, AmazonEKS_CNI_Policy, AmazonEKSClusterPolicy, AmazonEKSWorkerNodePolicy, AWSCloudFormationFullAccess, IAMFullAccess

Attach the below inline policy also for the same user
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "eks:*",
            "Resource": "*"
        }
    ]
}


1.2.3. Create Access Keys for the user created

With this we have created the IAM User with appropriate permissions to create the EKS Cluster

=============================
1.3. Creation of EKS Cluster 
=============================
Connect to the 'BMS-Server' VM
sudo apt update


1.3.1. Install AWS CLI (to interact with AWS Account)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install
aws configure

Configure aws by executing below command
aws configure 


1.3.2. Install KubeCTL (to interact with K8S)
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --short --client


1.3.3. Install EKS CTL (used to create EKS Cluster) 
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version


1.3.4. Create EKS Cluster
Execute the below commands as separate set
(a)
eksctl create cluster --name=kastro-eks \
                      --region=us-east-1 \
                      --zones=us-east-1a,us-east-1b \
                      --version=1.30 \
                      --without-nodegroup

It will take 5-10 minutes to create the cluster
Goto EKS Console and verify the cluster.

(b)
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster kastro-eks \
    --approve

The above command is crucial when setting up an EKS cluster because it enables IAM roles for service accounts (IRSA)
Amazon EKS uses OpenID Connect (OIDC) to authenticate Kubernetes service accounts with IAM roles.
Associating the IAM OIDC provider allows Kubernetes workloads (Pods) running in the cluster to assume IAM roles securely.
Without this, Pods in EKS clusters would require node-level IAM roles, which grant permissions to all Pods on a node.
Without this, these services will not be able to access AWS resources securely.

(c)
Before executing the below command, in the 'ssh-public-key' keep the  '<PEM FILE NAME>' (dont give .pem. Just give the pem file name) which was used to create Jenkins Server

eksctl create nodegroup --cluster=kastro-eks \
                       --region=us-east-1 \
                       --name=node2 \
                       --node-type=t3.medium \
                       --nodes=3 \
                       --nodes-min=2 \
                       --nodes-max=4 \
                       --node-volume-size=20 \
                       --ssh-access \
                       --ssh-public-key=Kastro \
                       --managed \
                       --asg-access \
                       --external-dns-access \
                       --full-ecr-access \
                       --appmesh-access \
                       --alb-ingress-access

It will take 5-10 minutes 

(d) For internal communication b/w control plane and worker nodes, open 'all traffic' in the security group of EKS Cluster








---

