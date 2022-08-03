FROM python:3.7-slim-bullseye
LABEL maintainer="@satake"

#
# install application
#
RUN apt update && apt install -y \
    build-essential \
    libsndfile1 \
    libasound2-dev \
    libjack-dev \
    portaudio19-dev \
    ca-certificates \
    curl \
    unzip \
    git && \
    rm -rf /var/lib/apt/lists/*

# RUN pip install tensorflow-directml
RUN pip install magenta
RUN git clone https://github.com/tensorflow/magenta.git /opt/magenta && \
    cd /opt/magenta && \
    pip install -e .
RUN curl https://storage.googleapis.com/magentadata/models/onsets_frames_transcription/maestro_checkpoint.zip > /opt/maestro_checkpoint.zip && \
    cd /opt && \
    unzip /opt/maestro_checkpoint.zip

WORKDIR /opt/magenta
RUN echo "#!/usr/bin/env bash" > /magenta.sh && \
    echo 'python magenta/models/onsets_frames_transcription/onsets_frames_transcription_transcribe.py --model_dir="/opt/train" /opt/wav/$1' >> /magenta.sh && \
    chmod +x /magenta.sh
ENTRYPOINT [ "/magenta.sh" ]
CMD ["magenta.wav"]
