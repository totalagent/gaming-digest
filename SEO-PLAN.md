# 网站 SEO 优化方案 - 独立分类页面

**创建时间**: 2026-03-03 09:31
**版本**: v2.0
**目标**: 提升搜索引擎可见性和有机流量

---

## 📋 方案概述

**核心变更**: 从 Query 参数改为独立分类页面

### URL 结构

**当前（方案 A）**:
```
/                    → 首页
/?category=game      → 游戏动态
/?category=it        → IT 动态
/?category=new-games → 新游发现
```

**新方案（方案 B）**:
```
/                    → 首页（最新文章汇总）
/game/page/1         → 游戏动态（分页）
/it/page/1           → IT 动态（分页）
/new-games/page/1    → 新游发现（分页）
/posts/{slug}/       → 文章详情页
```

---

## 🎯 SEO 优化目标

### 关键词策略

| 分类 | 目标关键词 | 搜索意图 |
|------|-----------|---------|
| 游戏动态 | 游戏行业新闻、游戏行业动态 | 信息获取 |
| IT 动态 | IT 行业资讯、科技新闻 | 信息获取 |
| 新游发现 | 新游戏推荐、独立游戏推荐 | 发现/购买 |

### 预期效果

- ✅ 分类页面独立索引
- ✅ 提升长尾关键词排名
- ✅ 改善网站结构层次
- ✅ 提高用户停留时间

---

## 🔧 技术实现

### 1. 目录结构

```
src/
├── pages/
│   ├── index.astro              # 首页
│   ├── posts/
│   │   └── [slug].astro         # 文章详情
│   ├── game/
│   │   └── [page].astro         # 游戏动态分类
│   ├── it/
│   │   └── [page].astro         # IT 动态分类
│   └── new-games/
│       └── [page].astro         # 新游发现分类
```

### 2. 路由配置

**动态路由生成**:
```astro
---
// src/pages/game/[page].astro
export async function getStaticPaths() {
  const posts = await getCollection('posts');
  const gamePosts = posts.filter(p => p.data.category === '游戏动态');
  
  const POSTS_PER_PAGE = 10;
  const totalPages = Math.ceil(gamePosts.length / POSTS_PER_PAGE);
  
  return Array.from({ length: totalPages }, (_, i) => ({
    params: { page: (i + 1).toString() },
    props: {
      posts: gamePosts.slice(i * POSTS_PER_PAGE, (i + 1) * POSTS_PER_PAGE),
      currentPage: i + 1,
      totalPages,
    },
  }));
}
---
```

### 3. 重定向配置

**301 重定向（旧 URL → 新 URL）**:
```
/?category=game     → /game/page/1
/?category=it       → /it/page/1
/?category=new-games → /new-games/page/1
```

**实现方式**: `public/_redirects` (Cloudflare Pages 支持)

```
# Redirects
/?category=game     /game/page/1    301
/?category=it       /it/page/1      301
/?category=new-games /new-games/page/1  301
```

---

## 📝 SEO 优化清单

### 1. 页面 Meta 优化

#### 首页
```html
<title>Gaming Digest - 每日游戏行业资讯精选</title>
<meta name="description" content="Gaming Digest 提供每日游戏行业资讯、IT 动态、新游发现。涵盖 Steam、itch.io 平台数据，大厂动态，社区热点，为游戏开发者和发行商提供决策参考。">
<meta name="keywords" content="游戏行业，游戏新闻，IT 动态，新游推荐，Steam，独立游戏">
```

#### 分类页（游戏动态）
```html
<title>游戏行业动态 - Gaming Digest | 游戏产业新闻与市场分析</title>
<meta name="description" content="每日更新游戏行业动态，包括 Steam 平台数据、游戏市场分析、大厂动向、社区热点。为游戏从业者和爱好者提供第一手资讯。">
<meta name="keywords" content="游戏新闻，游戏行业，Steam 数据，游戏市场，游戏分析">
<link rel="canonical" href="https://daily.aippletree.com/game/page/1">
```

#### 分类页（IT 动态）
```html
<title>IT 行业动态 - Gaming Digest | 科技资讯与技术趋势</title>
<meta name="description" content="精选 IT 行业动态，涵盖 InfoQ、Hacker News 等资深媒体内容。关注技术趋势、大厂动态、开源项目，为技术人员提供高质量资讯。">
<meta name="keywords" content="IT 新闻，科技资讯，技术趋势，InfoQ，Hacker News">
<link rel="canonical" href="https://daily.aippletree.com/it/page/1">
```

#### 分类页（新游发现）
```html
<title>新游发现 - Gaming Digest | 独立游戏与新游戏推荐</title>
<meta name="description" content="每日发现潜力新游，涵盖 Steam、itch.io 平台新作。提供游戏评测、玩法分析、发行信息，帮助玩家发现好游戏。">
<meta name="keywords" content="新游戏，独立游戏，游戏推荐，Steam 新游，itch.io">
<link rel="canonical" href="https://daily.aippletree.com/new-games/page/1">
```

### 2. 结构化数据（Schema.org）

