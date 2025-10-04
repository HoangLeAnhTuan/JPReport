# JP Report System - Backend

## Tổng quan dự án

**JP Report System** là hệ thống quản lý nhật báo doanh nghiệp toàn diện, được thiết kế để hỗ trợ các công ty Nhật Bản trong việc quản lý công việc hàng ngày của nhân viên.

### Business Requirements

#### **Core Features:**

-   **Daily Report Management**: Tạo, chỉnh sửa, và quản lý nhật báo hàng ngày
-   **Attendance Tracking**: Theo dõi giờ làm việc, check-in/check-out
-   **Project Management**: Quản lý dự án và phân công công việc
-   **User Management**: Quản lý nhân viên và phân quyền
-   **Analytics & Reports**: Thống kê và báo cáo hiệu suất

#### **User Roles:**

-   **ADMIN**: Quản lý toàn hệ thống, người dùng, và cấu hình
-   **MANAGER**: Quản lý nhóm, duyệt nhật báo, và theo dõi tiến độ
-   **EMPLOYEE**: Tạo nhật báo, ghi nhận thời gian làm việc

#### **Business Workflow:**

1. **Morning**: Nhân viên check-in và tạo kế hoạch ngày
2. **During Work**: Cập nhật tiến độ công việc theo thời gian thực
3. **Evening**: Hoàn thành nhật báo và check-out
4. **Management**: Manager review và approve nhật báo
5. **Analytics**: Tạo báo cáo định kỳ cho leadership

## Công nghệ sử dụng

### **Kiến trúc Backend:**

-   **Framework**: Spring Boot 3.5.6
-   **Cơ sở dữ liệu**: PostgreSQL 15 (Chính), Redis (Cache/Session)
-   **ORM**: MyBatis (Tiếp cận SQL-first)
-   **Migration**: Flyway (Tự động quản lý bởi Spring Boot)
-   **Bảo mật**: Spring Security + JWT
-   **Container hóa**: Docker + Docker Compose

### **Mẫu thiết kế chính:**

-   **Clean Architecture**: Tách biệt các mối quan tâm
-   **Repository Pattern**: Trừu tượng hóa truy cập dữ liệu
-   **DTO Pattern**: Tối ưu hóa truyền tải dữ liệu
-   **Xử lý ngoại lệ**: Quản lý lỗi tập trung

## Cấu trúc dự án

```
be/
├── src/main/java/yeongjun/jpreport/be/
│   ├── common/                    # Framework chung
│   │   ├── constants/             # Hằng số API (mã phản hồi)
│   │   ├── domain/
│   │   │   ├── entity/            # Entity cơ sở với audit fields
│   │   │   └── vo/                # View objects cho API responses
│   │   ├── response/              # API responses chuẩn hóa
│   │   ├── dao/                   # MyBatis base DAO interfaces
│   │   ├── service/               # Base service classes
│   │   ├── controller/            # Base controller với common methods
│   │   ├── config/                # Configuration classes
│   │   ├── exception/             # Xử lý ngoại lệ toàn cục
│   │   └── utils/                 # Utility classes
│   ├── auth/                      # Xác thực & Phân quyền
│   ├── user/                      # Quản lý người dùng
│   ├── project/                   # Quản lý dự án
│   ├── report/                    # Quản lý nhật báo
│   └── gateway/                   # API Gateway (tương lai)
├── src/main/resources/
│   ├── db/migration/              # Flyway database migrations
│   ├── mapper/                    # MyBatis XML mappers
│   └── application.properties     # Cấu hình với env variables
└── docker-compose.yml             # Môi trường phát triển local
```

## Cấu trúc cơ sở dữ liệu

### **Bảng chính:**

1. **users** - Xác thực người dùng và quản lý hồ sơ
2. **projects** - Thông tin và quản lý dự án
3. **project_members** - Phân công thành viên dự án
4. **daily_reports** - Các mục nhật báo hàng ngày chính
5. **report_tasks** - Chi tiết phân tích công việc trong báo cáo
6. **attendance** - Theo dõi thời gian và bản ghi chấm công
7. **tags** - Hệ thống phân loại và gắn nhãn
8. **report_tags** - Mối quan hệ nhiều-nhiều cho phân loại báo cáo

