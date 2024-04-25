FROM oven/bun:alpine AS runtime
WORKDIR /app
# COPY package.json ./
COPY . .
RUN bun i
EXPOSE 5173
CMD bunx --bun vite dev --host 0.0.0.0