#### 网站结构化
```json
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "name": "Gaming Digest",
  "url": "https://daily.aippletree.com",
  "description": "每日游戏行业资讯精选",
  "potentialAction": {
    "@type": "SearchAction",
    "target": "https://daily.aippletree.com/search?q={search_term_string}",
    "query-input": "required name=search_term_string"
  }
}
```

#### 文章结构化
```json
{
  "@context": "https://schema.org",
  "@type": "NewsArticle",
  "headline": "文章标题",
  "datePublished": "2026-03-03",
  "dateModified": "2026-03-03",
  "author": {
    "@type": "Organization",
    "name": "Gaming Digest"
  },
  "publisher": {
    "@type": "Organization",
    "name": "Gaming Digest",
    "logo": {
      "@type": "ImageObject",
      "url": "https://daily.aippletree.com/logo.png"
    }
  },
  "description": "文章描述",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://daily.aippletree.com/posts/2026-03-03-gaming-daily/"
  }
}
```

### 3. 内部链接优化

#### 导航菜单
```html
<nav>
  <a href="/">首页</a>
  <a href="/game/page/1">游戏动态</a>
  <a href="/it/page/1">IT 动态</a>
  <a href="/new-games/page/1">新游发现</a>
</nav>
```

#### 面包屑导航
```html
<nav aria-label="breadcrumb">
  <ol>
    <li><a href="/">首页</a></li>
    <li><a href="/game/page/1">游戏动态</a></li>
    <li>当前页：2</li>
  </ol>
</nav>
```

#### 相关文章推荐
```html
<section>
  <h3>相关阅读</h3>
  <ul>
    <li><a href="/posts/xxx">相关文章 1</a></li>
    <li><a href="/posts/yyy">相关文章 2</a></li>
  </ul>
</section>
```

### 4. Sitemap 优化

**Sitemap 结构**:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <!-- 首页 -->
  <url>
    <loc>https://daily.aippletree.com/</loc>
    <lastmod>2026-03-03</lastmod>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>
  
  <!-- 分类页 -->
  <url>
    <loc>https://daily.aippletree.com/game/page/1</loc>
    <lastmod>2026-03-03</lastmod>
    <changefreq>daily</changefreq>
    <priority>0.8</priority>
  </url>
  
  <!-- 文章页 -->
  <url>
    <loc>https://daily.aippletree.com/posts/2026-03-03-gaming-daily/</loc>
    <lastmod>2026-03-03</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.6</priority>
  </url>
</urlset>
```

**自动生成 Sitemap**:
```bash
npm install astro-sitemap
```

```javascript
// astro.config.mjs
import sitemap from '@astrojs/sitemap';

export default {
  site: 'https://daily.aippletree.com',
  integrations: [sitemap()],
};
```

### 5. Robots.txt

```txt
User-agent: *
Allow: /

# Sitemap
Sitemap: https://daily.aippletree.com/sitemap-index.xml

# 禁止抓取（如有）
Disallow: /admin/
Disallow: /api/
```

### 6. 性能优化

#### 图片优化
- ✅ WebP 格式
- ✅ Lazy loading
- ✅ 适当尺寸
- ✅ 压缩质量

#### 代码优化
- ✅ CSS 内联关键样式
- ✅ JS 异步加载
- ✅ 减少 HTTP 请求
- ✅ 使用 CDN

#### 缓存策略
- ✅ 静态资源长期缓存
- ✅ HTML 短期缓存
- ✅ Service Worker（可选）

---

## 📊 实施计划

### 第一阶段：基础架构（1-2 小时）
- [ ] 创建分类页面目录结构
- [ ] 实现动态路由生成
- [ ] 配置 301 重定向
- [ ] 测试路由功能

### 第二阶段：SEO 优化（2-3 小时）
- [ ] 优化页面 Meta 标签
- [ ] 添加结构化数据
- [ ] 实现面包屑导航
- [ ] 生成 Sitemap
- [ ] 配置 Robots.txt

### 第三阶段：内容优化（1-2 小时）
- [ ] 优化现有文章分类
- [ ] 添加内部链接
- [ ] 相关文章推荐
- [ ] 图片 Alt 标签优化

### 第四阶段：测试验证（1 小时）
- [ ] 本地构建测试
- [ ] 部署测试
- [ ] SEO 工具验证
- [ ] 性能测试

---

## 🧪 测试与验证

### SEO 工具
- [ ] Google Search Console 提交
- [ ] Bing Webmaster Tools 提交
- [ ] 结构化数据测试工具
- [ ] Mobile-Friendly Test

### 性能工具
- [ ] Lighthouse 性能测试
- [ ] PageSpeed Insights
- [ ] WebPageTest

### 监控指标
- 有机搜索流量
- 关键词排名
- 页面收录数量
- 点击率（CTR）
- 跳出率
- 平均停留时间

---

## 📈 预期效果

**短期（1-2 周）**:
- ✅ 分类页面被搜索引擎索引
- ✅ 网站结构更清晰
- ✅ 用户体验改善

**中期（1-2 月）**:
- ✅ 长尾关键词排名提升
- ✅ 有机流量增长 20-30%
- ✅ 页面停留时间增加

**长期（3-6 月）**:
- ✅ 核心关键词进入前 10
- ✅ 品牌知名度提升
- ✅ 稳定有机流量来源

---

*最后更新：2026-03-03 09:31*
