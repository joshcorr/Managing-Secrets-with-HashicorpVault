FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get install -y curl liblttng-ust0 ca-certificates libicu-dev && \ 
    curl -sOL https://github.com/PowerShell/PowerShell/releases/download/v7.1.5/powershell_7.1.5-1.debian.11_amd64.deb && \
    dpkg -i powershell_7.1.5-1.debian.11_amd64.deb
USER jenkins
ADD jenkins-job.xml /usr/share/jenkins/ref/jobs/daily-weather-check/config.xml
ADD scheduled-forecast.ps1 /tmp/scheduled-forecast.ps1
RUN jenkins-plugin-cli --plugins "powershell:1.7 hashicorp-vault-plugin:3.8.0"