# Django Backend Setup Guide

## Prerequisites
- Python 3.8+
- PostgreSQL (optional, SQLite for development)
- pip

## Installation Steps

### 1. Navigate to Backend Directory
```bash
cd backend
```

### 2. Create Virtual Environment
```bash
python -m venv venv

# On Windows
venv\Scripts\activate

# On macOS/Linux
source venv/bin/activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Set Up Environment Variables
```bash
cp .env.example .env
```

Edit `.env` file with your configuration:
- `DEBUG=True` (for development)
- `SECRET_KEY=your-secret-key-here`
- `DB_ENGINE` (postgres or sqlite3)
- `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`, `DB_PORT`

### 5. Run Migrations
```bash
python manage.py makemigrations
python manage.py migrate
```

### 6. Create Superuser
```bash
python manage.py createsuperuser
```

### 7. Run Development Server
```bash
python manage.py runserver
```

Server will run at: `http://localhost:8000`

## API Documentation
- Swagger UI: `http://localhost:8000/swagger/`
- ReDoc: `http://localhost:8000/redoc/`
- Admin Panel: `http://localhost:8000/admin/`

## Apps Structure

### 1. **users** - User Authentication
- User registration and login
- User profiles
- Role management (Student/Teacher)

**Endpoints:**
- POST `/api/users/register/` - Register new user
- POST `/api/users/login/` - User login
- GET `/api/profiles/me/` - Get user profile
- PUT `/api/profiles/update_profile/` - Update profile

### 2. **courses** - Course Management
- Create and manage courses
- Video lessons
- Student enrollment

**Endpoints:**
- GET `/api/courses/` - List all courses
- POST `/api/courses/` - Create course
- GET `/api/courses/my_courses/` - Get teacher's courses
- POST `/api/courses/{id}/enroll/` - Enroll in course
- GET `/api/lessons/` - Get lessons by course

### 3. **assignments** - Assignments & Submissions
- Create assignments
- Student submissions
- Grading

**Endpoints:**
- GET `/api/assignments/` - List assignments
- POST `/api/assignments/` - Create assignment
- POST `/api/submissions/` - Submit assignment
- GET `/api/submissions/my_submissions/` - Get student's submissions
- POST `/api/submissions/{id}/grade/` - Grade submission

## Database Models

### User Profile
```
- user (FK to User)
- role (student/teacher)
- profile_picture
- bio
- phone
```

### Course
```
- teacher (FK to User)
- title
- description
- thumbnail
- category
- price
```

### Lesson
```
- course (FK to Course)
- title
- description
- video_url
- duration
- order
```

### Assignment
```
- course (FK to Course)
- title
- description
- due_date
- total_marks
```

### Submission
```
- assignment (FK to Assignment)
- student (FK to User)
- submission_text
- submission_file
- marks_obtained
- feedback
```

## Testing API

Use Postman or curl:

```bash
# Register
curl -X POST http://localhost:8000/api/users/register/ \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "testpass123",
    "role": "student",
    "first_name": "Test",
    "last_name": "User"
  }'

# Login
curl -X POST http://localhost:8000/api/users/login/ \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "password": "testpass123"
  }'
```

## Deployment

For production deployment:
1. Change `DEBUG=False`
2. Update `ALLOWED_HOSTS`
3. Use PostgreSQL
4. Set up proper `SECRET_KEY`
5. Configure CORS properly
6. Use Gunicorn: `gunicorn flow.wsgi`

## Troubleshooting

**Port 8000 already in use:**
```bash
python manage.py runserver 8001
```

**Database errors:**
```bash
python manage.py flush
python manage.py migrate
```

**Permission errors:**
```bash
chmod +x manage.py
```
