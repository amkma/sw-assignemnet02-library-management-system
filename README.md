# Library Management System

A RESTful API for a **Library Management System** built with **Spring Boot** and **H2**. The system allows librarians to manage books, authors, and members, and to track book-borrowing records. All data is persisted in an **H2 in-memory relational database**.

---

## 📋 Prerequisites

| Requirement | Version |
|-------------|---------|
| **Java JDK** | 21 or higher |
| **Maven** | 3.9+ (or use the included Maven Wrapper `./mvnw`) |

---

## 🚀 How to Build and Run

### Using the Maven Wrapper (recommended)

```bash
# Clone the repository
git clone <repository-url>
cd sw-assignemnet02-library-management-system

# Build and run (Linux/macOS)
./mvnw spring-boot:run

# Build and run (Windows)
.\mvnw.cmd spring-boot:run
```

### Using a locally installed Maven

```bash
mvn spring-boot:run
```

The application starts on **http://localhost:8080**.

---

## 🗄️ H2 Database Console

This project uses the **H2 embedded in-memory database** as required by the assignment. Data resets on every restart.

To access the H2 Console:

1. Open your browser: **http://localhost:8080/h2-console**
2. Set the **JDBC URL** to: `jdbc:h2:mem:librarydb`
3. **Username**: `sa`
4. **Password**: *(leave empty)*
5. Click **Connect**

---

## 📡 API Endpoints

All paths are relative to `http://localhost:8080`. All endpoints return appropriate HTTP status codes (200, 201, 204, 400, 404, 409, 500).

### 👤 Authors — `/api/authors`

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/authors` | Get all authors (with pagination and sorting) |
| `GET` | `/api/authors/{id}` | Get a single author by ID |
| `POST` | `/api/authors` | Create a new author |
| `PUT` | `/api/authors/{id}` | Update an existing author |
| `DELETE` | `/api/authors/{id}` | Delete an author |
| `GET` | `/api/authors/{id}/books` | Get all books by a specific author |

### 📚 Books — `/api/books`

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/books` | Get all books (with pagination and sorting) |
| `GET` | `/api/books/{id}` | Get a single book by ID (includes author details) |
| `POST` | `/api/books` | Create a new book (author must exist) |
| `PUT` | `/api/books/{id}` | Update a book |
| `DELETE` | `/api/books/{id}` | Delete a book |
| `GET` | `/api/books/search` | Search books by title, genre, and/or publishedYear (query params) |

### 👥 Members — `/api/members`

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/members` | Get all members (with pagination) |
| `GET` | `/api/members/{id}` | Get a member by ID |
| `GET` | `/api/members/search` | Search for members by name (query param: `name`) |
| `POST` | `/api/members` | Register a new member (membershipDate auto-set) |
| `PUT` | `/api/members/{id}` | Update member information |
| `DELETE` | `/api/members/{id}` | Delete a member |

### 📖 Borrow Records — `/api/borrow-records`

| Method | Path | Description |
|--------|------|-------------|
| `POST` | `/api/borrow-records` | Borrow a book (error if already borrowed) |
| `PUT` | `/api/borrow-records/{id}/return` | Return a book (sets returnDate to today) |
| `GET` | `/api/borrow-records/member/{memberId}` | Get all borrow records for a specific member |
| `GET` | `/api/borrow-records/active` | Get all currently borrowed books (returnDate is null) |

---

## 🧪 Testing with Postman (Recommended)

A ready-to-use Postman collection is included in the repository:

📄 **`Library Management System.postman_collection.json`**

### How to Import and Run

1. **Download & install** [Postman](https://www.postman.com/downloads/) if you don't have it already.
2. **Open Postman** and click the **Import** button (top-left corner).
3. **Drag and drop** the file `Library Management System.postman_collection.json` into the import window — or click **Upload Files** and browse to it inside the project folder.
4. Click **Import** to confirm. The collection **"Library Management System"** will appear in your left sidebar under **Collections**.
5. **Make sure the application is running** (`.\mvnw.cmd spring-boot:run` on Windows or `./mvnw spring-boot:run` on Linux/macOS).
6. **Open any request** from the collection, then click the **Send** button to execute it.

> **💡 Tip:** Run requests in order — start with creating Authors, then Books, then Members, then Borrow Records — because some endpoints depend on data created by earlier ones.

---

## 🧪 Sample `curl` Commands

### Authors

```bash
# Create an author
curl -X POST http://localhost:8080/api/authors \
  -H "Content-Type: application/json" \
  -d '{"firstName":"George","lastName":"Orwell","nationality":"British","birthDate":"1903-06-25"}'

# Get all authors (paginated, sorted by lastName)
curl http://localhost:8080/api/authors?page=0&size=10&sort=lastName,asc

# Get author by ID
curl http://localhost:8080/api/authors/1

# Update an author
curl -X PUT http://localhost:8080/api/authors/1 \
  -H "Content-Type: application/json" \
  -d '{"firstName":"George","lastName":"Orwell","nationality":"British","birthDate":"1903-06-25"}'

# Delete an author
curl -X DELETE http://localhost:8080/api/authors/1

# Get all books by an author
curl http://localhost:8080/api/authors/1/books
```

### Books

```bash
# Create a book (authorId must reference an existing author)
curl -X POST http://localhost:8080/api/books \
  -H "Content-Type: application/json" \
  -d '{"title":"1984","isbn":"978-0451524935","genre":"Dystopian Fiction","publishedYear":1949,"authorId":1}'

