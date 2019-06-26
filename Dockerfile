# Set the base image to use to centos 7
FROM centos:7

# Set the file maintainer
MAINTAINER haoranyu(haoran_yu@hotmail.com)

# Install necessary tools
RUN yum -y install wget make yum-utils

# Install python dependencies
RUN yum-builddep python -y

# Download the python3.7.3
RUN wget -O /tmp/Python-3.7.3.tgz https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz

# Build and install python3.7.3
RUN tar -zxvf /tmp/Python-3.7.3.tgz -C /tmp/
RUN /tmp/Python-3.7.3/configure
RUN make && make install

# Create symbolic link
RUN rm -f /usr/bin/python
RUN ln -s /usr/local/bin/python3 /usr/bin/python
RUN ln -s /usr/local/bin/pip3 /usr/bin/pip

# Upgrade the pip
RUN pip install --upgrade pip

# Fix the yum
RUN sed -i 's/python/python2/' /usr/bin/yum

# Clean
RUN rm -rf /tmp/Python-3.7.3*
RUN yum clean all

RUN pip3 install ipython
RUN pip3 install bpython
