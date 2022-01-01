# 1. Build Phase
# a. base image
FROM node:17-alpine3.12 as builder
# assigning a reference to this container as builder

# Creating root node
WORKDIR '/app'

# Copying only package, to enable cached build
COPY ./package.json ./

# b. Running Command install, Update base image
RUN npm install

# copying src files, changes will trigger new build
COPY ./ ./

# c. Command override, do what the image is ment for
# not using CMD here, it is in run phase,
# here all task are related to building
RUN npm run build

# 2. Run phase
# a. base image, FROM is considered as Code block separator
FROM nginx

# deployment ready build will be inside the folder /app/build
COPY --from=builder /app/build /usr/share/nginx/html

# c. CMD is already present in nginx base image
# example - CMD ["nginx" "-g" "daemon off;"]



