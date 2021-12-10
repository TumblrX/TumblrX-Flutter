FROM cirrusci/flutter:2.5.3 AS build-env
WORKDIR /usr/local/bin/app
COPY . .
ENV API_URL API_URL=http://tumblrx.me:3000/
RUN echo $API_URL >> .env.development
RUN echo $API_URL >> .env.production
RUN flutter clean
RUN flutter pub get
RUN flutter build web

FROM nginx:1.16.0-alpine
COPY --from=build-env /usr/local/bin/app/build/web /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx","-g","daemon off;"]