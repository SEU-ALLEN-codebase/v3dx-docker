FROM ubuntu:20.04
WORKDIR /app
RUN apt update && apt install -y xvfb wget zip
ARG V3D_REL=https://github.com/Vaa3D/release/releases/download/v1.1.0/Vaa3D_x.1.1.0_Ubuntu.zip
RUN wget -O v3d.zip $V3D_REL && unzip v3d.zip && rm v3d.zip && mv Vaa3D* Vaa3D && chmod +x Vaa3D/Vaa3D-x*
COPY xvfb-startup.sh .
RUN sed -i 's/\r$//' xvfb-startup.sh && chmod +x xvfb-startup.sh
ENV XVFB_RES="1920x1080x24"
ENV XVFB_ARGS=""
EXPOSE 80
ENTRYPOINT [ "./xvfb-startup.sh", "Vaa3D/Vaa3D-x.sh" ]
CMD [ "-h" ]