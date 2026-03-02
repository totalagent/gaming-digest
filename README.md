# 🎮 Gaming Digest

每日游戏行业资讯精选 · AI 自动维护

## 🌐 访问地址

- **官方网站**: [https://daily.aippletree.com](https://daily.aippletree.com)
- **Cloudflare Pages**: [https://ai-gaming-digest.pages.dev](https://ai-gaming-digest.pages.dev)
- **本地开发**: `npm run dev`

## 🚀 技术栈

- **框架**: [Astro](https://astro.build/) - 轻量级静态站点生成器
- **部署**: [Cloudflare Pages](https://pages.cloudflare.com/)
- **内容**: Markdown + Astro Content Collections

## 📝 内容结构

```
src/
├── content/
│   └── posts/          # 每日报告
│       ├── 2026-03-02-launch.md
│       └── YYYY-MM-DD-daily.md
├── layouts/
│   └── BaseLayout.astro
└── pages/
    ├── index.astro     # 首页
    └── posts/
        └── [slug].astro # 文章详情页
```

## 🛠 开发指南

### 本地开发

```bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 访问 http://localhost:4321
```

### 构建

```bash
npm run build
```

### 生成每日报告

```bash
npm run generate:daily
```

## 📅 自动化流程

### 游戏行业日报（每日 6:00）
```
Cron 触发 (Asia/Shanghai)
    ↓
抓取海外媒体数据
    ↓
生成 Markdown 简报
    ↓
Git Commit + Push
    ↓
Cloudflare Pages 自动构建
    ↓
网站更新 (daily.aippletree.com)
    ↓
发送飞书消息（含网页链接）
```

### IT 行业动态（每日 12:00）
```
Cron 触发 (Asia/Shanghai)
    ↓
抓取 InfoQ/Hacker News 等
    ↓
生成 Markdown 简报
    ↓
Git Commit + Push
    ↓
Cloudflare Pages 自动构建
    ↓
网站更新 (daily.aippletree.com)
    ↓
发送飞书消息（含网页链接）
```

## 🔧 配置

### Cloudflare Pages

1. 登录 [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. 进入 Pages → Create a project
3. 连接 GitHub 仓库 `totalagent/gaming-digest`
4. 构建设置：
   - **Build command**: `npm run build`
   - **Build output directory**: `dist`
5. 点击 Deploy

### 自定义域名

1. 在 Cloudflare Pages 项目设置中
2. 进入 Custom domains
3. 添加你的域名
4. 按提示配置 DNS

## 📄 License

MIT

---

*由 AI 自动维护的遊戲行業資訊網站*
