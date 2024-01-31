
# Node.js resmi base image'ını kullan
FROM node:21.6.1

# Çalışma dizini oluştur
WORKDIR /usr/src/app

# Uygulama bağımlılıklarını kopyala
# package.json VEYA package-lock.json dosyasını kopyala
COPY package*.json ./

# Uygulama bağımlılıklarını yükle
RUN npm install

# Uygulama kaynak kodunu kopyala
COPY . .

# Uygulama portunu dışarı aç
EXPOSE 3000

# Uygulamayı başlat
CMD [ "node", "app.js" ]
