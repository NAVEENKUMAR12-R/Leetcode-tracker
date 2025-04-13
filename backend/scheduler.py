from apscheduler.schedulers.background import BackgroundScheduler
from database import save_daily_count
from leetcode import get_recent_submissions, count_today_solved

# Replace or load usernames from a file or DB
tracked_users = ["aravindhbalaji04", "Naveen-1212", "tourist"]

def update_all_users():
    print("Running scheduled job to update user stats...")
    for user in tracked_users:
        subs = get_recent_submissions(user)
        count = count_today_solved(subs)
        save_daily_count(user, count)

def start_scheduler():
    scheduler = BackgroundScheduler()
    scheduler.add_job(update_all_users, 'cron', hour=0, minute=0)  # 12 AM UTC
    scheduler.start()
