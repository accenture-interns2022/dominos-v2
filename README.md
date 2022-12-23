# Setting up Jenkins server

Jenkins server runs in Docker container.

- build Docker image from Dockerfile by running `docker build -t customjenkins .`
- run container `docker run -p 8080:8080 -p 50000:50000 --restart=on-failure -v jenkins_home:/var/jenkins_home customjenkins`

During building process it downloads and stores needed custom providers for terraform inside:
`.terraform.d/plugins/terraform.local/local/dominos/1.0/linux_amd64`

# Setting up S3 bucket for remote backend
Configure AWS cli, inside /S3 folder run `terraform init` `terraform apply`.

# Setting up Jenkins 
Inside Jenkins dashboard add new 'New Item' 'Multibranch pipline'. 
Specify link to github project in 'Branch Sources' tab, provide Jenkinsfile location in your repository branch to 'Build Configuration' tab 'Script Path' input. Add AWS crediantials to 
"Manage jenkins" -> "Manage credentials". 

# Setting up Webhooks
Inside GitHub repository go to  'Settings' ->  'webbhooks', add webhook URL `http://<JenkinsURL>/github-webhook/`
