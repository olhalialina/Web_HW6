--Знайти середній бал на потоці (по всій таблиці оцінок).

SELECT
    AVG(notes.note) AS average_total_score
FROM
    notes