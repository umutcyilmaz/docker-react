# İlk aşama: Node.js ile build işlemi
FROM node:16-alpine AS builder

# Çalışma dizini
WORKDIR /app

# package.json ve package-lock.json dosyalarını kopyala
COPY package.json .

# Bağımlılıkları yükle
RUN npm install

# Uygulama dosyalarını kopyala ve build işlemini çalıştır
COPY . .
RUN npm run build

# İkinci aşama: Nginx ile build edilmiş dosyaları sunma
FROM nginx:alpine

# Build edilen dosyaları kopyala
COPY --from=builder /app/build /usr/share/nginx/html

# Nginx server başlatılır (default CMD komutu)
