FROM buildpack-deps:trusty-scm

ENV GOLANG_VERSION 1.4.2
ENV GOLANG_SRC_URL https://github.com/gomini/go-mips32.git
ENV GOOS linux
ENV GOARCH mips32
ENV GOROOT /usr/local/go

RUN apt-get update && \
    apt-get install -y gcc

RUN cd /usr/local/ && \ 
    curl -L https://github.com/gomini/go-mips32/archive/dev.github.tar.gz | tar -xz && \
    mv go-mips32-dev.github go/

RUN cd /usr/local/go/src && \
	./make.bash 

RUN mkdir /go

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN rm -rf "$GOROOT/src/*"
RUN rm -rf "$GOROOT/test/*"
RUN rm -rf "$GOROOT/doc/*"

RUN chmod -R 777 "$GOPATH"

WORKDIR $GOPATH/src