# 📚 Mac Books 高亮提取器

一键提取 Mac Books 应用中的所有高亮和笔记，支持多种导出格式。

## ⚡ 快速使用（5分钟上手）

### 这是什么？
一个脚本，可以把你Mac Books应用里的所有高亮和笔记导出成文件。

### 怎么用？
1. **获取脚本** - 下载这3个文件到同一文件夹：
   - `extract_books_highlights.sh`
   - `books_highlights_extractor.py` 
   - `import_to_notes.applescript`

2. **一键设置**（只需要做一次）：
   ```bash
   echo 'alias books="cd /脚本文件夹路径 && ./extract_books_highlights.sh"' >> ~/.zshrc
   source ~/.zshrc
   ```
   > 将 `/脚本文件夹路径` 替换为实际路径

3. **开始使用**：
   在终端输入 `books` 就可以了！

### 常用功能
- **选项1** - 列出所有书籍
- **选项2** - 导出所有高亮为Markdown文件  
- **选项6** - 搜索单本书籍的高亮

---

## 🎯 详细功能特点

- ✅ **提取所有书籍高亮和笔记** - 从Mac Books应用本地数据库读取
- ✅ **多种导出格式** - 支持Markdown、CSV格式
- ✅ **单书籍查看** - 支持书名/关键词/ID搜索
- ✅ **自动导入备忘录** - 可选择自动导入到Mac备忘录应用
- ✅ **完全本地操作** - 无需网络，保护隐私

## 📋 系统要求

- **macOS** 系统
- **Python 3** （通常Mac自带）
- **Mac Books 应用** 并且有书籍和高亮

## 📖 完整功能说明

运行脚本后会看到6个选项：

1. **列出所有书籍** - 查看您的完整书库，包含书籍ID
2. **导出为 Markdown** - 每本书一个.md文件，格式美观
3. **导出为 CSV** - 电子表格格式，便于数据分析
4. **导出两种格式** - 同时导出MD和CSV两种格式
5. **自动导入备忘录** - 导出后自动导入Mac备忘录应用
6. **显示单个书籍** - 搜索查看特定书籍的高亮

## 🔍 单书籍搜索功能

支持三种灵活的搜索方式：
- **完整书名**：`七年就是一辈子`
- **关键词搜索**：`七年`、`Creative`
- **书籍ID精确查找**：先用选项1查看完整ID列表

## 📁 文件结构说明

脚本包含3个核心文件：
- `extract_books_highlights.sh` - 主脚本（交互式菜单）
- `books_highlights_extractor.py` - Python核心程序
- `import_to_notes.applescript` - 自动导入备忘录脚本

## 🎛️ 替代使用方法

如果不想设置别名，也可以手动运行：
```bash
cd /脚本文件夹路径
./extract_books_highlights.sh
```

## ❓ 常见问题解答

**Q: 脚本能读取哪些书籍？**  
A: Mac Books应用中的所有书籍，包括购买的、导入的PDF/EPUB、免费书籍等

**Q: 需要网络连接吗？**  
A: 不需要，完全读取本地数据库，离线可用

**Q: 数据安全性如何？**  
A: 完全本地操作，不上传任何数据，保护您的隐私

**Q: 支持其他设备的高亮吗？**  
A: 支持！如果开启iCloud Books同步，iPhone/iPad的高亮也会被读取

**Q: 导出的文件在哪里？**  
A: 默认在脚本文件夹下的 `Books_Highlights` 文件夹中

## 🆘 获取帮助

如果遇到问题，可以：
1. **复制这个README** 给AI助手（ChatGPT、Claude等）
2. **询问**："我想使用这个Mac Books高亮提取脚本，请帮我解决XXX问题"
3. **描述具体现象**，AI会根据文档给出解决方案

---

💡 **新手提示**：首次使用建议先选择"列出所有书籍"查看效果  
🚀 **进阶用户**：可以直接使用Python脚本的命令行参数进行批量操作
