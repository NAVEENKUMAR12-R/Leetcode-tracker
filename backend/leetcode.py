import requests
from datetime import datetime

def count_today_solved(submissions):
    today = datetime.utcnow().date()
    count = 0
    for sub in submissions:
        try:
            if sub.get("statusDisplay") != "Accepted":
                continue
            ts = int(sub.get("timestamp", 0))
            date = datetime.utcfromtimestamp(ts).date()
            if date == today:
                count += 1
        except:
            continue
    return count


def get_recent_submissions(username):
    url = 'https://leetcode.com/graphql'
    headers = {
        'Referer': f'https://leetcode.com/{username}/',
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'
    }
    query = """
    query recentSubmissionList($username: String!) {
      recentSubmissionList(username: $username, limit: 20) {
        titleSlug
        timestamp
        statusDisplay
      }
    }
    """
    variables = {"username": username}
    response = requests.post(url, headers=headers, json={"query": query, "variables": variables})

    if response.status_code != 200:
        print(f"Error {response.status_code} for {username}: {response.text}")
        return []

    try:
        data = response.json()
        return data.get("data", {}).get("recentSubmissionList", []) or []
    except Exception as e:
        print(f"Failed to parse JSON for {username}: {e}")
        return []
