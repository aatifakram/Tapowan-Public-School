-- SQL Structure for SchoolPulse Application (SQL Server Compatible)

-- Drop tables if they exist to allow re-running the script
IF OBJECT_ID('calendar_events', 'U') IS NOT NULL DROP TABLE calendar_events;
IF OBJECT_ID('backups', 'U') IS NOT NULL DROP TABLE backups;
IF OBJECT_ID('roles', 'U') IS NOT NULL DROP TABLE roles;
IF OBJECT_ID('system_settings', 'U') IS NOT NULL DROP TABLE system_settings;
IF OBJECT_ID('school_holidays', 'U') IS NOT NULL DROP TABLE school_holidays;
IF OBJECT_ID('audit_logs', 'U') IS NOT NULL DROP TABLE audit_logs;
IF OBJECT_ID('announcements', 'U') IS NOT NULL DROP TABLE announcements;
IF OBJECT_ID('notifications', 'U') IS NOT NULL DROP TABLE notifications;
IF OBJECT_ID('invoices', 'U') IS NOT NULL DROP TABLE invoices;
IF OBJECT_ID('payroll', 'U') IS NOT NULL DROP TABLE payroll;
IF OBJECT_ID('teachers', 'U') IS NOT NULL DROP TABLE teachers;
IF OBJECT_ID('students', 'U') IS NOT NULL DROP TABLE students;
IF OBJECT_ID('users', 'U') IS NOT NULL DROP TABLE users;


-- Table for Users (Admin, Teacher, Student)
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(255) NOT NULL UNIQUE,
    password_hash NVARCHAR(255) NOT NULL, -- Store hashed passwords, not plain text
    email NVARCHAR(255) UNIQUE,
    full_name NVARCHAR(255),
    role NVARCHAR(50) NOT NULL CHECK (role IN ('admin', 'teacher', 'student', 'staff')),
    phone_number NVARCHAR(50),
    address NVARCHAR(MAX),
    profile_picture_url NVARCHAR(255),
    status NVARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Table for Students
CREATE TABLE students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT UNIQUE, -- Link to users table if student has a login
    full_name NVARCHAR(255) NOT NULL,
    father_name NVARCHAR(255),
    mother_name NVARCHAR(255),
    class NVARCHAR(50) NOT NULL,
    roll_no NVARCHAR(50) UNIQUE,
    aadhar_no NVARCHAR(20) UNIQUE,
    email NVARCHAR(255),
    phone_number NVARCHAR(50),
    status NVARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Table for Teachers
CREATE TABLE teachers (
    teacher_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT UNIQUE, -- Link to users table if teacher has a login
    full_name NVARCHAR(255) NOT NULL,
    subject NVARCHAR(100),
    classes_taught NVARCHAR(MAX), -- e.g., "Grade 9-10"
    email NVARCHAR(255),
    phone_number NVARCHAR(50),
    status NVARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Table for Payroll
CREATE TABLE payroll (
    payroll_id INT IDENTITY(1,1) PRIMARY KEY,
    payroll_period DATE NOT NULL, -- Stores the first day of the month (e.g., '2023-03-01')
    staff_count INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status NVARCHAR(20) DEFAULT 'processing' CHECK (status IN ('paid', 'processing', 'pending')),
    processed_by INT, -- User who processed the payroll
    processed_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (processed_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Table for Invoices (Finance Module)
CREATE TABLE invoices (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    invoice_number NVARCHAR(100) NOT NULL UNIQUE,
    invoice_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    status NVARCHAR(20) NOT NULL CHECK (status IN ('Paid', 'Pending', 'Overdue')),
    issued_to NVARCHAR(255), -- Could be student_id, parent_id, or general description
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Table for Notifications
CREATE TABLE notifications (
    notification_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT, -- Nullable if it's a general notification
    title NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    is_read BIT DEFAULT 0, -- 0 for FALSE, 1 for TRUE
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Table for Announcements
CREATE TABLE announcements (
    announcement_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    date_posted DATE DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Archived')),
    posted_by INT, -- User who posted the announcement
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (posted_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Table for Audit Logs
CREATE TABLE audit_logs (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    timestamp DATETIME DEFAULT GETDATE(),
    user_id INT,
    action NVARCHAR(255) NOT NULL,
    module NVARCHAR(100),
    details NVARCHAR(MAX),
    ip_address NVARCHAR(45),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Table for School Holidays (Calendar Module)
CREATE TABLE school_holidays (
    holiday_id INT IDENTITY(1,1) PRIMARY KEY,
    holiday_name NVARCHAR(255) NOT NULL,
    holiday_date DATE NOT NULL UNIQUE,
    description NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);

-- Table for System Settings
CREATE TABLE system_settings (
    setting_id INT IDENTITY(1,1) PRIMARY KEY,
    setting_key NVARCHAR(255) NOT NULL UNIQUE,
    setting_value NVARCHAR(MAX),
    description NVARCHAR(MAX),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Table for Roles (Conceptual, as permissions are hardcoded in HTML)
-- In a real application, this would be more granular.
CREATE TABLE roles (
    role_name NVARCHAR(50) PRIMARY KEY,
    description NVARCHAR(MAX)
);

-- Insert default roles
INSERT INTO roles (role_name, description) VALUES
('admin', 'Full access to all modules and settings.'),
('teacher', 'Manage students, grades, and attendance for assigned classes.'),
('student', 'View personal profile, grades, and school calendar.'),
('staff', 'General staff role with limited access.');

-- Table for Backups (Conceptual, as backups are file-based in HTML)
CREATE TABLE backups (
    backup_id INT IDENTITY(1,1) PRIMARY KEY,
    backup_date DATETIME DEFAULT GETDATE(),
    file_name NVARCHAR(255) NOT NULL,
    file_size_mb DECIMAL(10, 2),
    backup_type NVARCHAR(20) NOT NULL CHECK (backup_type IN ('Full', 'Incremental')),
    created_by INT,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Optional: Table for specific events if calendar events need to be stored in DB
CREATE TABLE calendar_events (
    event_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME,
    all_day BIT DEFAULT 0, -- 0 for FALSE, 1 for TRUE
    background_color NVARCHAR(7), -- Hex color code
    border_color NVARCHAR(7),     -- Hex color code
    description NVARCHAR(MAX),
    created_by INT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL
);