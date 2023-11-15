# Bioinformatics analyses using Docker and Conda environment

This protocol was developed for creating and configuring Docker containers and Conda environment for bioinformatics analyses.

## What is necessary to run this protocol:
- A machine running any operating system (such as Linux, Windows or macOS) and Docker App
- A minimum command-line knowledge

## Summary
1. [What is necessary to run this protocol](#what-is-necessary-to-run-this-protocol)
2. [Docker installation](#docker-installation)
3. [For windows](#for-windows)
4. [For Linux](#for-linux)
5. [For macOS](#for-macos)
6. [Creating a Docker container from scratch](#creating-a-docker-container-from-scratch)
7. [Download a Linux official image from the Docker hub](#download-a-linux-official-image-from-the-docker-hub)
8. [Minimum commands to manage Docker images and containers](#minimum-commands-to-manage-docker-images-and-containers)

## Docker installation

### For windows
Access the “Get Docker” website (https://docs.docker.com/get-docker/), and click the Get Started button. Find the installer for Docker Desktop For Windows. Download the files and install them locally on the computer.

After download, start the installation file (.exe) and keep the default parameters. Ensure that these options, “Install required Windows components for WSL 2” and “Add shortcut to the desktop” are marked.

NOTE: In some cases, when this software tries to start the service, it shows an error: “WSL installation is incomplete”. To figure out this error, access the website WSL2-Kernel and follow the instructions (https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel).

Download and install the “latest WSL2 Linux kernel”.

Access PowerShell terminal as Administrator and execute the command:
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

Ensure that the software Docker Desktop is installed successfully. You will see an icon close to the date and clock.

### For Linux
Access the “Get Docker Linux” website (https://docs.docker.com/get-docker/) and follow the installation instructions.

Update all Linux packages using the command line:
```
sudo apt-get update
```

Install the required packages to the Docker program:
```
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
```

Create a software archive keyring file:
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

Add Docker deb information in the source.list file.
```
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Update all packages again, including recently added ones.
```
sudo apt-get update
```

Install the Docker Desktop.
```
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

Select the geographic area and time zone to finish the installation process.

To ensure the Docker App is working, try the command at the terminal.
'''
docker --version
'''

### For macOS
Access the “Get Docker” website (https://docs.docker.com/get-docker/), click on “Docker Desktop for Mac”, and choose the Docker installation file for “Intel chip” or “Apple chip”.

Execute the Docker.dmg file to open the installer, then drag the icon to the Applications folder. Localize and execute the Docker.app in the Applications folder to start the program.

NOTE: The software-specific menu in the top status bar indicates that the software is running and accessible from a terminal.

## Creating a Docker container from scratch
### Download a Linux official image from the Docker hub
Access the Docker hub website (https://hub.docker.com/), and look for “miniconda3” image.

Open the Operating System terminal and execute the command:
```
docker run -i -t -v <local machine path>:/home continuumio/miniconda3 /bin/bash
```
e.g. &lt;local machine path&gt; => C:\Users\Andre.Nicolau\Documents\Projects

Installing Htop program on the Docker container
```
(base) root@a95e814ebc80:/# apt update
(base) root@a95e814ebc80:/# apt upgrade
(base) root@a95e814ebc80:/# apt install htop
```

Downloading the mamba environment management
```
(base) root@a95e814ebc80:/# conda install -c conda-forge mamba
(base) root@a95e814ebc80:/# mamba init
```

Downloading an example pipeline (for more information about this snakemake pipeline, access here: https://snakemake.readthedocs.io/en/stable/tutorial/basics.html)
```
(base) root@a95e814ebc80:/# cd /home/<specific folder>
(base) root@a95e814ebc80:/# git clone https://github.com/ehpc-lab/docker-conda-course.git
(base) root@a95e814ebc80:/# cd docker-conda-course/
```

Installing the tutorial environment
```
(base) root@a95e814ebc80:/# mamba env create -n tutorial --file environment.yaml
(base) root@a95e814ebc80:/# conda activate tutorial
```

Executing the Snakemake pipeline
```
(base) root@a95e814ebc80:/# snakemake --cores <number of cores>
(base) root@a95e814ebc80:/# snakemake --cores 7
```

Closing the Docker container
```
(base) root@a95e814ebc80:/# exit
```


## Minimum commands to manage Docker images and containers
![plot](./figures/docker.png)

The main elements of Docker are Dockerfile, Image and Container. For this tutorial, we do not use the Dockerfile and how to build up to it. 

**What is a Dockerfile?**
<p>A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using docker build, users can create an automated build that executes several command-line instructions in succession. This page describes the commands you can use in a Dockerfile</p>

**What is a Docker image?**
<p>A Docker image is a file that executes code in a Docker container. Docker images act as a set of instructions to build a Docker container, like a template. Docker images also act as the starting point when using Docker. An image is comparable to a snapshot in virtual machine (VM) environments.</p>

**What is a container in Docker?**
<p>A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.</p>

Check out more details about any Docker command accessing this documentation: https://docs.docker.com/

Download Docker image
```
docker pull <NAME>
```
* The Docker image NAME is accessible on the Docker hub website.

An example of the docker pull command:
```
docker pull continuumio/miniconda3
```

The Docker image can be downloaded using the Docker run command only.
```
docker run -i -t --name CSBL -v <local machine path>:/home continuumio/miniconda3 /bin/bash
```
e.g. * &lt;local machine path&gt; => C:\Users\Andre.Nicolau\Documents\Projects

Closing the Docker container
```
(base) root@a95e814ebc80:/# exit
```

How do you leave a Docker container running in the background? In your personal OS terminal, execute the docker run command using -d parameter.
```
docker run -i -t -d --name CSBL2 -v <local machine path>:/home continuumio/miniconda3 /bin/bash
docker container ls
docker exec -i -t CSBL2 /bin/bash
(base) root@a95e814ebc80:/# 
(base) root@a95e814ebc80:/# exit
```
e.g. &lt;local machine path&gt; => C:\Users\Andre.Nicolau\Documents\Projects

Even closing the connection between the local machine and the Docker container, the container will still be running in the background. To access the same container and work on that, execute the Docker exec command:
```
docker exec -i -t CSBL2 /bin/bash
(base) root@a95e814ebc80:/# 
```

How to stop a Docker container, execute this command on the local OS terminal.
```
docker container stop (<CONTAINER ID> or <CONTAINER NAME>)
docker container stop CSBL2
```

How to start a Docker container
```
docker container start (<CONTAINER ID> or <CONTAINER NAME>)
docker container start CSBL2
```

**Starting another Docker container from the same Docker image.**

List of Docker images
```
docker images
```

Copy the IMAGE ID information and paste it on the Docker run command.
```
docker run -i -t -d --name CSBL3 -v <local machine path>:/home <IMAGE ID or IMAGE NAME> /bin/bash
```
e.g. &lt;local machine path&gt; => C:\Users\Andre.Nicolau\Documents\Projects

Check out the Docker container list.
```
docker container ls
```

To check out if all containers are running or stopped, use the -a parameter:
```
docker container ls -a
```

Copy the CONTAINER ID or CONTAINER NAME information to start the container.

Run the existing Docker container.
```
docker exec -i -t (<CONTAINER ID> or <CONTAINER NAME>) /bin/bash
docker exec -i -t CSBL3 /bin/bash
(base) root@a95e814ebc80:/# 
(base) root@a95e814ebc80:/# exit
```

Removing Docker container and images
```
docker container rm (<CONTAINER ID> or <CONTAINER NAME>)
docker container rm CSBL02
```

After removing all containers related to specific image, it is possible remove the image from the Docker App.
```
docker image rm (<IMAGE NAME> or <IMAGE ID>)
```


Saving the Docker container to a Docker image and then submitting it to Docker hub.

Login to your Docker hub account

```
docker login --username=<USER>
```

Save a Docker container as an image and deposit it on your personal Docker hub account.
```
docker commit <CONTAINER ID> <USER>/<IMAGE NAME>
docker commit CSBL02 anicolau/csbl-ourse
```

Check out the new image from Docker container.
```
docker images ls
```
  
Tag and submit the new image for the Docker hub
```
docker tag <NEW IMAGE ID> <USER>/<IMAGE NAME>
docker push <USER>/<IMAGE NAME>
  
docker tag <NEW IMAGE ID> anicolau/csbl-course
docker push anicolau/csbl-course
```

Delete all containers and images related to continuumio/miniconda3

Download your own Docker image from the Docker hub.
```
docker pull <USER>/<IMAGE NAME>
docker pull anicolau/csbl-course
```

Then, this image can be used for container and new analyses.

If you working with sensitivity information, the Docker image from specific project could be saved locally. To save an image:
```
docker save anicolau/csbl-course > csbl-course.tar
```

To load the new image from local machine.
```
docker load --input csbl-course.tar
```
Then use this image for docker container and new analyses


## Conda environment

Create an environment
```
(base) root@a95e814ebc80:/# conda create --name <ENV NAME>
(base) root@a95e814ebc80:/# conda create --name tutorial
```

Activate environment
```
(base) root@a95e814ebc80:/# conda activate <ENV NAME>
(base) root@a95e814ebc80:/# conda activate tutorial
```

Install packages using mamba
```
(tutorial) root@a95e814ebc80:/# conda deactivate
(base) root@a95e814ebc80:/# conda install -c conda-forge mamba
(base) root@a95e814ebc80:/# mamba init
(base) root@a95e814ebc80:/# mamba install <PACKAGE NAME>
(base) root@a95e814ebc80:/# mamba install -c bioconda bowtie2
```

Create a conda environment and install packages from environment.yaml file
```
(base) root@a95e814ebc80:/# mamba env create --name rnaseq --file environment.yaml
```

Add channel
```
(base) root@a95e814ebc80:/# conda config --add channels <CHANNEL NAME>
(base) root@a95e814ebc80:/# conda config --add channels bioconda
(base) root@a95e814ebc80:/# conda config --add channels conda-forge
```

Nested activation
```
(base) root@a95e814ebc80:/# conda activate --stack <ENV NAME>
(base) root@a95e814ebc80:/# conda activate --stack rnaseq
(rnaseq) root@a95e814ebc80:/# 
```

Conda deactivation
```
(rnaseq) root@a95e814ebc80:/# conda deactivate
(base) root@a95e814ebc80:/#
```
