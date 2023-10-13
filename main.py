import schedule
import time
import datetime


def job():
    print("任务执行", datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), flush=True)
    for j in range(20):
        time.sleep(1)


def main():
    print('开始运行任务......', datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), flush=True)
    schedule.every(10).seconds.do(job)

    i = 0
    while True:
        schedule.run_pending()
        time.sleep(1)

        i = i + 1
        print('开始计算......', i, flush=True)
        if i >= 100:
            break


if __name__ == '__main__':
    main()
