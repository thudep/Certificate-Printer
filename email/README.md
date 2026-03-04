# email

用于把制作好的奖状通过科协邮箱发到获奖选手的清华邮箱中.

## 准备

首先需要准备发件人与收件人的信息, 包含 `sender.txt` 与 `receiver.csv` 两个文件:

### `sender.txt`

一共有四行内容, 依次为: `smtp服务器域名`, `smtp服务器端口`, `发件人邮箱`, `发件人客户端专用密码`. 例如:

```text
mails.tsinghua.edu.cn
465
qingxiaohua11@mails.tsinghua.edu.cn
0123456789ABCDEF
```

### `receiver.csv`

每行为一组姓名与邮箱用户名的映射, `@mails.tsinghua.edu.cn`会在脚本中补全. 例如:

```text
清小华,qingxiaohua11
华小清,huaxq11
```

## 运行

```bash
python3 send.py
```
