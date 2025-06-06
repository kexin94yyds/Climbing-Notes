# Mac Books 高亮提取 - 问题排除文档

## 📋 文档说明

本文档记录了在使用 Mac Books 高亮提取脚本过程中遇到的问题、原因分析和解决方案，供将来参考。

**最后更新：** 2025-01-25  
**维护者：** Apple用户

---

## 🔧 问题记录

### 问题 #1：数据库结构兼容性问题

**📅 时间：** 2025-01-25  
**🔍 问题描述：**
- 脚本运行时出现 `no such column: ZPUBLISHER` 错误
- 注释查询时出现 `no such column: ZANNOTATIONCOLOR` 错误
- 导致无法正确读取书籍信息和高亮笔记

**💡 原因分析：**
1. **Apple Books 数据库版本差异**：
   - 不同版本的 macOS 和 Books 应用使用不同的数据库结构
   - 较新或较旧版本可能缺少某些字段
   - 数据库架构随系统更新而变化

2. **硬编码字段查询问题**：
   - 原始脚本假设所有字段都存在
   - 没有动态检测数据库结构
   - 缺少容错机制

**✅ 解决方案：**

#### 1. 动态检测数据库结构
```python
# 检查表结构
cursor.execute("PRAGMA table_info(ZBKLIBRARYASSET)")
columns = [column[1] for column in cursor.fetchall()]

# 构建动态查询
base_columns = ['ZASSETID', 'ZTITLE', 'ZAUTHOR']
optional_columns = ['ZGENRE', 'ZPUBLISHER', 'ZPUBLISHDATE', 'ZLASTOPENDATE']

select_columns = base_columns.copy()
for col in optional_columns:
    if col in columns:
        select_columns.append(col)
```

#### 2. 添加 NULL 占位符
```python
# 为不存在的列添加 NULL 占位符
for col in optional_columns:
    if col in columns:
        select_columns.append(col)
    else:
        select_columns.append('NULL as ' + col)
```

#### 3. 修复数据解析
```python
# 动态解析结果，适应不同列数
asset_id = book[0] if len(book) > 0 else None
title = book[1] if len(book) > 1 else "未知书名"
author = book[2] if len(book) > 2 else None
```

**📊 效果：**
- ✅ 成功兼容不同版本的数据库
- ✅ 正确读取 81 本书籍信息
- ✅ 成功提取 3,314 个高亮笔记

---

### 问题 #2：从 Books 拖出的 EPUB 文件与原版不同

**📅 时间：** 2025-01-25  
**🔍 问题描述：**
- 从 Books 应用拖出的 EPUB 文件缺少章节信息
- 文件结构与网页下载的原版 EPUB 不同
- 影响章节切分功能

**💡 原因分析：**
1. **Books 应用文件处理**：
   - Books 导入时会压缩和重新打包 EPUB
   - 可能简化或移除某些元数据
   - 云端同步可能导致信息丢失

2. **DRM 和版权保护**：
   - Apple 的数字版权管理
   - 防止完整文件提取

3. **格式转换损失**：
   - 内部存储格式与标准 EPUB 不同
   - 导出时可能丢失结构信息

**✅ 解决方案：**

#### 方案一：直接从 Books 数据库提取（推荐）
- ✅ 使用本脚本直接读取 SQLite 数据库
- ✅ 获得最完整的高亮和笔记信息
- ✅ 保留时间戳和元数据

#### 方案二：使用原版 EPUB 文件
- 从原始来源重新下载 EPUB
- 用于章节分析和结构处理
- 结合数据库提取的高亮信息

#### 方案三：替代工具
- BooknoteWorthy (网页版)
- Note Exporter (Mac 应用)
- apple_eater (Python 脚本)

**📊 效果：**
- ✅ 成功提取《The Creative Act》374 个高亮笔记
- ✅ 保留完整的笔记内容和时间信息
- ✅ 生成格式化的 Markdown 文件

---

## 🛠️ 通用解决方法

### 1. 数据库兼容性问题
**症状：** `no such column` 错误
**解决步骤：**
1. 检查数据库是否存在
2. 使用 `PRAGMA table_info()` 检查表结构
3. 动态构建查询语句
4. 添加容错机制

### 2. 权限问题
**症状：** 无法访问数据库文件
**解决步骤：**
1. 确保 Books 应用已运行
2. 检查文件权限
3. 尝试重新启动 Books 应用
4. 检查 System Integrity Protection (SIP) 设置

### 3. 空结果问题
**症状：** 找不到书籍或高亮
**解决步骤：**
1. 确认已在 Books 中添加高亮
2. 检查 iCloud 同步状态
3. 尝试添加测试高亮
4. 重启 Books 应用等待同步

---

## 🔍 调试技巧

### 1. 数据库结构检查
```bash
# 检查数据库表
sqlite3 ~/Library/Containers/com.apple.iBooksX/Data/Documents/BKLibrary/*.sqlite ".tables"

# 检查表结构
sqlite3 ~/Library/Containers/com.apple.iBooksX/Data/Documents/BKLibrary/*.sqlite ".schema ZBKLIBRARYASSET"
```

### 2. 测试查询
```sql
-- 检查书籍数量
SELECT COUNT(*) FROM ZBKLIBRARYASSET WHERE ZTITLE IS NOT NULL;

-- 检查高亮数量
SELECT COUNT(*) FROM ZAEANNOTATION WHERE ZANNOTATIONDELETED = 0;
```

### 3. 日志分析
```bash
# 运行脚本并保存详细日志
python3 books_highlights_extractor.py --list > debug.log 2>&1
```

---

## 📚 相关资源

### 数据库位置
```
# Books 数据库
~/Library/Containers/com.apple.iBooksX/Data/Documents/BKLibrary/

# 注释数据库  
~/Library/Containers/com.apple.iBooksX/Data/Documents/AEAnnotation/

# 备用位置（旧版本）
~/Library/Containers/com.apple.BKAgentService/Data/Documents/iBooks/
```

### 替代工具
1. **BooknoteWorthy** - https://oliwang.github.io/BooknoteWorthy/
2. **Note Exporter** - https://github.com/Alexs7zzh/Note-Exporter
3. **apple_eater** - https://github.com/yirogue/apple_eater

### 备份建议
```bash
# 备份 Books 数据
cp -r ~/Library/Containers/com.apple.iBooksX/ ~/Desktop/Books_Backup/
```

---

## 📝 添加新问题

**格式模板：**
```markdown
### 问题 #X：问题标题

**📅 时间：** YYYY-MM-DD  
**🔍 问题描述：**
- 详细描述问题现象
- 错误信息
- 影响范围

**💡 原因分析：**
1. 主要原因
2. 次要原因

**✅ 解决方案：**
1. 步骤一
2. 步骤二

**📊 效果：**
- 解决结果
```

---

## 🔄 版本历史

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| 1.0 | 2025-01-25 | 初始版本，记录数据库兼容性问题 |

---

**💡 提示：** 遇到新问题时，请按照模板格式添加到本文档，并更新版本历史。 