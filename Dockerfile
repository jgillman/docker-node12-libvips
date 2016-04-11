FROM node:0.12-slim
MAINTAINER Joel Gillman <joel@joelgillman.com>

RUN apt-get update && apt-get install -qq -y pkg-config --fix-missing --no-install-recommends

# Install libvips dependencies via apt-get
RUN apt-get install -qq -y automake build-essential gobject-introspection gtk-doc-tools libglib2.0-dev libjpeg-dev libpng12-dev libwebp-dev libtiff5-dev libexif-dev libgsf-1-dev liblcms2-dev libxml2-dev swig libmagickcore-dev curl --fix-missing --no-install-recommends

COPY install_libvips_from_source.sh /var/lib/install_libvips_from_source.sh
RUN chmod +x /var/lib/install_libvips_from_source.sh
RUN /var/lib/install_libvips_from_source.sh

RUN apt-get clean

CMD ['bash']
