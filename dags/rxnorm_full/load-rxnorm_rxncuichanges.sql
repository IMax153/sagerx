/* datasource.rxnorm_rxncuichanges */

DROP TABLE IF EXISTS  datasource.rxnorm_rxncuichanges;

CREATE TABLE datasource.rxnorm_rxncuichanges (
      rxaui         varchar(8),
      code          varchar(50),
      sab           varchar(20),
      tty           varchar(20),
      str           varchar(3000),
      old_rxcui     varchar(8) not null,
      new_rxcui     varchar(8) NOT NULL,
      blank         TEXT
);

COPY datasource.rxnorm_rxncuichanges
FROM '{{ ti.xcom_pull(key='file_path',task_ids='get_rxnorm_full') }}/rrf/RXNCUICHANGES.RRF' with (delimiter '|', null '');
