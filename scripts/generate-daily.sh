#!/bin/bash
# Gaming Digest 内容生成脚本
# 生成每日报告并推送到 Git

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
DATE=$(date +%Y-%m-%d)
POSTS_DIR="$PROJECT_DIR/src/content/posts"
POST_FILE="$POSTS_DIR/$DATE-daily.md"

echo "🎮 Gaming Digest 内容生成 ($DATE)"
echo ""

# 检查是否已存在今日报告
if [ -f "$POST_FILE" ]; then
    echo "⚠️  今日报告已存在，跳过生成"
    exit 0
fi

# 生成报告内容
echo "📝 生成今日报告..."

cat > "$POST_FILE" << 'EOF'
---
title: "Gaming Digest 每日报告"
publishDate: DATE_PLACEHOLDER
description: "每日游戏行业资讯精选"
tags: ["每日报告", "游戏行业"]
source: "Gaming Digest"
---

## 📰 海外媒体头条

### Game Developer
- 待更新

### PC Gamer
- 待更新

### Rock Paper Shotgun
- 待更新

---

## 🎮 平台数据

### itch.io 热门
- 待更新

---

## 🏢 大厂动态

_今日暂无重大政策变化_

---

## 💬 社区热点

### Hacker News
- 待更新

---

## 📅 明日关注

- 关注各大厂商新品发布
- 平台政策更新

---

*本报告由 AI 自动生成*
EOF

# 替换日期占位符
sed -i '' "s/DATE_PLACEHOLDER/$(date +%Y-%m-%d)/" "$POST_FILE"

echo "✅ 报告生成完成：$POST_FILE"
echo ""

# Git 提交
cd "$PROJECT_DIR"

if git status --porcelain | grep -q .; then
    echo "📦 提交更改..."
    git add .
    git commit -m "chore: 添加 $DATE 每日报告 [skip ci]"
    echo "✅ 提交完成"
    echo ""
    echo "🚀 推送到远程仓库..."
    git push origin main
    echo "✅ 推送完成"
    echo ""
    echo "☁️  Cloudflare Pages 将自动构建部署"
else
    echo "ℹ️  没有更改需要提交"
fi

echo ""
echo "✨ 完成！"
