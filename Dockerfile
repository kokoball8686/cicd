FROM alpine:latest  
RUN apk --no-cache add ca-certificates
RUN apk add git \
    && git clone https://github.com/gorisanson/pikachu-volleyball.git \
    && cd pikachu-volleyball \
    && apk add nodejs npm \
    && npm config set yes true \
    && npm install npm@8 \
    && npm run build \
    && npm install http-server --force
RUN cd / \
    && mv /pikachu-volleyball/* /
EXPOSE 8080
CMD ["npx", "http-server", "dist"]
