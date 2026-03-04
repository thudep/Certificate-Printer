"通过邮件形式发送奖状"

import smtplib
import csv
from email.message import EmailMessage
from pathlib import Path

# 奖状所在文件夹
CERT_DIR = Path("../output")
# 配置信息
SENDER_FILE = Path("sender.txt")
RECEIVER_FILE = Path("receiver.csv")

def load_sender():
    "读取发件人信息"
    with open(SENDER_FILE, "r", encoding="utf-8") as f:
        lines = [line.strip() for line in f.readlines()]
    smtp_server = lines[0]
    smtp_port = int(lines[1])
    sender = lines[2]
    password = lines[3]
    return smtp_server, smtp_port, sender, password

def load_receivers():
    "读取收件人信息"
    receivers = {}
    with open(RECEIVER_FILE, newline='', encoding="utf-8") as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            name = row[0].strip()
            username = row[1].strip()
            receivers[name] = f"{username}@mails.tsinghua.edu.cn"
    return receivers

def parse_filename(file_path):
    "解析奖状文件名"
    name = file_path.stem
    parts = name.split("-")
    if len(parts) != 3:
        return None
    return parts  # 姓名, 赛事名, 奖项名

def build_message(sender, receiver, name, contest, award, file_path):
    "发送邮件"
    msg = EmailMessage()
    msg["Subject"] = f"{contest} 奖状"
    msg["From"] = sender
    msg["To"] = receiver

    content = f"""{name}同学：

恭喜你在{contest}中荣获{award}，请查收奖状。

-------------------------------
顺颂时祺 | Best Wishes

清华大学工程物理系学生科学与技术协会 | Student Association of Science and Technology, Department of Engineering Physics, Tsinghua University
Email: depsast@126.com
"""
    msg.set_content(content)

    with open(file_path, "rb") as f:
        msg.add_attachment(
            f.read(),
            maintype="application",
            subtype="pdf",
            filename=("utf-8", "", file_path.name)
        )

    return msg

def main():
    "程序入口"
    # 载入发信方与收信方信息
    smtp_server, smtp_port, sender, password = load_sender()
    receivers = load_receivers()
    # 找到所有奖状
    pdf_files = list(CERT_DIR.glob("*.pdf"))
    total = len(pdf_files)
    print(f"发现 {total} 个证书文件")
    success = 0
    # 发送所有奖状
    with smtplib.SMTP_SSL(smtp_server, smtp_port) as server:
        server.login(sender, password)
        for file_path in pdf_files:
            # 解析文件名
            parsed = parse_filename(file_path)
            if not parsed:
                print(f"[跳过] 文件名格式错误: {file_path.name}")
                continue
            name, contest, award = parsed
            # 找到收件人邮箱
            if name not in receivers:
                print(f"[跳过] 未找到收件人: {name}")
                continue
            receiver_email = receivers[name]
            # 发送邮件
            try:
                msg = build_message(sender, receiver_email, name, contest, award, file_path)
                server.send_message(msg)
                print(f"[成功] 已发送给 {name} ({receiver_email})")
                success += 1
            except Exception as e:
                print(f"[失败] {name}: {e}")

    print(f"发送完成: {success}/{total}")

if __name__ == "__main__":
    main()
