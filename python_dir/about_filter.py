def is_odd(n):
    return n % 2 == 1

print(list(filter(is_odd, [1,2,3,4,5])))

def not_empty(s):
    return s and s.strip()

print(list(filter(not_empty, ['a','','b',None,'c'])))
