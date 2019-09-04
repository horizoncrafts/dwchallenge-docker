FROM ubuntu:latest

ENV ANACONDA_FILE Anaconda3-2019.07-Linux-x86_64.sh
ENV ANACONDA_PATH /opt/anaconda3

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH $ANACONDA_PATH/bin:$PATH


RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates git man

RUN wget --quiet https://repo.anaconda.com/archive/$ANACONDA_FILE && chmod +x $ANACONDA_FILE

RUN ./$ANACONDA_FILE -b -p $ANACONDA_PATH && rm $ANACONDA_FILE

RUN ln -s $ANACONDA_PATH/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". $ANACONDA_PATH/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc


# additional packages: tensorflow and keras
RUN conda install -y --quiet tensorflow && conda install -y --quiet keras

# additional packages for challange03: python-socketio, eventlet, flask 
RUN conda install -y --quiet python-socketio && conda install -y --quiet -c conda-forge eventlet && conda install -y --quiet flask

# additional packages for challange04: pyLDAvis, seaborn, gensim (used pip for gensim as conda installed older version)
RUN conda install -y --quiet -c conda-forge pyLDAvis seaborn && pip install gensim

#disabling any authentication
RUN jupyter notebook --generate-config && \
    printf "\n#added by dockerfile\nfrom os import environ\nc.NotebookApp.token = environ.get('JUPYTER_TOKEN', '')\nc.NotebookApp.password = ''\n" >> ~/.jupyter/jupyter_notebook_config.py 

WORKDIR /data/notebooks

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip", "0.0.0.0", "--allow-root", "--no-browser"]
