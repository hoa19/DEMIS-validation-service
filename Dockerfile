FROM eclipse-temurin:17.0.6_10-jre-alpine

# The STOPSIGNAL instruction sets the system call signal that will be sent to the container to exit
# SIGTERM = 15 - https://de.wikipedia.org/wiki/Signal_(Unix)
STOPSIGNAL SIGTERM

# Define the exposed port or range of ports for the service
EXPOSE 8080

# Default USERID and GROUPID
ARG USERID=10000
ARG GROUPID=10000

COPY --chown=$USERID:$GROUPID target/validation-service.jar /app.jar

# Run as User (not root)
USER $USERID:$USERID

ENTRYPOINT ["java", "-jar", "/app.jar"]

# Git Args
ARG COMMIT_HASH
ARG VERSION

###########################
# Labels
###########################
LABEL de.gematik.vendor="gematik GmbH" \
      maintainer="software-development@gematik.de" \
      de.gematik.app="DEMIS Validation-Service" \
      de.gematik.git-repo-name="https://gitlab.prod.ccs.gematik.solutions/git/demis/validation-service.git" \
      de.gematik.commit-sha=$COMMIT_HASH \
      de.gematik.version=$VERSION