#!/usr/bin/python

from random_word import RandomWords

def main():
  r = RandomWords()
  l = r.get_random_words(
      minLength=4,
      maxLength=4,
  )
  f = open("brutewords.txt", "a")
  for w in l:
    f.write(w + "\n")
  f.close()


if __name__ == '__main__':
  main()
