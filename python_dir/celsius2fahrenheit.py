num = input('输入温度数字，以 c 或 f 结尾表明摄氏度或华氏度：')

char = num[-1]
char = char.lower()
num = num[:-1]

try:
    res = float(num)
except ValueError:
    print('错误，输入数字以 c 或 f 结尾')
else:
    if char == 'c':
        print('%.1f摄氏度 = %.1f华氏度' % (res, (res * 1.8 + 32)))
    elif char == 'f':
        print('%.1f华氏度 = %.1f摄氏度' % (res, (res - 32) / 1.8))
    else:
        print('输入数字以 c 或 f 结尾')
