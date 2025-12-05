# Use Alpine as base image
FROM ngnix:latest

COPY index.html /usr/share/nginx/html/index.html