# Get all books (paginated)
curl http://localhost:8080/api/books?page=0&size=10&sort=title,asc

# Get book by ID (includes author details)
curl http://localhost:8080/api/books/1

# Update a book
curl -X PUT http://localhost:8080/api/books/1 \
  -H "Content-Type: application/json" \
  -d '{"title":"1984","isbn":"978-0451524935","genre":"Dystopian Fiction","publishedYear":1949,"authorId":1}'

# Delete a book
curl -X DELETE http://localhost:8080/api/books/1

# Search books by title, genre, and/or publishedYear
curl "http://localhost:8080/api/books/search?title=1984&genre=Dystopian Fiction&publishedYear=1949"
```

### Members

```bash
# Register a new member (membershipDate is auto-set)
curl -X POST http://localhost:8080/api/members \
  -H "Content-Type: application/json" \
  -d '{"firstName":"Ahmed","lastName":"Hassan","email":"ahmed@example.com","phoneNumber":"+20123456789"}'

# Get all members (paginated)
curl http://localhost:8080/api/members?page=0&size=10

# Get member by ID
curl http://localhost:8080/api/members/1

# Search members by name
curl "http://localhost:8080/api/members/search?name=Ahmed"

# Update a member
curl -X PUT http://localhost:8080/api/members/1 \
  -H "Content-Type: application/json" \
  -d '{"firstName":"Ahmed","lastName":"Hassan","email":"ahmed@example.com","phoneNumber":"+20198765432"}'

# Delete a member
curl -X DELETE http://localhost:8080/api/members/1
```

### Borrow Records

```bash
# Borrow a book (creates a borrow record; returns 409 if already borrowed)
curl -X POST http://localhost:8080/api/borrow-records \
  -H "Content-Type: application/json" \
  -d '{"bookId":1,"memberId":1}'

# Return a book (sets returnDate to today)
curl -X PUT http://localhost:8080/api/borrow-records/1/return

# Get all borrow records for a specific member
curl http://localhost:8080/api/borrow-records/member/1

# Get all currently borrowed books (active borrows)
curl http://localhost:8080/api/borrow-records/active
```

---

## 🔍 N+1 Analysis

### The Problem

The **N+1 problem** occurs when a query fetches N entities, and for each entity, an additional query is lazily triggered to load a related association — resulting in **1 + N database queries** instead of a single query.

In our project, all relationships use `FetchType.LAZY` (as required). This means that when listing books, each `Book` entity's `author` field is not loaded immediately. When the mapper accesses `book.getAuthor()` to build the `BookResponse` (which includes nested `AuthorResponse`), Hibernate fires a **separate SELECT query per book** to fetch the author. For a page of 10 books, this results in **1 query for books + 10 queries for authors = 11 queries total**.

### The Affected Endpoint

**`GET /api/books`** — Get all books (paginated).

Without a fix, this endpoint naively triggers the N+1 problem because the response DTO includes the author's details for every book.

### The Solution

We solved this by using a **JPQL `JOIN FETCH`** query in `BookRepository`:

```java
@Query("SELECT b FROM Book b JOIN FETCH b.author")
Page<Book> findAllWithAuthor(Pageable pageable);
```

This forces Hibernate to load each book and its associated author in a **single SQL query** using a `JOIN`, completely eliminating the N+1 problem. The same pattern is applied to:
- `findByIdWithAuthor(Long id)` — single book lookup
- `findAllByAuthorId(Long authorId)` — books by author
- `searchBooks(...)` — book search
- `findAllByMemberIdWithDetails(Long memberId)` — borrow records by member
- `findAllActiveWithDetails()` — active borrow records

---

## 🛡️ Error Handling

All errors are returned as structured JSON (never raw stack traces):

| HTTP Status | Scenario |
|-------------|----------|
| `400 Bad Request` | Validation failures, missing required fields, illegal arguments |
| `404 Not Found` | Entity with the given ID does not exist |
| `409 Conflict` | Duplicate resource (e.g., duplicate ISBN or email), book already borrowed |
| `500 Internal Server Error` | Unexpected errors (returned as a structured response, not a stack trace) |

Custom exception classes used:
- `ResourceNotFoundException` → 404
- `DuplicateResourceException` → 409
- `BookAlreadyBorrowedException` → 409

Runtime exceptions handled by the global `@RestControllerAdvice`:
- `NullPointerException` → 400
- `IllegalArgumentException` → 400
- `DataIntegrityViolationException` → 409
- `MethodArgumentNotValidException` → 400

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| Language | Java 21 |
| Framework | Spring Boot 3.3.4 |
| Database | H2 (in-memory embedded) |
| ORM | Hibernate / Spring Data JPA |
| Mapping | MapStruct 1.6.2 |
| Boilerplate | Lombok 1.18.34 |
| Validation | Jakarta Bean Validation |
| Build Tool | Maven (with Maven Wrapper) |

---

## 📁 Project Structure

```
src/main/java/com/example/library/
├── controller/        ← REST controllers
├── service/           ← Business logic
├── repository/        ← JPA repositories
├── entity/            ← JPA entity classes
├── dto/               ← Request & response DTOs
│   ├── request/
│   └── response/
├── mapper/            ← MapStruct mapper interfaces
└── exception/         ← Custom exception classes & global handler

src/main/resources/
└── application.properties
```
