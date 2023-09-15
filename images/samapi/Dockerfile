FROM python:3.9

COPY requirements.txt /app/requirements.txt

WORKDIR /app

# disable multi-gpu support for tensorflow
ENV USE_NCCL=0
ENV USE_CUDNN=0

RUN pip install --no-cache-dir -r requirements.txt 
RUN pip install --no-cache-dir git+https://github.com/openai/CLIP.git

# install libgl1-mesa-glx and libglib2.0-0 for opencv
RUN apt-get update && apt-get install -y libgl1-mesa-glx libglib2.0-0

COPY . /app

EXPOSE 8181

CMD ["python", "server.py"]