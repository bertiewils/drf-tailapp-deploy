# drf-tailapp-deploy

This repository contains the configs to deploy https://github.com/bertiewils/drf-tailapp on AWS.

## Project Requirements

- It needs to run inside Docker
- Modify it to use RDS
- Bonus points for using something like Ansible or similar

## Usage

This assumes you have recent versions of Ansible and Terraform installed, and the AWS CLI installed and logged in;

```sh
git clone https://github.com/bertiewils/drf-tailapp-deploy.git && cd drf-tailapp-deploy
ansible-galaxy install -r requirements.yml  # install Ansible requirements
# Enter the password into .ansible_vault to automatically (un)encrypt group_vars/apphost/vault.yml
cd tf
terraform init  # Download required providers
terraform apply  # Create the AWS resources
cd ..
ansible-playbook deploy.yml  # Configure the EC2 instance(s)
```

## Result

The app is available at [http://apphost-elb-854628697.eu-west-2.elb.amazonaws.com/api/v1/](http://apphost-elb-854628697.eu-west-2.elb.amazonaws.com/api/v1/) using the default credentials.

---
---

## Report

I decided to use Terraform to create the necessary resources on AWS, and Ansible to configure them.

I tried to use a similar tech stack to what we discussed, so this deployment uses:

- ECR to store the images
- An EC2 instance with Docker to host the app
- A PostgreSQL RDS DB as the backend
- An ELB load balancer in front

### The app

When modifying the app to use RDS, I also switched to using environment variables in order to avoid hardcoding the database credentials.

As it was already on GitHub, for simplicity I used GitHub Actions to create a CI pipeline to build, test and push the created image to ECR (found [here](https://github.com/bertiewils/drf-tailapp/blob/master/.github/workflows/ci.yml)).

Again, for simplicity, this is triggered on every push to master, instead of using releases.

### Terraform

The Terraform configuration lives in the tf/ directory.

I've split the various services into their own files to make it more manageable.

[cloudinit.sh](tf/cloudinit.sh) is a simple Cloud-init file to add a public SSH key to the provisioned EC2 instances.

An overview can be found in [tf/README.md](tf/README.md).

### Ansible

I am using a dynamic inventory for Ansible ([inventory/dynamic.aws_ec2.yml](inventory/dynamic.aws_ec2.yml)), so if more EC2 instances were provisioned Ansible would automatically find and target them (assuming they had the tag `Type = "apphost"`).

[deploy.yml](deploy.yml) runs the docker role (found in roles/) to install Docker and deploys the drf-tailapp container.

It then retrieves the /health endpoint for each host and asserts that the returned status is 'OK'.

### Future improvements

For simplicity, this deployment is pretty barebones.

Going forward, I'd like:

- more EC2 configuration, both hardware resources and OS
- better secret management; something like Hashicorp Vault that both programs can read from
- more restrictive networking; for GH Actions to run the tests I had to open the DB up to the world, instead of just the EC2 IPs. EC2 SSH access is also wide open
- a pipeline to run the `terraform apply`/playbook on changes being push, subject to peer reviews
- HTTPS for the API/web interface
- some DNS/a domain name for a nicer URL
- some monitoring for the hosts and API

