FROM python:3.6

RUN apt-get update && apt-get install -y \
  autoconf automake build-essential curl git libsnappy-dev libtool pkg-config

# Libpostal components
RUN git clone https://github.com/openvenues/libpostal
COPY ./*.sh /libpostal
WORKDIR /libpostal
RUN ["chmod", "+x", "build_libpostal.sh"]
RUN ./build_libpostal.sh

# Flask app components
WORKDIR /usr/src/app
COPY rest/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY rest/app.py .

EXPOSE 5000

CMD ["python", "./app.py"]
