# Bioinformatics analyses using Docker and Conda environment

This protocol was created for creating and configuring Docker containers and Conda environment for bioinformatics analyses.

## What is necessary to run this protocol:
- A machine running any operating system (such as Linux, Windows or macOS)
- Minimum or zero command-line knowledge

## Summary
Itens here

## Docker installation

### For windows
Access the “Get Docker” website (https://docs.docker.com/get-docker/), and click on get started. Find the installer for Docker Desktop For Windows. Download the files and install them locally on the computer.

After download, start the installation file (.exe) and keep the default parameters. Make sure that the two options “Install required Windows components for WSL 2” and “Add shortcut the desktop” are marked.

NOTE: In some cases, when this software tries to start the service, it shows an error: “WSL installation is incomplete”. To figure out this error, access the website WSL2-Kernel (https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel).

Download and install the “latest WSL2 Linux kernel”.

Access PowerShell terminal as Administrator and execute the command:
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

Ensure that the software Docker Desktop is installed successfully.

### For Linux
Access the “Get Docker Linux” website (https://docs.docker.com/get-docker/) and follow the instructions for installing.

Update all Linux packages using the command line:
```
sudo apt-get update
```

Install required packages to the Docker program:
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

### For macOS
Access the “Get Docker” website (https://docs.docker.com/get-docker/), click on “Docker Desktop for Mac”, and choose the Docker installation file for “Intel chip” or “Apple chip”.

Execute the Docker.dmg file to open the installer, then drag the icon to the Applications folder. Localize and execute the Docker.app in the Applications folder to start the program.

NOTE: The software specific menu in the top status bar indicates that the software is running and that it is accessible from a terminal.

## Creating a Docker container from scratch
### Download a Linux official image from the Docker hub
Access the Docker hub website (https://hub.docker.com/), and look for “miniconda3” image.

Open the Operating System terminal and execute the commands:
```
docker pull continuumio/miniconda3
docker run -i -t -v <local machine path>:/home continuumio/miniconda3 /bin/bash
```

```
(base) root@a95e814ebc80:/# conda install -c conda-forge mamba
(base) root@a95e814ebc80:/# cd /home/<specific folder>
(base) root@a95e814ebc80:/# git clone https://github.com/ehpc-lab/docker-conda-course.git
(base) root@a95e814ebc80:/# cd docker-conda-course/
(base) root@a95e814ebc80:/# mamba env create -n tutorial --file environment.yaml
(base) root@a95e814ebc80:/# conda activate tutorial
(base) root@a95e814ebc80:/# snakemake --cores 19
```

## Minimum commands to manage Docker images and containers
