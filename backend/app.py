import sqlite3
from flask import Flask, request

app = Flask(__name__)

def create_table():
    conn = sqlite3.connect("leetcode.db")
    cursor = conn.cursor()
    
    try:
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL UNIQUE,
            today_count INTEGER DEFAULT 0
        )
        ''')
        conn.commit()
        print("✅ Table created or already exists.")
    except Exception as e:
        print(f"❌ Error creating table: {e}")
    finally:
        conn.close()

# Create table when the app starts
create_table()

@app.route("/")
def home():
    return "✅ LeetCode Tracker is Running!"

@app.route("/users")
def list_users():
    conn = sqlite3.connect("leetcode.db")
    cursor = conn.cursor()

    try:
        cursor.execute("SELECT username, today_count FROM users")
        data = cursor.fetchall()
        return {"users": [{"username": row[0], "today_count": row[1]} for row in data]}
    except Exception as e:
        return {"error": f"Failed to fetch users: {str(e)}"}
    finally:
        conn.close()

@app.route("/solve_problem", methods=["POST"])
def solve_problem():
    data = request.json  # Expecting JSON data
    username = data.get("username")
    
    if not username:
        return {"error": "Username is required"}, 400
    
    conn = sqlite3.connect("leetcode.db")
    cursor = conn.cursor()

    try:
        # Increment the today_count for the specified user
        cursor.execute("UPDATE users SET today_count = today_count + 1 WHERE username = ?", (username,))
        conn.commit()
        
        if cursor.rowcount == 0:
            return {"error": "User not found"}, 404
        
        return {"message": f"✅ Problem solved! {username}'s count updated."}
    
    except Exception as e:
        return {"error": f"Failed to update count: {str(e)}"}, 500
    
    finally:
        conn.close()

def add_test_user(username, today_count):
    conn = sqlite3.connect("leetcode.db")
    cursor = conn.cursor()
    try:
        cursor.execute("INSERT INTO users (username, today_count) VALUES (?, ?)", (username, today_count))
        conn.commit()
        print(f"✅ User {username} added successfully!")
    except Exception as e:
        print(f"❌ Error adding user: {e}")
    finally:
        conn.close()

# Add a test user
add_test_user("aravindhbalaji04", 5)
add_test_user("Naveen-1212", 3)

# Example of how to call the new route:
# curl -X POST -H "Content-Type: application/json" -d '{"username": "aravindhbalaji04"}' http://127.0.0.1:5000/solve_problem

if __name__ == "__main__":
    app.run(debug=True)
