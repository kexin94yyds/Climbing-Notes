# 🚨 快速问题排除参考卡

## 常见错误和解决方法

| 错误信息 | 原因 | 快速解决 |
|---------|------|----------|
| `no such column: ZPUBLISHER` | 数据库版本不兼容 | ✅ 已修复：脚本自动检测结构 |
| `no such column: ZANNOTATIONCOLOR` | 注释表结构差异 | ✅ 已修复：动态查询构建 |
| `找不到 Books 数据库文件` | Books 未运行/路径变化 | 1. 启动 Books 应用<br>2. 添加一本测试书籍 |
| `没有找到任何书籍` | 数据库为空/权限问题 | 1. 确认 Books 中有书籍<br>2. 重启 Books 应用 |
| `高亮/笔记数量: 0` | 未添加高亮/同步问题 | 1. 在 Books 中添加测试高亮<br>2. 等待 iCloud 同步 |

## 🔧 一键检查命令

```bash
# 检查脚本状态
python3 books_highlights_extractor.py --list

# 检查数据库是否存在
ls -la ~/Library/Containers/com.apple.iBooksX/Data/Documents/BKLibrary/
ls -la ~/Library/Containers/com.apple.iBooksX/Data/Documents/AEAnnotation/

# 快速导出测试
python3 books_highlights_extractor.py --format markdown
```

## 📞 紧急恢复步骤

1. **重启 Books 应用**
2. **运行便捷脚本**: `./extract_books_highlights.sh`
3. **选择操作 1** 检查书籍列表
4. **如果正常则选择操作 2** 导出高亮

## 🆘 最后手段

如果脚本完全无法工作：
- 使用 BooknoteWorthy 网页版：https://oliwang.github.io/BooknoteWorthy/
- 下载 Note Exporter Mac 应用

**记住：** 详细问题查看 `TROUBLESHOOTING.md` 文档 