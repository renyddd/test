fin = open('words.txt')

def get_words():
        line = fin.readline()
        word = line.strip()
        return word

def more_than_20_words():
    for item in fin:
        word = get_words()
        if len(word) >= 20:
            print(word)

def has_no_e():
    for item in fin:
        word = get_words()
        if word.find('e') > 0:
            pass
        else:
            print(word)

# more_than_20_words()
# has_no_e()
