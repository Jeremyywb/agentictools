#!/bin/bash

# ===== Codex 专用 env 文件 =====
ENV_FILE="a.env"

# ===== 加载环境变量 =====
if [ -f "$ENV_FILE" ]; then
    echo "Loading Codex environment from $ENV_FILE ..."

    while IFS= read -r line; do
        # 跳过注释 & 空行
        if [[ ! "$line" =~ ^# ]] && [[ -n "$line" ]]; then
            export "$line"
        fi
    done < "$ENV_FILE"

    echo "Codex environment loaded."
else
    echo "Error: $ENV_FILE not found!"
    exit 1
fi

# ===== 启动 Codex CLI =====
echo "Starting Codex..."
codex