FROM ubuntu:20.04

ARG QT_VERSION=6.1.3

ENV QTDIR=/opt/Qt
ENV VAA3DPATH=/app/v3d_external
ENV LD_LIBRARY_PATH=${QTDIR}/gcc_64/lib
# ENV LD_LIBRARY_PATH=${VAA3DPATH}/v3d_main/v3d/common_lib/lib:${LD_LIBRARY_PATH}
ENV PATH=${QTDIR}/${QT_VERSION}/gcc_64/bin:$PATH
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true
# ENV V3D=/app/v3d_external/bin/Vaa3D-x

WORKDIR /app
RUN apt-get -y update && apt-get install -y git libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev python3-pip \
    build-essential libglib2.0-0 libsdl2-2.0 libsdl2-dev libhdf5-dev fontconfig xvfb

# install qt
RUN pip3 install --no-cache-dir aqtinstall && \
    aqt install-qt -O $QTDIR linux desktop $QT_VERSION gcc_64 -m all

# clone v3d repos
RUN git clone -b QT6_NEW --depth 1 https://github.com/Vaa3D/v3d_external.git
# RUN git clone -b vaa3d_tools_qt6 --depth 1 https://github.com/Vaa3D/vaa3d_tools.git
# RUN cd vaa3d_tools && \
#     ln -s ../v3d_external/v3d_main v3d_main && \
#     ln -s ../v3d_external/bin bin && \
#     cd ../v3d_external && \
#     ln -s ../vaa3d_tools/released_plugins released_plugins_more

# # build vaa3d
# WORKDIR /app/v3d_external/v3d_main/v3d
# RUN qmake v3d_qt6.pro && make -j
# 
# # build released plugins
# WORKDIR /app/vaa3d_tools/released_plugins
# RUN bash build_plugindemo.sh -j
# 
# COPY xvfb-vaa3d /usr/bin/
# RUN chmod +x /usr/bin/xvfb-vaa3d

WORKDIR /app/project
EXPOSE 80
# CMD [ "xvfb-vaa3d", "-h" ]