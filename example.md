# build the image

```bash
docker build -t v3dx .
```

# run v3dx

```bash
docker run -v /home:/home -p 8081:80 -it --rm v3dx -h
```