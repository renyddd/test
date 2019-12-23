def histogram(s):
    d = dict()
    for c in s:
        if c not in d:
            d[c] = 1
        else:
            d[c] += 1
    return d

def print_hist(h):
    for c in h:
        print(c,': ', h[c])

def invert_dict(d):
    inverse = dict()
    for key in d:
        val = d[key]
        if val not in inverse:
            inverse[val] = [key]
        else:
            inverse[val].append(key)
    return inverse

some_worlds = 'hello world, my Name is Tommy.'
words = {'ab':434, 'aa':'dfdfd', 4:4}
print(histogram(some_worlds))
print_hist(words)
print(invert_dict(words))
print(invert_dict(histogram(some_worlds)))


known = {0:0, 1:1}
def fibonacci(n):
    if n in known:
        return known[n]
    res = fibonacci(n-1) + fibonacci(n-2)
    known[n] = res
    print(res)
    return res

fibonacci(7)





