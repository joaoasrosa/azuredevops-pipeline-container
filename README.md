# Introduction 
This repository contains the code to build and test the `azuredevops-pipeline-container`. The `azuredevops-pipeline-container` is the container which allows other containers to be built, enabling the teams to have the necessary capabilities to build, test and deploy the software.

[![Build Status](https://dev.azure.com/joaoasrosa/joaoasrosa/_apis/build/status/joaoasrosa.azuredevops-pipeline-container)](https://dev.azure.com/joaoasrosa/joaoasrosa/_build/latest?definitionId=3)

## Getting Started
To develop and test the container you need:
1. [Docker CE 18.x](https://www.docker.com/) 
2. [Google Container Tools](https://github.com/GoogleContainerTools/)
3. Your preferred IDE

## Build and Test
In order to build and test in your development machine you:
1. Form your command line navigate to the root of the repo
2. Run `docker build -f Dockerfile -t build-container:latest .`
3. Run `container-structure-test test --image build-container:latest --config ./command-tests.yaml`

## Contribute
If the build and test is sucessful, you can commit the changes to the server (in a branch). After it open the PR for ewview.

After it has been approved, the container will be available to the developer community.

Do not forget to add your name and email to the `maintainers` label within the `Dockerfile`. You deserve credit! :)