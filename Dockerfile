FROM node:16-alpine AS builder
WORKDIR /app

# जरूरी सिस्टम डिपेंडेंसीज और टूल्स इंस्टॉल करें जो मोनोरेपो के लिए जरूरी हैं
RUN apk add --no-cache libc6-compat zstd tar bash git python3 make g++

COPY . .
RUN yarn install --ignore-optional --unsafe-perm
RUN yarn build

FROM nginx:1.25.3-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
