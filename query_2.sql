--Знайти студента із найвищим середнім балом з певного предмета.

SELECT
    students.id AS student_id,
    students.student_name,
    lessons.lesson_name,
    AVG(notes.note) AS average_score_in_lesson
FROM
    students
JOIN
    notes ON students.id = notes.student_id
JOIN
    lessons ON notes.lesson_id = lessons.id
WHERE
    lessons.lesson_name = 'geography'  -- the desired subject, to be replaced acc to specific needs
GROUP BY
    students.id, students.student_name, lessons.lesson_name
ORDER BY
    average_score_in_lesson DESC
LIMIT 1;