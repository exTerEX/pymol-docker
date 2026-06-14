FROM mambaorg/micromamba:2.8.1-debian13-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

USER root

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libgl1-mesa-dri \
    libglu1-mesa \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
ARG USERNAME=pymol
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} ${USERNAME} && \
    useradd -m -u ${UID} -g ${GID} -s /bin/bash ${USERNAME}

COPY --chown=${USERNAME}:${USERNAME} pymolrc /home/${USERNAME}/.pymolrc

WORKDIR /workspace

# Install PyMOL
RUN micromamba install -y -n base -c schrodinger -c conda-forge pymol catch2 \
    && micromamba clean -afy

USER ${USERNAME}

CMD ["pymol"]
