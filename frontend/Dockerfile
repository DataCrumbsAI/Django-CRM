FROM node:22-slim

RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app

# Install dependencies (layer cached)
COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile || pnpm install

# Copy ALL source code
COPY . .

EXPOSE 5173
CMD ["pnpm", "dev", "--host", "0.0.0.0"]
