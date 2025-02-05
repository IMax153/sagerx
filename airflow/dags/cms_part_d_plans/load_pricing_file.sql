/* datasource.cms_pricing */
DROP TABLE IF EXISTS datasource.cms_pricing CASCADE;

CREATE TABLE datasource.cms_pricing (
contract_id           VARCHAR(5) NOT NULL,
plan_id         VARCHAR(3) NOT NULL,
segment_id      VARCHAR(3),
ndc  VARCHAR(11),
days_supply  TEXT,
unit_cost    TEXT
);

COPY datasource.cms_pricing
FROM '{{ ti.xcom_pull(task_ids='extract') }}/pricing file PPUF_{{params.year}}Q{{params.quarter}}.txt' DELIMITER '|' CSV HEADER;;
