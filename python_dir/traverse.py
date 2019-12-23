index = 0
fruits = 'apple and banana'

while index < len(fruits):
    letter = fruits[index]
    print(letter)
    index = index + 1

prefixes = 'JKLMNOPQ'
suffix = 'ack'
for letter in prefixes:
    print(letter + suffix)

def count_a(str_n, key_world):
    sum_a = 0
    for letter in str_n:
        if letter == key_world:
            sum_a = sum_a + 1
    return sum_a

print(count_a('aaaab', 'a'))

def in_both(word1, word2):
    for letter in word1:
        if letter in word2:
            print(letter)

in_both('apple', 'bananal')
