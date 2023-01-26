# v3dx-docker

Vaa3D-x is based on Qt6, which only runs on Ubuntu >= 20.04, Red Hat >= 8.4.
This docker file is for building an image containing an instance of Vaa3D-x and you can run it as
an executable to run CLI plugins.

Basically, you can run Vaa3D from the release build that downloads a Vaa3D-x for ubuntu from GitHub, and provide your own plugins
by compiling them in the build image that clones Vaa3D sources from GitHub. For compiling, you'll need to modify your Qt project to specify the build destination and Vaa3D source path.

You can also choose to compile plugins in the build image and use the image in operation, but it's quite large and not convenient for sharing the plugins across multiple machines. You are advised to mount your plugin directory to multiple release containers instead.

## build the image

You can provide arguments to use different qt versions or v3d release versions.

```bash
# build the executable image
docker build -t v3dx-release -f release.Dockerfile .

# build the build image
docker build -t v3dx-build -f build.Dockerfile .
```
Vaa3D and plugins compiling from source is commented in the build image. The release image is much smaller, but
you must keep your own plugins built with the same version of Qt with the release.

## run v3dx

```bash
# run the executable, print help by default
docker run -it --rm v3dx
# sort swc help, mount home, single command
docker run -v /home:/home -it --rm v3dx-release xvfb-vaa3d -x sort -f help
# multiple commands
docker run -v /home:/home -it --rm v3dx-release bash -c "
    xvfb-vaa3d -x plugin_name1 -f help
    xvfb-vaa3d -x plugin_name2 -f help
"
# mount a dir with extra plugins
docker run -v `pwd`/extra_plugins:/app/Vaa3D/plugins/extra_plugins:ro -it --rm v3dx-release xvfb-vaa3d -x plugin_name -f help
```

## compile plugins

```bash
# Modify the include and dest paths in your project to use the source in app and generate binary in the project direcotry
docker run -v /path/to/your/project:/app/project -it --rm v3dx_plugin_compile bash -c 'qmake *.pro; make -j'
```