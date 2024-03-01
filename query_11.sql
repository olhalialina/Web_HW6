--Середній бал, який певний викладач ставить певному студентові.

SELECT
    teachers.teacher_name,
    students.student_name,
    AVG(notes.note) AS avarage_score
FROM
    teachers
JOIN
    lessons ON teachers.id = lessons.teacher_id
JOIN
    notes ON lessons.id = notes.lesson_id
JOIN
    students ON notes.student_id = students.id

WHERE
    LOWER(students.student_name) = 'darren garza' AND  --  the desired student, to be replaced acc to specific needs
    teachers.teacher_name LIKE '%Wood%' -- the desired teacher, to be replaced acc to specific needs
;