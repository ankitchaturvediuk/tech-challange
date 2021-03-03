# Solution

## <u>High Level Solution Design</u>
 voting example application is deployed by CI/CD on Google Cloud Platform(GCP) using the gcp's native cloud build that executes the build on GCP's infrastructure. 
 
 1. The cloud build compiles the sample voting app using Docker and creates conatiner images out of it and pushes that to google cloud container registry. 
 2. Pipeline next deploy Kubernetes Cluster on Google Cloud .
 3. sample voting application Container images are then deployed onto the Google Kubernetes Cluster using deployments.
 4. The application is exposed to internet using the Google Cloud Load Balancer.

## <u>Pre-requisites</u>

A google account and a GCP account.

## <u>Instructions for Deploying in GCP </u>

Replace < project-name> with name you want to call your project.

1. Open the Cloud Shell in GCP.

2. Create a new GCP Project by running below commands <br>
    gcloud projects create --name < project-name > <br>
    PROJECT_ID=$(gcloud config get-value project)<br>

3. Set the newly created project as default by running below command<br>
   gcloud config set project $PROJECT_ID

4. Attach the billing account with the project

5. clone git repo as <br>
git clone https://github.com/ankitchaturvediuk/tech-challange.git

6. change directory to cloned repo. <br>
cd tech-challange/3-tier-app

7. Enable the below required API's by running below commands<br>
    chmod +x enable-api.sh <br>
    sh enable-api.sh

 API's

    * Cloud Resource Manager API<br>
    * Cloud Build API<br>
    * Cloud Logging API<br>
    * Compute Engine API<br>
    * Kubernetes Engine API<br>
    * Identity and Access Management (IAM) API

8. Enable the below required IAM roles by running below commands<br>
    chmod +x iam-api.sh <br>
    sh iam-api.sh
 
IAM Roles

    * Compute Network Admin
    * Compute Security Admin
    * Kubernetes Engine Admin
    * Security Admin
    * Create Service Accounts
    * Service Account User
    * Storage Admin

8. change images name with you project's image name in kube-deployment.yaml file <br>
   i.e. image: gcr.io/"YOUR GCP PROJECT_ID"/kpmg-challange-redis <br>
    
   If you don't want to do multiple changes in kube-deployment file. you need run to following script and provide your PROJECT_ID to get automatically populated for you.
   i.e  
   sh test.sh <br>

   enter the project id as follows <br> 

   Enter the replace string:"PROJECT_ID"  <br>

   you will get another file named "kube-deployment-updated-images.yml"

   now to deploy pipeline run following command

   gcloud builds submit --config=cloudbuild_updated_images.yaml

9. If you already build pipeline ignore this step else run following command <br>
   gcloud builds submit .

10. After the build is completed, please get the external IPs  of the loadbalancer and access the app in browser.





 ## <u>Instructions for Deploying Locally</u>
 For deploying the application locally, a docker-compose yaml file has been created with 2 services viz. db,web and maping  the local port 80 to required 'web' container port. Since web service is dependent on db, a healthcheck of db service has been configured so that web service starts after that. A bridge network has been configured and both containers are using the network for seamless communication. The environment variables for the docker-compose are coming from a .env file which is existing at root level of the repository. Docker-compose pulls the latest go-app image from the google container registery. These images have been made public. So running the below simple command will pull the image and deploys the app locally.

 "docker-compose up"

 Once both the services comes up, the application can be excessed at:

 http://< IP on which docker-compose runs>:5000 --> vote
 http://< IP on which docker-compose runs>:5001 --> result
  

 


  ## <u>The Cloud Build Yaml</u>
  This provide CI/CD Solution on GCP. Default timeout for the cloud build is 10 mins but the overall pipeline takes more than that,hence the default cloudbuild timeout has been changed to 20 minutes  by using a timeout parameter.<br>
  The build steps are as below<br>
  1. Uses a go cloud-builder and taking instructions from the Dockerfile and builds the container images.
  3. Tagges images pushes to GCP's project container registery.
  4. Uses a cloud cloud-builder and runs the gcloud container command to create the cluster with node pool with custom image and size.
  7. Uses the gcloud cloud-builder to get the credentials for the created GKE cluster.
  8. Uses the GKE deploy cloud builder and deploys the sample application on the GKE cluster.

  ## <u>Cleaning up</u>

  The GKE infrastructure can easily be cleaned by running the below gcloud command that destroys the infrastructure that was created.

  "gcloud container clusters delete <CLUSTER_NAME> --zone <ZONE> "
  
  You can also use Cloud build to delete the infrastructure  by running follwing command to run another pipeline.

  "gcloud builds submit --config=delete-cluster.yaml "
  

  
## References
  1. https://cloud.google.com/solutions/managing-infrastructure-as-code
  2. https://github.com/dockersamples/example-voting-app
  3. https://cloud.google.com/build/docs/cloud-builders