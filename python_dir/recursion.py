def countdown(n):
    if n <= 0:
        print('Blastoff')
    else:
        print(n)
        countdown(n-1)

countdown(5)

def print_n(ss, n):
    if n <= 0:
        return
    print(ss)
    print_n(ss, n-1)

s = 'Python is good.'
n = 5
print_n(s, n)
