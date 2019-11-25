FROM openjdk:8-jre-alpine
MAINTAINER "Manojv" "manojv@ilimi.in"
RUN apk update \
    && apk add  unzip \
    && apk add curl \
    && adduser -u 1001 -h /home/sunbird/ -D sunbird \
    && mkdir -p /home/sunbird/learner
#ENV sunbird_learnerstate_actor_host 52.172.24.203
#ENV sunbird_learnerstate_actor_port 8088
RUN chown -R sunbird:sunbird /home/sunbird
USER sunbird
ENV HTTP_PROXY "http://172.22.218.218:8085"
ENV HTTPS_PROXY "http://172.22.218.218:8085"
ENV NO_PROXY "localhost,igx.mindtree.com,172.22.219.125,172.22.219.126,172.22.219.127,172.22.219.128,172.22.219.129,172.22.219.130,172.22.219.131,172.22.219.132,172.22.219.133,172.22.219.134,172.22.219.135,qa.ekstep.in"
ENV http_proxy "http://172.22.218.218:8085"
ENV https_proxy "http://172.22.218.218:8085"
ENV no_proxy "igx.mindtree.com,172.22.219.125,172.22.219.126,172.22.219.127,172.22.219.128,172.22.219.129,172.22.219.130,172.22.219.131,172.22.219.132,172.22.219.133,172.22.219.134,localhost,172.22.219.135,github.com,qa.ekstep.in"
COPY ./service/target/learning-service-1.0-SNAPSHOT-dist.zip /home/sunbird/learner/
RUN unzip /home/sunbird/learner/learning-service-1.0-SNAPSHOT-dist.zip -d /home/sunbird/learner/
WORKDIR /home/sunbird/learner/
CMD java  -cp '/home/sunbird/learner/learning-service-1.0-SNAPSHOT/lib/*' play.core.server.ProdServerStart  /home/sunbird/learner/learning-service-1.0-SNAPSHOT
