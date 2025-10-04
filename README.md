# JP Report System

Hệ thống quản lý nhật báo doanh nghiệp toàn diện cho các công ty Nhật Bản.

## Tổng quan

**JP Report System** là một ứng dụng web full-stack được thiết kế để quản lý nhật báo hàng ngày, theo dõi thời gian làm việc và quản lý dự án cho môi trường doanh nghiệp Nhật Bản.

## Tech Stack

### Backend

-   **Framework**: Spring Boot 3.5.6
-   **Database**: PostgreSQL 15 + Redis
-   **ORM**: MyBatis
-   **Security**: Spring Security + JWT
-   **Migration**: Flyway
-   **Container**: Docker + Docker Compose

### Frontend (Tương lai)

-   **Framework**: Next.js 14 + TypeScript
-   **UI Library**: Shadcn/ui + Tailwind CSS
-   **State Management**: Zustand
-   **Form Handling**: React Hook Form + Zod
-   **HTTP Client**: Axios

### DevOps

-   **Containerization**: Docker
-   **CI/CD**: GitHub Actions
-   **Cloud**: AWS (ECS, RDS, ElastiCache)
-   **Monitoring**: CloudWatch

## Tính năng chính

-   **Quản lý nhật báo hàng ngày**: Tạo, chỉnh sửa và theo dõi báo cáo công việc
-   **Theo dõi thời gian**: Check-in/check-out và quản lý giờ làm việc
-   **Quản lý dự án**: Phân công công việc và theo dõi tiến độ
-   **Phân quyền người dùng**: ADMIN, MANAGER, EMPLOYEE
-   **Thống kê và báo cáo**: Dashboard analytics và báo cáo hiệu suất

## Cấu trúc dự án

```
JPReport/
├── be/                 # Backend (Spring Boot)
├── fe/                 # Frontend (Next.js) - Tương lai
├── docker-compose.yml  # Development environment
└── README.md          # Tài liệu này
```

## Bắt đầu nhanh

```bash
# Clone repository
git clone <repository-url>
cd JPReport

# Chạy backend
cd be
docker-compose up -d
./mvnw spring-boot:run
```

## API Endpoints

-   **Base URL**: http://localhost:8080/api/v1
-   **Health Check**: http://localhost:8080/api/v1/actuator/health
-   **Swagger UI**: http://localhost:8080/swagger-ui.html (Tương lai)

## Trạng thái phát triển

-   ✅ **Backend Framework**: Hoàn thành cấu trúc cơ bản
-   ✅ **Database Setup**: PostgreSQL + Redis
-   ✅ **Common Framework**: BaseEntity, BaseService, BaseController
-   🚧 **Authentication**: JWT + Spring Security (Đang phát triển)
-   ⏳ **Frontend**: Chưa bắt đầu
-   ⏳ **Deployment**: Chưa bắt đầu

## Đóng góp

Dự án này được phát triển theo phương pháp Agile với chu kỳ phát triển 3 tháng:

-   **Tháng 1**: Backend cơ bản + Database
-   **Tháng 2**: APIs hoàn chỉnh + Frontend cơ bản
-   **Tháng 3**: UI hoàn chỉnh + DevOps + Deployment

## Liên hệ

Để biết thêm chi tiết về implementation, xem:

-   [Backend Documentation](./be/README.md)
-   [Frontend Documentation](./fe/README.md) (Tương lai)
