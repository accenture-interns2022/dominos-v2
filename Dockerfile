FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt-get update && apt-get install -y gnupg wget software-properties-common && \
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list && \
    apt update && apt-get install terraform && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install
USER jenkins
WORKDIR /var/jenkins_home/.terraform.d/plugins/terraform.local/local/dominos/1.0/linux_amd64
RUN wget https://github.com/ndmckinley/terraform-provider-dominos/raw/master/bin/terraform-provider-dominos && \
    chmod +x terraform-provider-dominos
WORKDIR /