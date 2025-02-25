@echo off
chcp 65001 >nul
REM 脚本名称: run_mkdocs.bat
REM 描述: 激活虚拟环境并启动 MkDocs 本地服务器

echo 正在激活虚拟环境...
call .\ENV_DIR\Scripts\activate
if %ERRORLEVEL% neq 0 (
    echo 错误: 虚拟环境激活失败！
    pause
    exit /b 1
)

echo 正在启动 MkDocs 本地服务器...
mkdocs serve
if %ERRORLEVEL% neq 0 (
    echo 错误: MkDocs 启动失败！
    pause
    exit /b 1
)

echo MkDocs 本地服务器已启动！
pause
