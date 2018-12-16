FROM frolvlad/alpine-fpc:latest AS builder

RUN apk add git \
    && git clone https://github.com/Kromster80/kam_remake \
    && cd kam_remake/src \
    && fpc KM_DedicatedServer.pas \
    && mv KM_DedicatedServer kam_remake_server


FROM alpine:3.8

COPY --from=builder /kam_remake/src/kam_remake_server .

RUN chmod +x kam_remake_server

EXPOSE 56789/tcp

CMD [ "./kam_remake_server" ]
