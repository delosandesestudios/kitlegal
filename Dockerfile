FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY kitlegal-limpio.zip .
RUN unzip -q -o kitlegal-limpio.zip \
 && cd kitlegal \
  && mv $(ls -A) ../ \
   && cd .. \
    && rmdir kitlegal \
     && rm kitlegal-limpio.zip
     RUN corepack enable && corepack prepare pnpm@10.18.0 --activate
     RUN CI=1 pnpm install --frozen-lockfile
     RUN pnpm build
     ENV NODE_ENV=production
     ENV PORT=3000
     EXPOSE 3000
     CMD ["sh", "-c", "pnpm db:migrate && node dist/index.js"]FROM node:22-bookworm-slim
     RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*
     WORKDIR /app
     COPY kitlegal-limpio.zip .
     RUN unzip -q -o kitlegal-limpio.zip \
      && cd kitlegal \
       && mv $(ls -A) ../ \
        && cd .. \
         && rmdir kitlegal \
          && rm kitlegal-limpio.zip
          RUN corepack enable && corepack prepare pnpm@10.18.0 --activate
          RUN CI=1 pnpm install --frozen-lockfile
          RUN pnpm build
          ENV NODE_ENV=production
          ENV PORT=3000
          EXPOSE 3000
          CMD ["sh", "-c", "pnpm db:migrate && node dist/index.js"]
