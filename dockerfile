FROM python:3.8-slim

RUN apt-get update && apt-get install -y nginx

RUN rm /etc/nginx/nginx.conf
COPY test.conf /etc/nginx/conf.d/test.conf
COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /app
COPY ./app/* /app/
RUN mkdir templates
COPY ./app/templates/* /app/templates/
RUN mkdir static
RUN mkdir /app/static/css
RUN mkdir /app/static/javaScript
COPY ./app/static/css/* /app/static/css/
COPY ./app/static/javaScript/* /app/static/javaScript/

RUN apt-get install -y vim
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install  gunicorn

EXPOSE 8080
EXPOSE 443
ADD start.sh /
RUN chmod +x /start.sh
CMD ["/bin/bash", "-c","/start.sh" ]
