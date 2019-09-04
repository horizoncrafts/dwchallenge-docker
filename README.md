# dwchallenge-docker
A docker image for Machine Learning exercises. Contains Anaconda plus some extra packages and customisations.

# Usage

## Setup

**Warning**: At the first execution this can download and take more then 5GB of your diskspace.

Having docker installed you can execute jupyter notebook to work with your notebooks like that:
```
docker run -p $your_port:8888 -e JUPYTER_TOKEN=$your_secret_token -v $your_notebooks_folder_path:/data/notebooks horizoncrafts/dwchallenge:latest
```
where:
- `$your_port` can be any port available on your local host (your notebook, for exmple). 8888 works usually.
- `$your_secret_token` is the token required when you login to jupyter notebook. Leave it empty or skip `-e JUPYTER_TOKEN=$your_secret_token` part so your coleagues on the same network can access your jupyter notbook without restricton (if not firewalled). Otherwise they'll need to provide the token (more secure).
- `$your_notebooks_folder_path` is a folder where your notebooks are located on your computer.

In the simplest case you can have it started like that:
```
docker run -p 8888:8888 -v "c:\Users\me\notebooks":/data/notebooks horizoncrafts/dwchallenge:latest
```
then go to `http://localhost:8888`

If protecting with a token you'll be asked to type it in. You can also connect to jupyter notbook providing token in the url, for exmple:
```
http://localhost:8888/tree?token=my_secret_token
```
Check this note: https://jupyter-notebook.readthedocs.io/en/latest/security.html#alternatives-to-token-authentication to learn more about authentication.

## Docker command line operations
Check running containers:
```
docker ps
```
all containers, including stoped:
```
docker ps -a
```
To kill a container (opposite to `docker run` described above):
```
docker kill [container id]
```
To stop or start a containter (like suspending and waking up):
```
docker stop [container id]
docker start [container id]
```
Connect to command line of a container:
```
docker exec -it [container id] /bin/bash
```
or use exclamation mark in python cell in jupyter notebook.

# docker-compose.yml example
```
version: '3.7'
services:
  jupyter:
    image: horizoncrafts/dwchallenge:latest
    ports:
      - $your_port:8888
    environment:
      JUPYTER_TOKEN: $your_secret_token
    volumes:
      - type: bind
        source: $your_notebooks_folder_path
        target: /data/notebooks
```

# References

This image is somehow inspired on the Continuum Analytics original one (https://hub.docker.com/_/anaconda), plus it has the minimum stuff required for Data Workshop challenges.

# Notes

## Data Workshop challengers! 

When solving a given challenge always use the image tagged with the previous challenge. For example, when you're at challenge 4 use image tagged "challenge03" instead of `latest`. It looks like this:
```
docker run -p 8888:8888 -v "c:\Users\me\notebooks":/data/notebooks horizoncrafts/dwchallenge:challenge03
```
This way you can excercise all tasks within a challenge.