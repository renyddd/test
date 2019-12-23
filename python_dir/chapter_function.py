def print_lyrics():
    print("Hello, world.")
    print("I work all day.")

def repeat_lyrics():
    print_lyrics()
    print_lyrics()

repeat_lyrics()

def print_twice(name):
    print(name)
    print(name)

print_twice('Bruce ')

def cat_twice(part1, part2):
    cat = part1 + part2
    print_twice(cat)

cat_twice("hello", "_world")
