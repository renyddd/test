def capitalize_all(t):
    res = []
    for item in t:
        res.append(item.capitalize())
    return res

def only_upper(t):
    res = []
    for item in t:
        if item.isupper():
            res.append(item)
    return res

def nested_sum(t):
    res = 0
    for item in t:
        if isinstance(item, list):
            res += nested_sum(item)
        else:
            res += item
    return res

def cumsum(t):
    sum_list = []
    for i in range(len(t)):
        sum_item = 0
        for j in range(i):
            sum_item += t[j]
        sum_list.append(sum_item)
    return sum_list


a = ['H', 'e', 'l', 'L', 'o']
h = [1, 2, [3, 4], 5]
b = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# print(capitalize_all(a))
# print(only_upper(a))
# print(nested_sum(h))
print(cumsum(b))
