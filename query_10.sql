--Список курсів, які певному студенту читає певний викладач.

SELECT
    lessons.lesson_name,
    students.student_name,
    teachers.teacher_name
FROM
    lessons
JOIN
    teachers ON lessons.teacher_id = teachers.id
JOIN
    notes ON lessons.id = notes.lesson_id
JOIN
    students ON notes.student_id = students.id

WHERE
    LOWER(students.student_name) = 'darren garza' AND  --  the desired student, to be replaced acc to specific needs
    teachers.teacher_name LIKE '%Wood%' -- the desired teacher, to be replaced acc to specific needs
GROUP BY
    lessons.lesson_name, students.student_name, teachers.teacher_name
ORDER BY
    lessons.lesson_name, students.student_name, teachers.teacher_name;