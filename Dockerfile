FROM apache/drill:1.18.0 AS builder

LABEL version="1.18"
LABEL description="This is a WRAP version of Apache Drill with non-root user"
LABEL maintainer="No-one, use at own risk"

FROM adoptopenjdk/openjdk8:centos-slim

RUN yum -y install nss_wrapper gettext

RUN adduser drill

ARG APP_ROOT=/opt/drill

RUN mkdir -p ${APP_ROOT} && chmod -R g+rw ${APP_ROOT}

COPY --from=builder ${APP_ROOT} ${APP_ROOT}

ENV DRILL_HOME ${APP_ROOT}

RUN ln -s ${DRILL_HOME}/bin/drill-embedded /usr/local/bin/drill-embedded

RUN chown -R drill:drill ${DRILL_HOME}

ENV PATH "${DRILL_HOME}/bin:$PATH"

USER drill

WORKDIR ${DRILL_HOME}

ENTRYPOINT [ "drill-embedded" ]
