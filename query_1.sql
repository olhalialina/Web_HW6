--Знайти 5 студентів із найбільшим середнім балом з усіх предметів.

SELECT
    student_average.student_id,
    students.student_name,
    AVG(student_average.average_score) AS overall_average_score
FROM (
    SELECT
        students.id AS student_id,
        AVG(notes.note) AS average_score
    FROM
        students
    JOIN
        notes ON students.id = notes.student_id
    GROUP BY
        students.id
) student_average
JOIN
    students ON student_average.student_id = students.id
GROUP BY
    student_average.student_id, students.student_name
ORDER BY
    overall_average_score DESC
LIMIT 5;