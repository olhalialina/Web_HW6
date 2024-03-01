--Знайти середній бал у групах з певного предмета.

SELECT
    groups.group_name,
    lessons.lesson_name,
    AVG(notes.note) AS average_score_in_group
FROM
    groups
JOIN
    students ON groups.id = students.group_id
JOIN
    notes ON students.id = notes.student_id
JOIN
    lessons ON notes.lesson_id = lessons.id
WHERE
    lessons.lesson_name = 'history'  --  the desired subject, to be replaced acc to specific needs
GROUP BY
    groups.id, groups.group_name, lessons.lesson_name
ORDER BY
    groups.group_name, average_score_in_group DESC;