# 🚀 快速入门指南

## 最简单的使用方法

### 方法一：使用便捷脚本（推荐）

1. **运行便捷脚本**
   ```bash
   ./extract_books_highlights.sh
   ```

2. **选择操作 5**（导出并自动导入到备忘录）

3. **完成！** 你的所有书籍高亮将自动出现在备忘录的"书籍高亮"文件夹中

### 方法二：使用现成工具

#### BooknoteWorthy（网页版，最简单）
1. 访问：https://oliwang.github.io/BooknoteWorthy/
2. 上传数据库文件（脚本会提示位置）
3. 在线处理并下载结果

#### Note Exporter（Mac 应用）
1. 下载：https://github.com/Alexs7zzh/Note-Exporter
2. 安装并运行应用
3. 选择要导出的书籍

### 方法三：直接使用 Python 脚本

```bash
# 导出所有高亮
python3 books_highlights_extractor.py

# 列出所有书籍
python3 books_highlights_extractor.py --list
```

## 导出结果位置

- **Markdown 文件**：`Books_Highlights/` 文件夹
- **CSV 文件**：当前目录下的 `books_highlights.csv`
- **备忘录**：备忘录应用的"书籍高亮"文件夹

## 颜色说明

生成的 Markdown 文件中会用表情符号显示高亮颜色：
- 🟡 黄色高亮
- 🟢 绿色高亮
- 🔵 蓝色高亮
- 🩷 粉色高亮
- 🟣 紫色高亮
- ⚫ 灰色高亮

## 常见问题

### 找不到数据库？
确保你已经：
1. 在 Books 应用中阅读过书籍
2. 添加过高亮或笔记
3. Books 应用已经同步数据

### 没有高亮内容？
检查：
1. 是否真的添加过高亮
2. 是否使用 iCloud 同步（可能需要等待同步完成）
3. 重新打开 Books 应用并添加一个测试高亮

### 自动导入失败？
可以手动导入：
1. 打开 `Books_Highlights` 文件夹
2. 打开任意 `.md` 文件
3. 复制全部内容
4. 在备忘录中新建笔记并粘贴

## 技术原理

脚本通过读取 Books 应用的 SQLite 数据库文件来提取高亮和笔记：
- 书籍信息：`BKLibrary.sqlite`
- 注释信息：`AEAnnotation.sqlite`

所有处理都在本地进行，不会上传任何数据。 