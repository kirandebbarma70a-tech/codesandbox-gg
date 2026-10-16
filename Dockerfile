FROM node:16-alpine AS builder
WORKDIR /app
COPY package.json yarn.lock ./
# यहाँ '--ignore-scripts' जोड़ दिया है ताकि पोस्ट-इंस्टॉल एरर न आए
RUN yarn install --frozen-lockfile --ignore-scripts
COPY . .
RUN yarn build

FROM nginx:1.25.3-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
