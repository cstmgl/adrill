FROM apache/drill:1.18.0 AS builder

LABEL version="1.18"
LABEL description="This is a WRAP version of Apache Drill with non-root user"
LABEL maintainer="No-one, use at own risk"

FROM adoptopenjdk/openjdk8:centos-slim

RUN yum -y install nss_wrapper gettext

RUN adduser drill

ARG APP_ROOT=/opt/drill

RUN mkdir -p ${APP_ROOT} && chmod -R g+rw ${APP_ROOT}

RUN chown -R drill ${APP_ROOT}

USER drill

COPY --from=builder /opt/drill ${APP_ROOT}

ENTRYPOINT [ ${APP_ROOT}/drill-embebbed ]