# Nuxt 4 Demo Application

![Nuxt](https://img.shields.io/badge/Nuxt-4.x-00DC82?style=flat-square)
![Vue](https://img.shields.io/badge/Vue-3.x-4FC08D?style=flat-square)
![Tailwind CSS](https://img.shields.io/badge/Tailwind%20CSS-4.x-06B6D4?style=flat-square)
![TypeScript](https://img.shields.io/badge/TypeScript-5.x-3178C6?style=flat-square)

一个现代化的 Nuxt 4 示例应用，使用 Vue 3、Tailwind CSS 4 和 GSAP 构建。

## 🔗 预览地址

[![Vercel Preview](https://vercel.com/button)](https://demo-nuxt-xi.vercel.app/)

## ✨ 功能特性

- **现代化设计**：基于 Tailwind CSS 4 和 @nuxt/ui 构建的精美界面
- **动态路由**：支持示例列表页和详情页的动态路由
- **骨架屏加载**：优雅的加载状态展示
- **网格背景动画**：使用 GSAP 实现的动态背景效果
- **响应式布局**：完美适配各种屏幕尺寸
- **TypeScript 支持**：完整的类型安全

## 🛠️ 技术栈

| 技术         | 版本 | 描述                   |
| ------------ | ---- | ---------------------- |
| Nuxt         | 4.x  | Vue 框架               |
| Vue          | 3.x  | 渐进式 JavaScript 框架 |
| Vue Router   | 5.x  | Vue 路由管理           |
| Tailwind CSS | 4.x  | 原子化 CSS 框架        |
| @nuxt/ui     | 4.x  | Nuxt 官方 UI 组件库    |
| GSAP         | 3.x  | 高性能动画库           |
| TypeScript   | 5.x  | 类型安全               |
| PM2          | 5.x  | 生产环境进程管理       |

## 示例数据来源

应用使用 [DummyJSON](https://dummyjson.com/docs) 提供的免费 REST API 作为示例数据源，用于展示产品列表和详情页面。

## 📦 安装

```bash
# 安装依赖
pnpm install

# 开发模式运行
pnpm dev

# 构建生产版本
pnpm build

# 预览生产版本
pnpm preview
```

## 🚀 开发

启动开发服务器：

```bash
pnpm dev
```

访问 `http://localhost:3000` 查看应用。

## 📁 项目结构

```
my-nuxt/
├── app/
│   ├── assets/           # 静态资源
│   │   └── css/
│   │       └── main.css  # 全局样式
│   ├── components/       # 组件
│   │   ├── background/   # 背景组件
│   │   ├── blog/         # 博客相关组件
│   │   └── layout/       # 布局组件
│   ├── layouts/          # 页面布局
│   │   └── default.vue   # 默认布局
│   ├── pages/            # 页面路由
│   │   ├── blog/         # 博客页面
│   │   │   ├── detail/   # 博客详情
│   │   │   └── list.vue  # 博客列表
│   │   └── index.vue     # 首页
│   ├── types/            # TypeScript 类型定义
│   └── app.vue           # 根组件
├── public/               # 公共资源
├── Dockerfile           # Docker 配置
├── ecosystem.config.cjs # PM2 配置
├── nuxt.config.ts       # Nuxt 配置
├── package.json         # 项目依赖
└── tsconfig.json        # TypeScript 配置
```

## 🐳 Docker 部署

### 构建镜像

```bash
docker build -t nuxt4-app:latest .
```

### 运行容器

```bash
docker run -d -p 3000:3000 --name nuxt4-app nuxt4-app:latest
```

应用将在 `http://localhost:3000` 运行。

### Docker Compose（可选）

创建 `docker-compose.yml`：

```yaml
version: "3.8"
services:
  nuxt4-app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    restart: unless-stopped
```

运行：

```bash
docker-compose up -d
```

## 📝 脚本命令

| 命令            | 描述           |
| --------------- | -------------- |
| `pnpm dev`      | 启动开发服务器 |
| `pnpm build`    | 构建生产版本   |
| `pnpm preview`  | 预览生产版本   |
| `pnpm generate` | 生成静态站点   |
| `pnpm lint`     | 代码检查       |
| `pnpm fmt`      | 代码格式化     |

## 📄 许可证

MIT License
