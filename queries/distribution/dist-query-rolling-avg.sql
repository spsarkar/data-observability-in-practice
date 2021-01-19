.headers on

WITH NULL_RATES AS(
  SELECT
    DATE_ADDED,
    CAST(SUM(CASE WHEN AVG_TEMP IS NULL THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS AVG_TEMP_NULL_RATE
  FROM
    EXOPLANETS
  GROUP BY
    DATE_ADDED
),

NULL_WITH_AVG AS(
  SELECT
    *,
    AVG(AVG_TEMP_NULL_RATE) OVER (
      ORDER BY DATE_ADDED ASC
      ROWS BETWEEN 14 PRECEDING AND CURRENT ROW) AS TWO_WEEK_ROLLING_AVG
  FROM
    NULL_RATES
  GROUP BY
    DATE_ADDED
)

SELECT
  *
FROM
  NULL_WITH_AVG
WHERE
  AVG_TEMP_NULL_RATE - TWO_WEEK_ROLLING_AVG > 0.3;