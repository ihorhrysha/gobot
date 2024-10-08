# 🤖 gobot

## Install using helm

from local directory:
```bash 
helm install gobot ./helm --set secret.value="<TELE_TOKEN>"
```

or from release:
```bash
helm install gobot https://github.com/ihorhrysha/gobot/releases/download/0.0.3/gobot-0.1.1.tgz --set secret.value="<TELE_TOKEN>"

## Build project 

```bash
go build -ldflags "-X="github.com/ihorhrysha/gobot/cmd.version=0.1.2
```

## Bot

t.me/ihorhrysha_go_bot

## CLI
```
A longer description that spans multiple lines and likely contains
examples and usage of using your application. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.

Usage:
  gobot [command]

Available Commands:
  completion  Generate the autocompletion script for the specified shell
  gobot       A brief description of your command
  help        Help about any command
  version     A brief description of your command

Flags:
  -h, --help     help for gobot
  -t, --toggle   Help message for toggle

Use "gobot [command] --help" for more information about a command.
```

## Jenkins pipeline

```bash
k create ns jenkins
helm repo add jenkinsci https://charts.jenkins.io/
helm repo update
helm install jenkins jenkinsci/jenkins -n jenkins
k port-forward svc/jenkins 8080:8080 -n jenkins
k exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
```

Install plugin SSH Agent and restart Jenkins

