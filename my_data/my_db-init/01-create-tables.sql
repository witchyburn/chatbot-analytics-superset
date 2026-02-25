\c dash_data test;

CREATE TABLE IF NOT EXISTS results (
    id SERIAL PRIMARY KEY,
    dialog_id UUID,
    dt DATE,
    result VARCHAR(30), 
    subject VARCHAR(255),
    group_name VARCHAR(255),
    operator VARCHAR(30)
);

CREATE INDEX IF NOT EXISTS idx_dialog_id ON results(dialog_id);
CREATE INDEX IF NOT EXISTS idx_dt ON results(dt);

CREATE TABLE IF NOT EXISTS dialogs (
    id SERIAL PRIMARY KEY,
    dialog_id UUID,
    user_id UUID,
    time_stamp BIGINT,
    button VARCHAR, 
    msg_text VARCHAR,
    ts TIMESTAMP WITHOUT TIME ZONE
);

CREATE INDEX IF NOT EXISTS idx_dialog_id_dialogs ON dialogs(dialog_id);
CREATE INDEX IF NOT EXISTS idx_ts_dialogs ON dialogs(ts);

\copy results(dialog_id, dt, result, subject, group_name, operator) FROM '/docker-entrypoint-initdb.d/results.csv' DELIMITER ';' CSV HEADER;
\copy dialogs(dialog_id, user_id, time_stamp, button, msg_text, ts) FROM '/docker-entrypoint-initdb.d/dialogs.csv' DELIMITER ';' CSV HEADER;