# TPS Admin Portal - Gateway Configuration

## 📁 โครงสร้างไฟล์

```
gateway/
├── Dockerfile           # Docker image configuration
├── docker-compose.yml   # Docker compose configuration
├── nginx.conf          # Nginx web server configuration
├── deploy.sh           # Deployment script
└── .dockerignore       # Files to ignore in Docker build
```

## 🚀 วิธีการ Deploy

### 1. Deploy ครั้งแรก

```bash
cd gateway
docker compose up -d --build
```

### 2. Deploy อัพเดทใหม่

```bash
# ใช้ deploy script (แนะนำ)
cd gateway
./deploy.sh

# หรือแบบ manual
git pull origin main
docker compose up -d --build
```

### 3. ตรวจสอบสถานะ

```bash
# ดู running containers
docker compose ps

# ดู logs
docker compose logs -f

# ดูการใช้ทรัพยากร
docker stats
```

### 4. หยุด/รีสตาร์ท

```bash
# หยุด containers
docker compose down

# รีสตาร์ท
docker compose restart

# รีสตาร์ทพร้อม rebuild
docker compose up -d --build --force-recreate
```

## 🔧 Configuration

### Nginx Configuration
แก้ไขไฟล์ `nginx.conf` เพื่อปรับแต่ง:
- Port
- Domain name
- Security headers
- Cache settings
- Gzip compression

### Docker Compose
แก้ไขไฟล์ `docker-compose.yml` เพื่อปรับแต่ง:
- Port mapping (default: 80:80)
- Container name
- Network settings
- Restart policy

## 🌐 เข้าถึง Application

หลัง deploy เสร็จสามารถเข้าถึงได้ที่:
- Local: http://localhost
- Server: http://your-server-ip
- Domain: http://your-domain.com (ถ้าตั้งค่า DNS แล้ว)

## 🛠 Troubleshooting

### ถ้า port 80 ถูกใช้งานอยู่
แก้ไข `docker-compose.yml`:
```yaml
ports:
  - "8080:80"  # เปลี่ยนจาก 80 เป็น 8080
```

### ดู logs เพื่อ debug
```bash
docker compose logs -f tps-admin-portal
```

### Rebuild ใหม่ทั้งหมด
```bash
docker compose down
docker compose up -d --build --force-recreate
```

### ลบ container และ image เก่า
```bash
docker compose down --rmi all
docker system prune -a
```

## 📝 Notes

- แนะนำให้รัน deploy script (`./deploy.sh`) สำหรับการอัพเดท
- Container จะ auto-restart เมื่อ server reboot
- Static files จะถูก cache 1 ปี
- Gzip compression เปิดใช้งานอัตโนมัติ
