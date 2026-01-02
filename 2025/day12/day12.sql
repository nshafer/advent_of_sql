-- Using the archive_records table, search both the title and description fields
-- for the term "fly". Make sure that you also match for words like "flying",
-- "flight", etc. Boost the results where the term appears in the title and
-- lastly, rank the results by relevance (most relevant first). Provide the
-- elves the top 5 most relevant archived records back.

SELECT * FROM archive_records;

SELECT TO_TSQUERY('fly:*');
SELECT TO_TSVECTOR('fly flies flying flight');

SELECT 'this is fly text' @@ TO_TSQUERY('fly:*');
SELECT 'this is flies text' @@ TO_TSQUERY('fly:*');
SELECT 'this is flying text' @@ TO_TSQUERY('fly:*');
SELECT 'this is flight text' @@ TO_TSQUERY('fly:*');
SELECT 'this is flew text' @@ TO_TSQUERY('fly:*');

WITH search AS (SELECT *,
                       SETWEIGHT(TO_TSVECTOR(title), 'A') ||
                       SETWEIGHT(TO_TSVECTOR(description), 'B') AS vec
                FROM archive_records)

SELECT id, title, description, TS_RANK_CD(vec, TO_TSQUERY('fly:*')) AS rank
FROM search
WHERE vec @@ TO_TSQUERY('fly:*')
ORDER BY rank DESC, id DESC
LIMIT 5;