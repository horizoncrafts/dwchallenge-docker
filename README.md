# dwchallenge-docker
A docker image for Machine Learning exercises. Contains Anaconda plus some extra packages and customisations.

# Usage

**Warning**: There's no authentication at all in this version. Check this note: https://jupyter-notebook.readthedocs.io/en/latest/security.html#alternatives-to-token-authentication

**Warning**: After the first execution this will take more then 5GB of your diskspace.

## Simple

Having docker installed and downloaded/cloned these files, change directory (cd) to where the files are and run:
```
docker-compose up
```

For the first time it's going to take few to twenty minutes to build the image, but the consequential runs will be very fast.

Once the service has started go to your web browser and navigate to `https://localhost:8888`. **No authentication required!**

## Some customization

To work on jupyter notebooks located on your computer edit the `docker-compose.yml` :
```
    volumes:
      - type: bind
        source: [location of your notebooks on the host filesystem]
        target: /data/notebooks
```

Wanna change the port? Edit:
```
    ports:
      - [your favorite port]:8888
```

## Complete docker-compose.yml
```
version: '3.7'
services:
  jupyter:
    build:
      context: .
    ports:
      - 8888:8888
    volumes:
      - type: bind
        source: ..
        target: /data/notebooks
```

# References

This image is somehow inspired on the Continuum Analytics original one (https://hub.docker.com/_/anaconda), plus it has the minimum stuff required for Data Workshop challenges.
