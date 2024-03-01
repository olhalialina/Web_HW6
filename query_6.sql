--Знайти список студентів у певній групі.

SELECT
    teachers.teacher_name,
    lessons.lesson_name
FROM
    lessons
JOIN
    teachers ON lessons.teacher_id = teachers.id
ORDER BY
    teachers.teacher_name;