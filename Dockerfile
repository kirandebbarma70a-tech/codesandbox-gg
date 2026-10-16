# चरण 1: नोड का उपयोग करके प्रोजेक्ट बिल्ड करें
FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

# चरण 2: Nginx के ज़रिए फाइनल फाइलें सर्व करें
FROM nginx:1.25.3-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
