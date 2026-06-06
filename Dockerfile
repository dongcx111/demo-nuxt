# ==============================================
# 阶段1：安装依赖（利用Docker缓存层）
# ==============================================
FROM node:current-alpine3.23 AS deps
WORKDIR /app

# 复制依赖文件（只要它们不变，就不会重新安装依赖）
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# 安装所有依赖（包括开发依赖，用于构建）
RUN npm install -g pnpm  && pnpm install  --frozen-lockfile

# ==============================================
# 阶段2：构建应用
# ==============================================
FROM node:current-alpine3.23 AS builder
WORKDIR /app

# 复制依赖和源代码
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# 安装所有依赖（包括开发依赖，用于构建）
RUN npm install -g pnpm

# 构建Nuxt应用（生成.output目录）
# RUN npm run build
RUN pnpm build

# ==============================================
# 阶段3：生产运行环境（集成PM2）
# ==============================================
FROM node:current-alpine3.23 AS runner
WORKDIR /app

# 设置生产环境变量
ENV NODE_ENV=production
ENV NITRO_PORT=3000
ENV NITRO_HOST=0.0.0.0
# 设置Node.js内存限制（根据服务器配置调整）
ENV NODE_OPTIONS=--max-old-space-size=512

# 安装PM2（全局安装，版本固定确保稳定性）
RUN npm install -g pm2@5.4.2

# 创建非root用户（安全最佳实践）
RUN addgroup --system --gid 1001 nuxt
RUN adduser --system --uid 1001 --ingroup nuxt nuxt

# 创建必要目录并设置权限
RUN mkdir -p /app/.output /app/logs /app/pm2
RUN chown -R nuxt:nuxt /app

# 复制构建产物和PM2配置
COPY --from=builder /app/.output ./.output
COPY ecosystem.config.cjs ./

# 切换到非root用户
USER nuxt

# 暴露端口
EXPOSE 3000

# 健康检查（PM2会自动重启不健康的进程）
HEALTHCHECK --interval=30s --timeout=3s --start-period=15s --retries=3 \
    CMD wget -qO- http://localhost:3000/api/health || exit 1

# 启动命令：使用pm2-runtime在前台运行（Docker容器必须前台运行）
# --no-daemon 确保PM2在前台运行
# --no-auto-exit 防止PM2在所有应用退出后自动退出
CMD ["pm2-runtime", "ecosystem.config.cjs", "--no-daemon", "--no-auto-exit"]