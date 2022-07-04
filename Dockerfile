FROM node:alpine AS builder

WORKDIR /app

## Install dependencies
COPY ["./package.json", "./package-lock.json", "/app/"]

RUN npm install

## Add source code
COPY ["./tsconfig.json", "/app/"]
COPY "./src" "/app/src/"

## Build
RUN npm run build

# PRODUCTION IMAGE

FROM node:alpine

WORKDIR /app

COPY --from=builder [\
  "/usr/src/app/package.json", \
  "/usr/src/app/package-lock.json", \
  "/app/" \
  ]

COPY --from=builder "/usr/src/app/dist" "/app/dist/"

RUN npm install --omit=dev

EXPOSE 3000

ENTRYPOINT [ "npm", "start" ]
