.headers on

SELECT
  DATE_ADDED,
  CAST(
    SUM(
      CASE
        WHEN HABITABILITY IS 0 THEN 1
        ELSE 0
      END
    ) AS FLOAT) / COUNT(*) AS HABITABILITY_ZERO_RATE
FROM
  HABITABLES
GROUP BY
  DATE_ADDED;
