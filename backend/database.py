import sqlite3
from datetime import datetime

DB_NAME = "leetcode.db"

def init_db():
    conn = sqlite3.connect(DB_NAME)
    c = conn.cursor()
    c.execute('''
        CREATE TABLE IF NOT EXISTS solved (
            username TEXT,
            date TEXT,
            solved_count INTEGER,
            PRIMARY KEY (username, date)
        )
    ''')
    conn.commit()
    conn.close()

def save_daily_count(username, count):
    conn = sqlite3.connect(DB_NAME)
    c = conn.cursor()
    today = datetime.utcnow().date().isoformat()
    c.execute('''
        INSERT OR REPLACE INTO solved (username, date, solved_count)
        VALUES (?, ?, ?)
    ''', (username, today, count))
    conn.commit()
    conn.close()

def get_today_count():
    conn = sqlite3.connect(DB_NAME)
    c = conn.cursor()
    today = datetime.utcnow().date().isoformat()
    c.execute('SELECT username, solved_count FROM solved WHERE date = ?', (today,))
    data = dict(c.fetchall())
    conn.close()
    return data
