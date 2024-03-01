--Знайти середній бал, який ставить певний викладач зі своїх предметів.

SELECT
    teachers.teacher_name,
    AVG(notes.note) AS average_score
FROM
    teachers
JOIN
    lessons ON teachers.id = lessons.teacher_id
JOIN
    notes ON lessons.id = notes.lesson_id
GROUP BY
    teachers.id, teachers.teacher_name
ORDER BY
    average_score DESC;