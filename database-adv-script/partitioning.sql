-- Partition Booking table by start_date year
ALTER TABLE Booking
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p_before2020 VALUES LESS THAN (2020),
    PARTITION p_2020 VALUES LESS THAN (2021),
    PARTITION p_2021 VALUES LESS THAN (2022),
    PARTITION p_2022 VALUES LESS THAN (2023),
    PARTITION p_2023 VALUES LESS THAN (2024),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Test performance of date range query
EXPLAIN
SELECT *
FROM Booking
WHERE start_date BETWEEN '2021-01-01' AND '2021-12-31';

-- Performance Report:
-- Before partitioning: The query scanned the entire Booking table.
-- After partitioning: The query scans only the p_2021 partition, improving performance.
