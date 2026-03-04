#!/bin/bash
# 自动化部署脚本 - 用于 Cron 任务
# 用法：./auto-deploy.sh [文章文件名]

set -e

# 配置
WORKSPACE_DIR="/Users/somebody/.openclaw/workspace/projects/gaming-digest"
SSH_KEY="/Users/somebody/.openclaw/workspace/.ssh/gaming-digest"
CLOUDFLARE_API_TOKEN="o2FDEOhRfzjnCj6s6nAudrnmclx-JmWhQM_p-mgf"
CLOUDFLARE_ACCOUNT_ID="09ebba273ec7e033e136395753ccec14"
PROJECT_NAME="ai-gaming-digest"

echo "🚀 开始自动化部署..."
echo "===================="
echo ""

# 进入工作目录
cd "$WORKSPACE_DIR"
echo "📁 工作目录：$WORKSPACE_DIR"

# 步骤 1: Git 推送
echo ""
echo "【步骤 1】Git 推送..."
export GIT_SSH_COMMAND="ssh -i $SSH_KEY -o StrictHostKeyChecking=no"
git add .
if git diff-index --quiet HEAD; then
  echo "⚠️  没有更改需要提交"
else
  git commit -m "chore: 自动提交 [skip ci]"
  echo "✅ Git Commit 完成"
fi

git push origin main
echo "✅ Git Push 完成"

# 步骤 2: 构建
echo ""
echo "【步骤 2】网站构建..."
npm run build
echo "✅ 构建完成"

# 步骤 3: 部署到 Cloudflare
echo ""
echo "【步骤 3】Cloudflare 部署..."
export CLOUDFLARE_API_TOKEN
export CLOUDFLARE_ACCOUNT_ID
npx wrangler pages deploy dist --project-name="$PROJECT_NAME" --commit-dirty=true
echo "✅ 部署完成"

echo ""
echo "===================="
echo "🎉 部署成功完成！"
echo "🌐 网站地址：https://daily.aippletree.com"
echo ""
