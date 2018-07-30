FROM oraclelinux

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
  && yum-config-manager --enable ol7_optional_latest ol7_software_collections\
  && yum install -y R \
  libcurl-devel \
  openssl-devel \
  libxml2-devel \
  pandoc \
  pandoc-citeproc \
  gcc \
  wget \
  sudo  \
  python34 \
  && echo /usr/lib64 >> /etc/ld.so.conf \
  && ldconfig \
  && yum install -y python34-pip \
  python34-devel \
  && pip3 install numpy pandas tableaudocumentapi

RUN echo "local({options(repos=c(CRAN = 'http://cran.rstudio.com/'))})" > /lib64/R/etc/Rprofile.site

ENV R_PROFILE="/lib64/R/etc/Rprofile.site"

RUN R -e 'install.packages(c("devtools","testthat","roxygen2","rmarkdown"))'

CMD ["/bin/bash"]
