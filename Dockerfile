FROM node:16-alpine AS builder
WORKDIR /app
COPY . .
# Lerna की एरर से बचने के लिए --unsafe-perm और सामान्य इनस्टॉल का उपयोग करें
RUN yarn install --ignore-optional --unsafe-perm
RUN yarn build

FROM nginx:1.25.3-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
