# Hugo 文章加密功能使用指南

## 概述

这个Hugo博客已经集成了强大的文章加密功能，使用[HugoMods Encrypt](https://hugomods.com/docs/content/encrypt/)模块。该功能使用AES-256-GCM加密算法，提供客户端加密解密，确保内容安全。

## 功能特性

- 🔐 **AES-256-GCM加密**：采用军用级加密标准
- 🎨 **美观的UI界面**：现代化的密码输入界面
- 📱 **移动端适配**：完美支持移动设备
- 🔄 **记住密码**：会话期间记住密码，无需重复输入
- ⚡ **SEO友好**：只加密指定内容，其他内容正常被搜索引擎索引
- 🌐 **部分加密**：支持在同一篇文章中混合公开和加密内容

## 配置

### 默认密码设置

在 `hugo.toml` 中配置默认密码：

```toml
[params.encrypt]
  password = "geekrun123"  # 默认密码
  storage = "session"      # 密码存储方式：session 或 local
```

## 使用方法

### 1. 使用默认密码加密

```markdown
{{< encrypt >}}

这里是需要加密的内容，使用配置文件中的默认密码。

## 加密的标题

这是加密的段落内容。

{{< /encrypt >}}
```

### 2. 使用自定义密码加密

```markdown
{{< encrypt "自定义密码" >}}

这里是需要加密的内容，使用自定义密码。

{{< /encrypt >}}
```

### 3. 在同一篇文章中使用多个加密区块

```markdown
---
title: "混合内容示例"
---

这是公开内容，所有人都能看到。

{{< encrypt >}}
这是使用默认密码的加密内容。
{{< /encrypt >}}

这是另一段公开内容。

{{< encrypt "特殊密码" >}}
这是使用特殊密码的加密内容。
{{< /encrypt >}}

最后的公开内容。
```

## 部署流程

### 本地开发和测试

1. **构建和加密**：
   ```bash
   # 使用提供的脚本
   ./scripts/build-and-encrypt.sh
   
   # 或手动执行
   hugo mod get github.com/hugomods/encrypt
   hugo --gc --minify
   go install github.com/hugomods/encrypt/commands/encrypt@latest
   $HOME/go/bin/encrypt
   ```

2. **本地预览**：
   ```bash
   # 使用Python服务器
   python -m http.server -d public 8080
   
   # 或使用PHP（如果已安装）
   php -S localhost:8080 -t public
   ```

### GitHub Actions 自动部署

GitHub Actions工作流已自动配置加密功能：

1. **构建Hugo站点**
2. **安装Go和加密工具**
3. **应用内容加密**
4. **部署到GitHub Pages**

无需额外配置，推送到main分支即可自动部署。

## 安全注意事项

⚠️ **重要安全提醒**：

1. **保持源码私密**：确保包含加密内容的源码仓库设为私有
2. **密码强度**：使用强密码，避免简单密码
3. **密码分享**：通过安全渠道分享密码，不要在公开场所泄露
4. **定期更新**：定期更新密码，特别是在密码可能泄露时

## 密码存储选项

- **session**（推荐）：密码仅在当前浏览器会话中保存，关闭浏览器后需重新输入
- **local**：密码保存在本地存储中，下次访问时无需重新输入

## 故障排除

### 常见问题

1. **加密不生效**：
   - 确保Hugo模块正确导入
   - 检查shortcode语法是否正确
   - 确认加密工具已正确安装

2. **GitHub Actions失败**：
   - 检查Go版本兼容性
   - 确认模块导入配置正确

3. **本地测试问题**：
   - 必须使用HTTP服务器，不能直接打开HTML文件
   - 确保已运行加密命令

### 获取帮助

如遇到问题，可以：
- 查看[HugoMods文档](https://hugomods.com/docs/content/encrypt/)
- 检查GitHub Actions构建日志
- 确认所有依赖正确安装

## 示例

查看 `content/posts/private-sample.md` 文件中的完整示例，了解如何在实际文章中使用加密功能。

---

*配置完成后，你就可以在博客中安全地分享私人内容了！🎉*
