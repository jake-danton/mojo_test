from combiner import Combiner

def main():
    var c = Combiner(0)

    for i in range(100):
        c = c.combine(i)
    
    print(c.val)