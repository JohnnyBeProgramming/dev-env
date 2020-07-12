# Virtual Development Environment

This container gives you a simple way to run a fully functional developemnt environment inside a docker conatiner.

## Running the dev environemnt

To start up the virtual environmnet, linked to your current user accounts and ssh secrets, run:

```
docker run -it --rm \
    -v $PWD:/workspace \
    -e USER_ID=$(id -u $USER) \
    -e GROUP_ID=$(id -g $USER) \
    -e GIT_USER=$(git config user.name) \
    -e GIT_EMAIL="$(git config user.email)" \
    -v ~/.ssh:/home/sandbox/.ssh \
    runners/dev-end:latest
```

## Building the container

You can build the container locally by running:

```
docker build -t runners/dev-end:latest .
```
