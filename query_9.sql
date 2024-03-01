--Знайти список курсів, які відвідує студент.

SELECT
    students.id AS student_id,
    students.student_name,
    lessons.lesson_name
FROM
    students
JOIN
    notes ON students.id = notes.student_id
JOIN
    lessons ON notes.lesson_id = lessons.id
ORDER BY
    students.student_name, lessons.lesson_name;