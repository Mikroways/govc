FROM golang:1.9.2-alpine as code

#Download & Install govc
RUN apk update && apk add git findutils \
	&& go get -u github.com/vmware/govmomi/govc \
	&& apk del git \
        && rm -rf /var/cache/apk/*

FROM alpine 

COPY --from=code /go/bin/govc /govc

ENTRYPOINT ["/govc"]
