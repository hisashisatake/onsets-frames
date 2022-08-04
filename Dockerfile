FROM python:3.7-slim-bullseye
LABEL maintainer="@satake"

#
# install packages
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

#
# install & setup megenta
#
RUN pip install magenta
RUN git clone https://github.com/tensorflow/magenta.git /opt/magenta && \
    cd /opt/magenta && \
    pip install -e .

#
# setup magenta.sh
#
RUN echo '#!/usr/bin/env bash' > /magenta.sh && \
    echo 'if [ -d /opt/of ] && [ ! -f /opt/of/train/checkpoint ]; then' >> /magenta.sh && \
    echo 'curl https://storage.googleapis.com/magentadata/models/onsets_frames_transcription/maestro_checkpoint.zip > /opt/of/maestro_checkpoint.zip' >> /magenta.sh && \
    echo 'cd /opt/of && unzip /opt/of/maestro_checkpoint.zip' >> /magenta.sh && \
    echo 'fi' >> /magenta.sh && \
    echo 'cd /opt/magenta' >> /magenta.sh && \
    echo 'python magenta/models/onsets_frames_transcription/onsets_frames_transcription_transcribe.py --model_dir="/opt/of/train" /opt/of/wav/$1' >> /magenta.sh && \
    chmod +x /magenta.sh

ENTRYPOINT [ "/magenta.sh" ]
CMD ["magenta.wav"]
