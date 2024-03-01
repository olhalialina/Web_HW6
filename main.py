import sqlite3
import faker
from random import randint, choice, sample

NUMBER_STUDENTS = 30
NUMBER_TEACHERS = 3
MAX_NOTES_PER_STUDENT = 20
fake_lessons = [
    "math",
    "english",
    "chemistry",
    "history",
    "computer science",
    "geography",
]
GROUPS = ["1131", "1161", "1132"]
notes = ["1", "2", "3", "4", "5"]

fake_data = faker.Faker()


def create_db():
    # читаємо файл зі скриптом для створення БД
    with open("script.sql", "r") as f:
        sql = f.read()

    # створюємо з'єднання з БД (якщо файлу з БД немає, він буде створений)
    with sqlite3.connect("HW_6.db") as con:
        cur = con.cursor()
        # виконуємо скрипт із файлу, який створить таблиці в БД
        cur.executescript(sql)


def generate_fake_data(
    NUMBER_STUDENTS,
    NUMBER_TEACHERS,
    fake_lessons,
    MAX_NOTES_PER_STUDENT,
) -> tuple():
    fake_students = []
    for _ in range(NUMBER_STUDENTS):
        fake_students.append(fake_data.name())

    fake_teachers = []
    for _ in range(NUMBER_TEACHERS):
        name = fake_data.name()
        degree = fake_data.suffix_nonbinary()
        full_name = f"{name}, {degree}"
        fake_teachers.append(full_name)

    # Ensure that each student has a maximum of 'MAX_NOTES_PER_STUDENT' notes
    fake_notes = []

    for student_id in range(1, NUMBER_STUDENTS):
        # Determine the number of notes for the current student
        num_notes_for_student = randint(1, min(MAX_NOTES_PER_STUDENT, len(notes)))

        # Randomly select notes for the current student
        selected_notes = sample(notes, num_notes_for_student)

        # Add the selected notes to the list with the corresponding student_id
        fake_notes.extend([(note, student_id) for note in selected_notes])

    # num_notes = randint(
    #     1, MAX_NOTES_PER_STUDENT * NUMBER_STUDENTS
    # )  # generating number of notes randomly within limit
    # for _ in range(num_notes):
    #     fake_notes.append(choice(notes))

    return fake_students, fake_teachers, fake_lessons, fake_notes


def prepare_data(fake_students, fake_teachers, fake_lessons, fake_notes) -> tuple():
    # preparing list of tuples:
    prepared_students = []
    for student in fake_students:
        prepared_students.append((student, randint(1, len(GROUPS))))

    prepared_teachers = []
    for teacher in fake_teachers:
        prepared_teachers.append((teacher,))

    prepared_lessons = []
    for lesson in fake_lessons:
        prepared_lessons.append((lesson, randint(1, len(fake_teachers))))

    prepared_groups = []
    for group in GROUPS:
        prepared_groups.append((group,))

    prepared_notes = []
    for el in fake_notes:
        note = el[0]
        student_id = el[1]
        prepared_notes.append(
            (
                note,
                fake_data.date(),
                student_id,
                randint(1, len(fake_lessons)),
            )
        )

    return (
        prepared_students,
        prepared_teachers,
        prepared_lessons,
        prepared_groups,
        prepared_notes,
    )


def insert_data_to_db(
    prepared_students,
    prepared_teachers,
    prepared_lessons,
    prepared_groups,
    prepared_notes,
) -> None:
    # connect to DB and get cursor to manipulate with DB:

    with sqlite3.connect("HW_6.db") as con:
        cur = con.cursor()

        sql_to_groups = """INSERT INTO groups(group_name)
                               VALUES (?)"""

        cur.executemany(sql_to_groups, prepared_groups)

        sql_to_students = """INSERT INTO students(student_name, group_id)
                               VALUES (?, ?)"""

        cur.executemany(sql_to_students, prepared_students)

        sql_to_teachers = """INSERT INTO teachers(teacher_name)
                               VALUES (?)"""
        cur.executemany(sql_to_teachers, prepared_teachers)

        sql_to_lessons = """INSERT INTO lessons(lesson_name, teacher_id)
                               VALUES (?, ?)"""
        cur.executemany(sql_to_lessons, prepared_lessons)

        sql_to_notes = """INSERT INTO notes(note, date_of_note, student_id, lesson_id)
                               VALUES (?, ?, ?, ?)"""
        cur.executemany(sql_to_notes, prepared_notes)

        # confirm changes to DB:
        con.commit()


if __name__ == "__main__":
    create_db()
    (
        prepared_students,
        prepared_teachers,
        prepared_lessons,
        prepared_groups,
        prepared_notes,
    ) = prepare_data(
        *generate_fake_data(
            NUMBER_STUDENTS,
            NUMBER_TEACHERS,
            fake_lessons,
            MAX_NOTES_PER_STUDENT,
        )
    )
    insert_data_to_db(
        prepared_students,
        prepared_teachers,
        prepared_lessons,
        prepared_groups,
        prepared_notes,
    )