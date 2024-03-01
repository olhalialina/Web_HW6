--Оцінки студентів у певній групі з певного предмета на останньому занятті.

SELECT
    students.group_id,
    lessons.lesson_name,
    notes.note,
    notes.date_of_note
FROM
    students
JOIN
    groups ON students.group_id = groups.id
JOIN
    notes ON students.id = notes.student_id
JOIN
    lessons ON notes.lesson_id = lessons.id

WHERE
    lessons.lesson_name = 'history' AND  --  the desired subject, to be replaced acc to specific needs
    students.group_id = '1' -- the desired group, to be replaced acc to specific needs
ORDER BY
    notes.date_of_note DESC
   
LIMIT 1;

--GROUP BY
--    students.group_id, lessons.lesson_name, notes.note
--ORDER BY
--    students.group_id, lessons.lesson_name, notes.note;