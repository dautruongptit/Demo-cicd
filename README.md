# 🚀 Spring Boot Demo App — Employee CRUD API

Kết nối MySQL VPS: `103.249.117.228:43766`

---

## 📋 Yêu cầu

- Docker & Docker Compose đã cài trên máy deploy
- MySQL VPS đang chạy và cho phép kết nối từ ngoài

---

## 🗄️ Bước 1: Khởi tạo Database trên VPS MySQL

Chạy lệnh từ máy local (hoặc bất kỳ nơi nào có MySQL client):

```bash
mysql -h 103.249.117.228 -P 43766 -u root -p < init.sql
```

Hoặc copy nội dung `init.sql` vào MySQL Workbench / DBeaver và chạy.

---

## 🐳 Bước 2: Deploy bằng Docker Compose

```bash
# Clone / copy project về máy deploy
cd demo-app

# Build và chạy
docker-compose up -d --build

# Xem log
docker-compose logs -f demo-app

# Kiểm tra container đang chạy
docker ps
```

---

## 🔌 Bước 3: Test API

App chạy tại: `http://localhost:8080`

### Health check
```bash
curl http://localhost:8080/api/employees
```

### Tạo employee mới
```bash
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Nguyễn Văn Test",
    "email": "test@demo.com",
    "department": "Engineering",
    "salary": 30000000
  }'
```

### Lấy danh sách
```bash
curl http://localhost:8080/api/employees
```

### Lấy theo ID
```bash
curl http://localhost:8080/api/employees/1
```

### Lấy theo Department
```bash
curl http://localhost:8080/api/employees/department/Engineering
```

### Cập nhật
```bash
curl -X PUT http://localhost:8080/api/employees/1 \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Nguyễn Văn Updated",
    "email": "test@demo.com",
    "department": "DevOps",
    "salary": 35000000
  }'
```

### Xóa
```bash
curl -X DELETE http://localhost:8080/api/employees/1
```

---

## 📁 Cấu trúc Project

```
demo-app/
├── src/
│   └── main/
│       ├── java/com/demo/app/
│       │   ├── DemoAppApplication.java
│       │   ├── controller/
│       │   │   ├── EmployeeController.java
│       │   │   └── GlobalExceptionHandler.java
│       │   ├── model/
│       │   │   ├── Employee.java
│       │   │   └── ApiResponse.java
│       │   ├── repository/
│       │   │   └── EmployeeRepository.java
│       │   └── service/
│       │       └── EmployeeService.java
│       └── resources/
│           └── application.yml
├── Dockerfile              # Multi-stage build
├── docker-compose.yml      # Deploy config
├── init.sql                # DB init script
└── pom.xml
```

---

## ⚙️ Cấu hình môi trường

Sửa trong `docker-compose.yml` → environment:

| Biến | Giá trị hiện tại |
|------|-----------------|
| SPRING_DATASOURCE_URL | jdbc:mysql://103.249.117.228:43766/demo_db |
| SPRING_DATASOURCE_USERNAME | root |
| SPRING_DATASOURCE_PASSWORD | 12345670 |

---

## 🛠️ Các lệnh Docker hữu ích

```bash
# Dừng app
docker-compose down

# Rebuild khi có thay đổi code
docker-compose up -d --build

# Xem log real-time
docker logs -f demo-app

# Vào trong container
docker exec -it demo-app sh
```
# Demo-cicd
