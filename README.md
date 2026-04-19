# Library Management System

A RESTful API for managing a library — books, authors, members, and borrow records. Built with **Spring Boot 3.3** and an **H2 in-memory database**.

---

## 📋 Prerequisites

| Requirement | Version | Download |
|------------|---------|----------|
| Java JDK | **21+** | [Oracle](https://www.oracle.com/java/technologies/downloads/#java21) · [Eclipse Temurin (free)](https://adoptium.net/temurin/releases/?version=21) |
| Maven | **3.9+** | [Download](https://maven.apache.org/download.cgi) *(or use the setup script — it installs it automatically on Windows)* |

---

## 🚀 Quick Start (Recommended)

### 🪟 Windows

```powershell
# 1. Clone the repo
git clone https://github.com/YOUR_USERNAME/library-management-system.git
cd library-management-system/library

# 2. Run the setup script (checks Java, installs Maven if needed, starts the app)
.\setup.ps1
```

### 🐧 Linux / 🍎 macOS

```bash
# 1. Clone the repo
git clone https://github.com/YOUR_USERNAME/library-management-system.git
cd library-management-system/library

# 2. Make the script executable and run
chmod +x setup.sh
./setup.sh
```

---

## ▶️ Manual Start (if you already have Java 21 + Maven)

```bash
cd library
mvn spring-boot:run
```

---

## 🌐 Access the App

Once running, open your browser or Postman:

| URL | Description |
|-----|-------------|
| `http://localhost:8080` | API Welcome page (lists all endpoints) |
| `http://localhost:8080/api/authors` | Authors API |
| `http://localhost:8080/api/books` | Books API |
| `http://localhost:8080/api/members` | Members API |
| `http://localhost:8080/api/borrow-records` | Borrow Records API |
| `http://localhost:8080/h2-console` | H2 Database Console (username: `sa`, no password) |

---

## 📡 API Endpoints

### 👤 Authors — `/api/authors`

| Method | URL | Description |
|--------|-----|-------------|
| `GET` | `/api/authors` | Get all authors (paginated) |
| `GET` | `/api/authors/{id}` | Get author by ID |
| `GET` | `/api/authors/{id}/books` | Get all books by an author |
| `POST` | `/api/authors` | Create a new author |
| `PUT` | `/api/authors/{id}` | Update an author |
| `DELETE` | `/api/authors/{id}` | Delete an author |

**POST/PUT Body:**
```json
{
    "firstName": "George",
    "lastName": "Orwell",
    "nationality": "British",
    "birthDate": "1903-06-25"
}
```

---

### 📚 Books — `/api/books`

| Method | URL | Description |
|--------|-----|-------------|
| `GET` | `/api/books` | Get all books (paginated) |
| `GET` | `/api/books/{id}` | Get book by ID |
| `POST` | `/api/books` | Create a new book |
| `PUT` | `/api/books/{id}` | Update a book |
| `DELETE` | `/api/books/{id}` | Delete a book |

**POST/PUT Body:**
```json
{
    "title": "1984",
    "isbn": "978-0451524935",
    "genre": "Dystopian Fiction",
    "publishedYear": 1949,
    "authorId": 1
}
```

---

### 👥 Members — `/api/members`

| Method | URL | Description |
|--------|-----|-------------|
| `GET` | `/api/members` | Get all members (paginated) |
| `GET` | `/api/members/{id}` | Get member by ID |
| `POST` | `/api/members` | Register a new member |
| `PUT` | `/api/members/{id}` | Update a member |
| `DELETE` | `/api/members/{id}` | Delete a member |

**POST/PUT Body:**
```json
{
    "firstName": "Ahmed",
    "lastName": "Hassan",
    "email": "ahmed@example.com",
    "phoneNumber": "+20123456789"
}
```

---

### 📖 Borrow Records — `/api/borrow-records`

| Method | URL | Description |
|--------|-----|-------------|
| `GET` | `/api/borrow-records` | Get all borrow records |
| `POST` | `/api/borrow-records` | Borrow a book |
| `PUT` | `/api/borrow-records/{id}/return` | Return a borrowed book |

**POST Body (borrow a book):**
```json
{
    "bookId": 1,
    "memberId": 1,
    "borrowDate": "2026-04-19"
}
```

---

## 🗄️ Database (H2 Console)

This app uses an **in-memory H2 database** (data resets on restart).

To browse the database via browser:
1. Open: `http://localhost:8080/h2-console`
2. Set **JDBC URL** to: `jdbc:h2:mem:librarydb`
3. **Username**: `sa`
4. **Password**: *(leave empty)*
5. Click **Connect**

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Java 21 |
| Framework | Spring Boot 3.3.4 |
| Database | H2 (in-memory) |
| ORM | Hibernate / Spring Data JPA |
| Mapping | MapStruct 1.6.2 |
| Boilerplate | Lombok 1.18.34 |
| Validation | Jakarta Bean Validation |
| Build Tool | Maven 3.9.6 |

---

## 📁 Project Structure

```
library/
├── src/
│   └── main/
│       ├── java/com/example/library/
│       │   ├── controller/     # REST Controllers
│       │   ├── dto/            # Request & Response DTOs
│       │   │   ├── request/
│       │   │   └── response/
│       │   ├── entity/         # JPA Entities
│       │   ├── exception/      # Custom Exceptions & Global Handler
│       │   ├── mapper/         # MapStruct Mappers
│       │   ├── repository/     # Spring Data JPA Repositories
│       │   └── service/        # Business Logic
│       └── resources/
│           └── application.properties
├── .gitignore
├── pom.xml
├── setup.ps1    # Windows setup script
└── setup.sh     # Linux/macOS setup script
```