## Cách chạy dự án

### **Prerequisites:**

-   Java 17+
-   Docker & Docker Compose
-   Maven 3.6+

### **Quick Start:**

```bash
# 1. Clone repository
git clone <repository-url>
cd be

# 2. Copy environment template (optional)
cp env-example .env
# Edit .env file if needed

# 3. Start infrastructure services (từ thư mục gốc)
cd ..
docker-compose up -d postgres redis

# 4. Run application (Flyway auto-migration included)
cd be
./mvnw spring-boot:run
```

> **Lưu ý**: Flyway migrations sẽ chạy tự động khi khởi động ứng dụng

## API Endpoints

### **URL Ứng dụng:**

-   **Base API**: http://localhost:8081/api/v1
-   **Health Check**: http://localhost:8081/api/v1/actuator/health
-   **Metrics**: http://localhost:8081/api/v1/actuator/metrics

### **Định dạng API Response:**

```json
{
  "code": 100,           // 100: thành công, 101: lỗi
  "message": "Success",
  "data": { ... },
  "timestamp": "2024-01-01T10:00:00"
}
```

## Cấu hình Database

### **Chi tiết Connection:**

-   **Host**: localhost:5432
-   **Database**: jpreport_db
-   **User**: jpreport
-   **Password**: 123456

### **Tài khoản Admin mặc định:**

-   **Email**: admin@jpreport.com
-   **Password**: password
-   **Role**: ADMIN

## Environment Variables

Ứng dụng hỗ trợ cấu hình dựa trên environment variables:

```bash
# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=jpreport_db
DB_USER=jpreport
DB_PASSWORD=123456

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379

# JWT
JWT_SECRET=your_secret_key
JWT_EXPIRATION=86400000

# Server
SERVER_PORT=8080
```

## Lệnh Development

### **Build & Test:**

```bash
# Clean build
./mvnw clean package

# Run tests
./mvnw test

# Run with specific profile
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev
```

### **Thao tác Database:**

```bash
# Kết nối tới PostgreSQL
docker exec -it jpreport-postgres psql -U jpreport -d jpreport_db

# Xem database logs
docker-compose logs postgres

# Reset database (Chỉ dành cho Development)
docker-compose down -v && docker-compose up -d
```

### **Monitoring:**

```bash
# Xem application logs
docker-compose logs app

# Xem trạng thái tất cả services
docker-compose ps

# Monitor Redis
docker exec -it jpreport-redis redis-cli monitor
```

## Troubleshooting

### **Các vấn đề thường gặp:**

| Vấn đề                          | Giải pháp                           |
| ------------------------------- | ----------------------------------- |
| **Port 8080 đang được sử dụng** | `lsof -i :8080` → `kill -9 <PID>`   |
| **Kết nối Database thất bại**   | `docker-compose logs postgres`      |
| **Lỗi Migration**               | Kiểm tra logs để tìm lỗi SQL syntax |
| **Kết nối Redis thất bại**      | `docker-compose restart redis`      |

### **Health Checks:**

```bash
# Kiểm tra application health
curl http://localhost:8080/api/v1/actuator/health

# Kiểm tra kết nối Database
docker exec jpreport-postgres pg_isready -U jpreport

# Kiểm tra kết nối Redis
docker exec jpreport-redis redis-cli ping
```

## Nhiệm vụ tiếp theo

### **Nhiệm vụ Development tiếp theo:**

1. **Triển khai JWT Authentication**
2. **APIs quản lý User**
3. **Thao tác CRUD cho Daily Report**
4. **Tính năng quản lý Project**
5. **Hệ thống theo dõi Attendance**

### **Tính năng nâng cao:**

-   **Mobile API Support**
-   **Advanced Analytics Dashboard**
-   **Real-time Notifications**
-   **Email Integration**
-   **Multi-language Support**
