-- Todo
CREATE TABLE IF NOT EXISTS Todos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    status INT,
    due_date DATETIME,
    create_at DATETIME,
    update_at DATETIME
);