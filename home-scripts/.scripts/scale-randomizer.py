#!/usr/bin/python

import time
import random
import copy

def wait_secs(s):
  print()
  for i in range(s):
    print(str(i+1) + "…")
    time.sleep(1)

list_of_keys = ["Do", "Sol", "Re", "La", "Mi", "Si", "Fa♯", "Do♯", "Fa", "Si♭", "Mi♭", "La♭", "Re♭", "Sol♭", "Do♭"]


def main():
  list_of_keys_copy = copy.deepcopy(list_of_keys)
  counter = 1
  while True:
    if len(list_of_keys_copy) == 0:
      print()
      print("Circle completed! Starting over")
      print()
      list_of_keys_copy = copy.deepcopy(list_of_keys)
    current_position = random.randint(1, 9)
    current_key = random.choice(list_of_keys_copy)
    list_of_keys_copy.remove(current_key)
    print()
    print(str(current_position) + "° position, " + current_key)
    print()
    input("Press any key to continue...")

if __name__ == '__main__':
  main()
