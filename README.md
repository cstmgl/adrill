## Objective
This docker file creates an image of apache drill to prevent the startup error on OpenShift:

```
mkdir: cannot create directory '/opt/drill/log': Permission denied
ERROR: Log directory does not exist or is not writable: /opt/drill/log
```

### Build, tag and push the image
```
docker build .
```

```
docker tag <image-id> <your_username>/adrill:<version_id>
```

```
docker push <your_username>/adrill:<version_id>
```

### Launch it to test it

```
docker run -i --name adrill:<version_id> -p 8047:8047 -t <your_username>/adrill:<version_id> /bin/bash
```
