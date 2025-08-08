# MCP服务配置规范

## 语言偏好设置

### 回答语言
- 所有回答都使用中文
- 代码注释使用中文
- 文档说明使用中文
- 错误信息使用中文

### 资料检索偏好
- 优先使用英文官方文档
- 技术资料以英文为准
- API文档查阅英文版本
- 但将检索结果翻译为中文回答

## MCP服务配置

### 1. 创建工作区级别MCP配置

在项目根目录创建 `.kiro/settings/mcp.json` 文件：

```json
{
  "mcpServers": {
    "flutter-docs": {
      "command": "uvx",
      "args": ["flutter-documentation-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR"
      },
      "disabled": false,
      "autoApprove": ["search_documentation", "get_api_reference"]
    },
    "dart-docs": {
      "command": "uvx", 
      "args": ["dart-documentation-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR"
      },
      "disabled": false,
      "autoApprove": ["search_dart_api", "get_package_info"]
    },
    "web-search": {
      "command": "uvx",
      "args": ["web-search-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR",
        "SEARCH_LANGUAGE": "en"
      },
      "disabled": false,
      "autoApprove": ["web_search"]
    }
  }
}
```

### 2. 推荐的MCP服务器

#### Flutter/Dart开发相关
- **flutter-docs**: Flutter官方文档检索
- **dart-docs**: Dart语言文档检索  
- **pub-dev**: Pub.dev包管理检索
- **github-search**: GitHub代码搜索

#### 通用开发工具
- **web-search**: 网络搜索（设置为英文优先）
- **stackoverflow**: Stack Overflow问答检索
- **mdn-docs**: Web技术文档检索

### 3. 配置步骤

#### 步骤1: 安装uv和uvx
```bash
# macOS使用Homebrew安装
brew install uv

# 或者使用pip安装
pip install uv
```

#### 步骤2: 创建MCP配置文件
```bash
# 创建配置目录
mkdir -p .kiro/settings

# 创建MCP配置文件
touch .kiro/settings/mcp.json
```

#### 步骤3: 配置MCP服务器
将上面的JSON配置复制到 `.kiro/settings/mcp.json` 文件中。

#### 步骤4: 重启Kiro或重新连接MCP服务器
- 在Kiro中打开命令面板
- 搜索"MCP"相关命令
- 选择"重新连接MCP服务器"

### 4. 使用MCP服务

#### 搜索Flutter文档
```
请使用MCP搜索Flutter中StatefulWidget的生命周期方法
```

#### 搜索Dart API
```
请使用MCP查找Dart中Future的使用方法
```

#### 搜索包信息
```
请使用MCP搜索provider包的最新版本和使用方法
```

### 5. 自动批准设置

在 `autoApprove` 数组中添加常用的MCP工具名称，这样就不需要每次手动批准：

```json
"autoApprove": [
  "search_documentation",
  "get_api_reference", 
  "web_search",
  "search_dart_api",
  "get_package_info"
]
```

### 6. 环境变量配置

#### 搜索语言偏好
```json
"env": {
  "SEARCH_LANGUAGE": "en",
  "RESULT_LANGUAGE": "zh-CN",
  "FASTMCP_LOG_LEVEL": "ERROR"
}
```

#### API密钥配置（如需要）
```json
"env": {
  "GOOGLE_API_KEY": "your-api-key",
  "GITHUB_TOKEN": "your-github-token"
}
```

### 7. 故障排除

#### 检查MCP服务器状态
- 打开Kiro的MCP服务器面板
- 查看服务器连接状态
- 检查错误日志

#### 常见问题
1. **uvx命令未找到**: 确保已安装uv包管理器
2. **服务器连接失败**: 检查网络连接和防火墙设置
3. **权限问题**: 确保有足够权限执行uvx命令

### 8. 最佳实践

#### 配置优化
- 只启用需要的MCP服务器
- 设置合适的日志级别
- 定期更新MCP服务器版本

#### 使用技巧
- 明确指定要使用的MCP服务
- 提供具体的搜索关键词
- 结合项目上下文进行搜索

## 项目特定配置

### Flutter项目推荐配置
```json
{
  "mcpServers": {
    "flutter-docs": {
      "command": "uvx",
      "args": ["flutter-documentation-mcp-server@latest"],
      "disabled": false,
      "autoApprove": ["search_flutter_docs", "get_widget_info"]
    },
    "pub-dev": {
      "command": "uvx",
      "args": ["pub-dev-mcp-server@latest"], 
      "disabled": false,
      "autoApprove": ["search_packages", "get_package_details"]
    }
  }
}
```

### 开发环境配置
- 开发环境启用详细日志
- 生产环境关闭调试信息
- 根据团队需求配置自动批准列表