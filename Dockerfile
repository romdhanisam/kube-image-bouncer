FROM golang:1.8-alpine

COPY . /go/src/github.com/romdhanisam/kube-image-bouncer
WORKDIR /go/src/github.com/romdhanisam/kube-image-bouncer
RUN go build


FROM alpine
WORKDIR /app
RUN adduser -h /app -D web
COPY --from=0 /go/src/github.com/romdhanisam/kube-image-bouncer/kube-image-bouncer /app/

RUN chown -R web:web *
USER web
ENTRYPOINT ["./kube-image-bouncer"]
EXPOSE 1323
