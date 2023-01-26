FROM ubuntu:20.04
RUN apt-get update && apt-get install -y xvfb wget zip

ARG V3D_REL=https://github.com/Vaa3D/release/releases/download/v1.1.0/Vaa3D_x.1.1.0_Ubuntu.zip
ENV V3D=/app/Vaa3D/Vaa3D-x.sh

WORKDIR /app
COPY xvfb-vaa3d /usr/bin/
RUN wget -O v3d.zip ${V3D_REL} && \
    unzip v3d.zip && rm v3d.zip && \
    mv Vaa3D* Vaa3D && \
    chmod +x Vaa3D/Vaa3D-x* && \
    chmod +x /usr/bin/xvfb-vaa3d

EXPOSE 80
CMD [ "xvfb-vaa3d", "-h" ]