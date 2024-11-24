#!/bin/bash

# Define variáveis de cores
C_YELLOW="\033[1;33m"
C_GREEN="\033[1;32m"
C_RESET="\033[0m"

echo -e "${C_YELLOW}----------------------------------------------- \n ## 1. Atualizar e Instalar Dependências Essenciais \n----------------------------------------------- ${C_RESET}"
# Atualizar pacotes e instalar dependências essenciais
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    build-essential \
    curl \
    wget \
    git \
    unzip \
    vim \
    zsh \
    gnupg \
    lsb-release \
    ca-certificates \
    libcurl4-openssl-dev \
    libssl-dev \
    libjpeg-dev \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    libmysqlclient-dev \
    python3-pip \
    flameshot \
    gnome-calculator

echo -e "${C_YELLOW}----------------------------------------------- \n ## 2. Instalar PHP 8.2 e Extensões Comuns \n----------------------------------------------- ${C_RESET}"
# Instalar PHP e extensões necessárias
sudo apt install -y php8.2 php8.2-cli php8.2-fpm php8.2-mysql php8.2-xml php8.2-mbstring php8.2-zip php8.2-curl php8.2-json

echo -e "${C_YELLOW}----------------------------------------------- \n ## 3. Instalar MySQL \n----------------------------------------------- ${C_RESET}"
# Instalar MySQL
sudo apt install -y mysql-server
sudo mysql_secure_installation

# Configurar MySQL para o usuário
sudo mysql --execute="CREATE USER '$USER'@'localhost' IDENTIFIED BY 'qwerty';"
sudo mysql --execute="GRANT ALL PRIVILEGES ON *.* TO '$USER'@'localhost' WITH GRANT OPTION;"
sudo mysql --execute="FLUSH PRIVILEGES;"

echo -e "${C_YELLOW}----------------------------------------------- \n ## 4. Instalar Node.js e NPM \n----------------------------------------------- ${C_RESET}"
# Instalar Node.js e NPM
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

echo -e "${C_YELLOW}----------------------------------------------- \n ## 5. Instalar Composer \n----------------------------------------------- ${C_RESET}"
# Instalar Composer (Gerenciador de dependências PHP)
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo -e "${C_YELLOW}----------------------------------------------- \n ## 6. Instalar Visual Studio Code \n----------------------------------------------- ${C_RESET}"
# Instalar Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
sudo apt update
sudo apt install -y code

echo -e "${C_YELLOW}----------------------------------------------- \n ## 7. Instalar Docker \n----------------------------------------------- ${C_RESET}"
# Instalar Docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Adicionar o usuário ao grupo docker para evitar uso de sudo
sudo usermod -aG docker $USER

echo -e "${C_YELLOW}----------------------------------------------- \n ## 8. Instalar Git \n----------------------------------------------- ${C_RESET}"
# Instalar Git
sudo apt install -y git

echo -e "${C_YELLOW}----------------------------------------------- \n ## 9. Personalizações de Ambiente \n----------------------------------------------- ${C_RESET}"
# Configurações de ZSH, Vim, e Alias
chsh -s $(which zsh)
touch ~/.bash_aliases
echo "alias ll='ls -lah'" >> ~/.bash_aliases
echo "alias gs='git status'" >> ~/.bash_aliases
echo "alias gp='git pull'" >> ~/.bash_aliases
echo "alias gc='git commit -m'" >> ~/.bash_aliases
echo "alias gcl='git clone'" >> ~/.bash_aliases
echo "alias vi='vim'" >> ~/.bash_aliases
echo "alias code='code --no-sandbox'" >> ~/.bash_aliases

# Ativar alias no ZSH
source ~/.bash_aliases

echo -e "${C_YELLOW}----------------------------------------------- \n ## 10. Configurar Ambiente Visual (Temas e Ícones) \n----------------------------------------------- ${C_RESET}"
# Instalar temas e ícones
sudo apt install -y arc-theme papirus-icon-theme

# Configurações de tema no Cinnamon (ajuste se estiver usando outro desktop)
gsettings set org.cinnamon.desktop.interface gtk-theme "Arc-Dark"
gsettings set org.cinnamon.desktop.interface icon-theme "Papirus-Dark"

# Configurações de aparência e atalhos (pode ser ajustado conforme a necessidade)
gsettings set org.cinnamon.desktop.wm.preferences button-layout "close,minimize,maximize:"
gsettings set org.cinnamon.desktop.background picture-options "zoom"
gsettings set org.cinnamon.desktop.background picture-uri "file://$HOME/wallpaper.jpg"

echo -e "${C_GREEN}----------------------------------------------- \n ## Ambiente de Desenvolvimento Configurado! \n----------------------------------------------- ${C_RESET}"
echo -e "Reinicie o sistema ou a sessão para aplicar as alterações."
