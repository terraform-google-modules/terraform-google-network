FROM ubuntu:latest
RUN apt-get update && apt install --yes sudo
RUN apt-get install --yes python3.9
RUN docker run --rm -it --cap-add SYS_ADMIN alpine sh
RUN sudo apt-get install --yes docker-ce docker-ce-cli containerd.io
