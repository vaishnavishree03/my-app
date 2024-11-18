FROM node:20-alpine AS build
WORKDIR /my-app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /my-app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 81
CMD ["nginx", "-g", "daemon off;"]