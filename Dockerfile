# ------------ Stage 1 ---------------------------------
FROM node:23.3-slim as prototype
RUN apt update \
    && apt -y install git \
    && git clone https://github.com/gorisanson/pikachu-volleyball.git \
    && cd pikachu-volleyball \
    && npm config set yes true \
    && npm install npm@8 \
    && npm run build
# ---------- Stage 2 ---------------------------------
FROM alpine:latest  
RUN apk --no-cache add ca-certificates
COPY --from=prototype /pikachu-volleyball ./
RUN apk add nodejs npm && npm install http-server --force
EXPOSE 8080
CMD ["npx", "http-server", "dist"]
