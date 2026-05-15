#!/bin/bash

clear

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m'

echo -e "${GREEN}"
echo "══════════════════════════════════════"
echo "     SRC HUB TOOL - INSTALLATION"
echo "══════════════════════════════════════"
echo -e "${NC}"

# Detect environment
if [ -d "/data/data/com.termux" ]; then
    IS_TERMUX=true
else
    IS_TERMUX=false
fi

# System update
echo -e "${CYAN}[*] Updating packages...${NC}"
if [ "$IS_TERMUX" = true ]; then
    pkg update -y && pkg upgrade -y
else
    apt update -y && apt upgrade -y
fi

# Python install
echo -e "${CYAN}[*] Installing Python...${NC}"
if [ "$IS_TERMUX" = true ]; then
    pkg install python python-pip -y
else
    apt install python3 python3-pip -y
fi

# System tools
echo -e "${CYAN}[*] Installing system tools...${NC}"
if [ "$IS_TERMUX" = true ]; then
    pkg install zip unzip clang rust binutils -y
else
    apt install zip unzip build-essential python3-dev libffi-dev libssl-dev -y
fi

# Upgrade pip
echo -e "${CYAN}[*] Upgrading pip...${NC}"
if [ "$IS_TERMUX" = true ]; then
    pip install --upgrade pip setuptools wheel
else
    pip3 install --upgrade pip setuptools wheel
fi

# Python packages
echo -e "${CYAN}[*] Installing Python packages...${NC}"
echo -e "${YELLOW}  ► requests${NC}"
pip install requests --no-cache-dir 2>/dev/null || pip3 install requests --no-cache-dir

echo -e "${YELLOW}  ► pycryptodome${NC}"
pip install pycryptodome --no-cache-dir 2>/dev/null || pip3 install pycryptodome --no-cache-dir

echo -e "${YELLOW}  ► gmalg${NC}"
pip install gmalg --no-cache-dir 2>/dev/null || pip3 install gmalg --no-cache-dir

echo -e "${YELLOW}  ► zstandard${NC}"
pip install zstandard --no-cache-dir 2>/dev/null || pip3 install zstandard --no-cache-dir

echo -e "${YELLOW}  ► colorama${NC}"
pip install colorama --no-cache-dir 2>/dev/null || pip3 install colorama --no-cache-dir

echo -e "${YELLOW}  ► urllib3${NC}"
pip install urllib3 --no-cache-dir 2>/dev/null || pip3 install urllib3 --no-cache-dir

# Get script location
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Make PUBG executable
chmod +x "$SCRIPT_DIR/PUBG" 2>/dev/null

# Create SRCHUB shortcut
if [ "$IS_TERMUX" = true ]; then
    SHORTCUT_DIR="/data/data/com.termux/files/usr/bin"
else
    SHORTCUT_DIR="/usr/local/bin"
fi

echo -e "${CYAN}[*] Creating SRCHUB shortcut...${NC}"

cat > "$SHORTCUT_DIR/SRCHUB" << EOF
#!/bin/bash
cd "$SCRIPT_DIR"
./PUBG
EOF

chmod +x "$SHORTCUT_DIR/SRCHUB"

# Verify
echo -e "\n${GREEN}══════════════════════════════════════${NC}"
echo -e "${GREEN}     INSTALLATION COMPLETE!${NC}"
echo -e "${GREEN}══════════════════════════════════════${NC}"
echo -e "\n${CYAN}Type: ${YELLOW}SRCHUB${CYAN} and press Enter to start${NC}\n"