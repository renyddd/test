class Student(object):

#    def __init__(self, name, score):
#        self.name = name
#        self.score = score

        
    def __init__(self, name, score):
        self.__name = name
        self.score = score

    def get_name(self):
        return self.__name

    def print_score(self):
        print('%s: %s' % (self.__name, self.score))

    def set_name(self, name):
        self.__name = name

    def get_grade(self):
        if self.score > 90:
            return 'A'
        else:
            return '&'
