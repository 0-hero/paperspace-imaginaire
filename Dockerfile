FROM nvcr.io/nvidia/pytorch:21.06-py3
ARG DEBIAN_FRONTEND=noninteractive

# Install basics
RUN apt-get update && apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        build-essential \
        cmake \
        git \
        curl \
        vim \
        tmux \
        wget \
        bzip2 \
        unzip \
        g++ \
        ca-certificates \
        ffmpeg \
        libx264-dev \
        imagemagick \
        libnss3-dev
RUN pip install --upgrade cmake
RUN pip install --upgrade pynvml
RUN pip install --upgrade Pillow>=8.3.2
RUN pip install --upgrade scipy==1.3.3
RUN pip install --upgrade scikit-image
RUN pip install --upgrade tqdm==4.35.0
RUN pip install --upgrade wget
RUN pip install --upgrade cython
RUN pip install --upgrade lmdb
RUN pip install --upgrade av
RUN pip install --upgrade opencv-python
RUN pip install --upgrade opencv-contrib-python
RUN pip install --upgrade imutils
RUN pip install --upgrade imageio-ffmpeg
RUN pip install --upgrade qimage2ndarray
RUN pip install --upgrade albumentations
RUN pip install --upgrade requests==2.25.1
RUN pip install --upgrade nvidia-ml-py3==7.352.0
RUN pip install --upgrade pyglet
RUN pip install --upgrade timm
RUN pip install --upgrade diskcache
RUN pip install --upgrade boto3
RUN pip install --upgrade awscli_plugin_endpoint
RUN pip install --upgrade awscli
RUN pip install --upgrade rsa
RUN pip install --upgrade wandb
RUN pip install --upgrade tensorboard
RUN pip install --upgrade lpips
RUN pip install --upgrade face-alignment
RUN pip install --upgrade dlib
RUN pip install --upgrade clean-fid
RUN pip install -I jinja2 >=3.1.1
RUN pip install --upgrade nbdev nbconvert jupyter jupyterlab
RUN pip install --upgrade ipywidgets
RUN pip install --upgrade jupyter_contrib_nbextensions jupyterlab-git
COPY imaginaire/third_party/correlation correlation
RUN cd correlation && rm -rf build dist *-info && python setup.py install
COPY imaginaire/third_party/channelnorm channelnorm
RUN cd channelnorm && rm -rf build dist *-info && python setup.py install
COPY imaginaire/third_party/resample2d resample2d
RUN cd resample2d && rm -rf build dist *-info && python setup.py install
COPY imaginaire/third_party/bias_act bias_act
RUN cd bias_act && rm -rf build dist *-info && python setup.py install
COPY imaginaire/third_party/upfirdn2d upfirdn2d
RUN cd upfirdn2d && rm -rf build dist *-info && python setup.py install
COPY imaginaire/model_utils/gancraft/voxlib gancraft/voxlib
RUN cd gancraft/voxlib && make

COPY run.sh /run.sh
CMD ["/run.sh"]