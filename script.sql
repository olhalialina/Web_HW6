-- Table: groups
DROP TABLE IF EXISTS groups;
CREATE TABLE groups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_name VARCHAR(30) UNIQUE NOT NULL
);

-- Table: students
DROP TABLE IF EXISTS students;
CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_name VARCHAR(30) UNIQUE NOT NULL,
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES groups (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- Table: teachers
DROP TABLE IF EXISTS teachers;
CREATE TABLE teachers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    teacher_name VARCHAR(30) UNIQUE NOT NULL
);

-- Table: lessons
DROP TABLE IF EXISTS lessons;
CREATE Table lessons (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    lesson_name VARCHAR(30) UNIQUE NOT NULL,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- Table: notes
drop table if EXISTS notes;
CREATE table notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    note INTEGER not NULL,
    date_of_note DATE not NULL,
    student_id INT,
    lesson_id INT,
    FOREIGN KEY (student_id) REFERENCES students (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
      
    FOREIGN KEY (lesson_id) REFERENCES lessons (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);