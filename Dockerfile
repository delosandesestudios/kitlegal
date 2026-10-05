FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY kitlegal-limpio.zip .
RUN unzip -q -o kitlegal-limpio.zip -d /tmp/kit \
 && if [ -f /tmp/kit/package.json ]; then cp -a /tmp/kit/. /app/; \
    elif [ -f /tmp/kit/kitlegal/package.json ]; then cp -a /tmp/kit/kitlegal/. /app/; \
    else echo "estructura del zip no reconocida"; exit 1; fi \
 && rm -rf /tmp/kit kitlegal-limpio.zip
RUN corepack enable && corepack prepare pnpm@10.18.0 --activate
RUN CI=1 pnpm install --frozen-lockfile
RUN pnpm build
ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000
CMD ["sh", "-c", "pnpm db:migrate && node dist/index.js"]
