## **Simple Web Server**

![](https://img.shields.io/github/issues/michalswi/simple-web-server)
![](https://img.shields.io/github/forks/michalswi/simple-web-server)
![](https://img.shields.io/github/stars/michalswi/simple-web-server)
![](https://img.shields.io/github/last-commit/michalswi/simple-web-server)

This is just POC to test Golang App with Azure App Services.  

[Link](https://docs.microsoft.com/en-us/azure/app-service/) to Azure App Services.  
[Link](https://docs.microsoft.com/en-us/azure/app-service/overview#next-steps) how to deploy using other languages than Go.

Golang Apps are not natively supported in App Services. To deploy I am using [custom containers](https://docs.microsoft.com/en-us/azure/app-service/deploy-container-github-action?tabs=publish-profile).



### # local environment
```
$ make

Usage:
  make <target>

Targets:
  build            Build bin
  run              Run app
  docker-build     Build docker image
  docker-run       Run docker
  docker-stop      Stop docker
```


### # important

If you use **non-root** user in Dockerfile, app might **not** work in Azure App Services (requires root).
