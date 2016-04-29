FROM app-deps

# copy the application files and add them on the import path
RUN mkdir /app
WORKDIR /app
COPY setup.py /app/
COPY src /app/src
# there are other ways (like .pth file) but this one allows
# for easy setup of various bin scripts app might need
RUN python2.7 setup.py develop

# create an user for the application and install basic tools
# to change user (pysu) and wait for services (holdup)
ARG USER=app
ENV USER=$USER
RUN echo "Creating user: $USER" \
 && groupadd --system  $USER \
 && useradd --system --create-home --gid=$USER --base-dir=/var $USER \
 && pip install pysu==0.1.0 holdup==1.0.0 \
 && pysu $USER id
# this last one just tests that pysu works
