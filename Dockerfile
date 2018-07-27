FROM oraclelinux

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
  && yum-config-manager --enable ol7_optional_latest \
  && yum install -y R \
  libcurl-devel \
  openssl-devel \
  libxml2-devel \
  pandoc \
  pandoc-citeproc \
  python-pip \
  && pip install --upgrade pip \
  && pip install tableaudocumentapi \
  numpy \
  pandas

RUN echo "local({options(repos=c(CRAN = 'http://cran.rstudio.com/'))})" > /lib64/R/etc/Rprofile.site

ENV R_PROFILE="/lib64/R/etc/Rprofile.site"

RUN R -e 'install.packages(c("devtools","testthat","roxygen2","rmarkdown"))'

CMD ["/bin/bash"]
