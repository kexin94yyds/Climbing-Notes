-- 将 Books 高亮导入到备忘录的 AppleScript
-- 使用前先运行 Python 脚本导出 Markdown 文件

on run
    -- 设置文件夹路径
    set booksHighlightsFolder to (path to desktop as string) & "Books_Highlights:"
    
    -- 检查文件夹是否存在
    try
        set folderExists to booksHighlightsFolder as alias
    on error
        display dialog "找不到 Books_Highlights 文件夹！请先运行 Python 脚本导出高亮。" buttons {"确定"} default button 1
        return
    end try
    
    -- 创建备忘录文件夹（如果不存在）
    tell application "Notes"
        activate
        try
            set booksFolder to folder "书籍高亮"
        on error
            set booksFolder to make new folder with properties {name:"书籍高亮"}
        end try
    end tell
    
    -- 获取所有 Markdown 文件
    tell application "Finder"
        set markdownFiles to every file of folder booksHighlightsFolder whose name extension is "md"
    end tell
    
    if (count of markdownFiles) = 0 then
        display dialog "没有找到 Markdown 文件！" buttons {"确定"} default button 1
        return
    end if
    
    -- 显示进度对话框
    set totalFiles to count of markdownFiles
    set processedFiles to 0
    
    -- 逐一处理每个文件
    repeat with aFile in markdownFiles
        set processedFiles to processedFiles + 1
        
        -- 读取文件内容
        set fileContent to read aFile as «class utf8»
        
        -- 获取文件名（去掉扩展名）
        set fileName to name of aFile
        set fileName to text 1 thru ((offset of "." in fileName) - 1) of fileName
        
        -- 创建备忘录
        tell application "Notes"
            set newNote to make new note at booksFolder with properties {body:fileContent}
        end tell
        
        -- 显示进度
        if processedFiles mod 5 = 0 then
            display notification "已导入 " & processedFiles & " / " & totalFiles & " 本书籍" with title "导入进度"
        end if
    end repeat
    
    -- 完成提示
    display notification "成功导入 " & totalFiles & " 本书籍的高亮！" with title "导入完成"
    display dialog "导入完成！共导入了 " & totalFiles & " 本书籍的高亮笔记到备忘录。" buttons {"打开备忘录", "确定"} default button 1
    
    if button returned of result is "打开备忘录" then
        tell application "Notes"
            activate
            show booksFolder
        end tell
    end if
end run 