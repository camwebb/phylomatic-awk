FROM alpine:latest

WORKDIR /opt
RUN apk add gawk curl
RUN curl -LO https://raw.githubusercontent.com/camwebb/phylomatic-awk/main/phylomatic

FROM alpine:latest
WORKDIR /opt
RUN apk add gawk
COPY --from=0 /opt/phylomatic .
RUN chmod u+x phylomatic

ENTRYPOINT ["/opt/phylomatic"]

