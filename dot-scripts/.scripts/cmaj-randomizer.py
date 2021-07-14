#!/usr/bin/python

import copy
import pyttsx3
import time
import random
from signal import signal, SIGINT
from sys import exit

def selectNonEmptyString(dictionary):
    d = {}
    for key, val in dictionary.items():
        if len(val) > 0:
            d[key] = val
    return random.choice(tuple(d.keys()))

def fretboardToString(dictionary):
    for key, val in dictionary.items():
        rem_notes = len(val)
        print("note rimaste " + key + " corda: " + str(rem_notes))

def areValuesEmpty(dictionary):
    isEmpty = True
    #fretboardToString(dictionary)
    for key, val in dictionary.items():
        rem_notes = len(val)
        if rem_notes != 0:
            isEmpty = False
            break
    return isEmpty

def handler(signal_received, frame):
    # Handle any cleanup here
    print('SIGINT or CTRL-C detected. Exiting gracefully')
    exit(0)

class Note:
    def __init__(self, pitch, order):
        self.pitch = pitch
        self.order = order

fretboard = {
    "prima":[
        Note("fa", "primo"),
        Note("sol", "primo"),
        Note("la", "primo"),
        Note("si", "primo"),
        Note("do", "primo"),
        Note("re", "primo"),
        # Note("mi", "unico"),
        # Dopo il 12°
        # Note("fa", "secondo"),
        # Note("sol", "secondo"),
        # Note("la", "secondo"),
        # Note("si", "secondo"),
        # Note("do", "secondo"),
    ],
    "seconda":[
        Note("do", "primo"),
        Note("re", "primo"),
        Note("mi", "primo"),
        Note("fa", "primo"),
        Note("sol", "primo"),
        Note("la", "primo"),
        # Note("si", "unico"),
        # Dopo il 12°
        # Note("do", "secondo"),
        # Note("re", "secondo"),
        # Note("mi", "secondo"),
        # Note("fa", "secondo"),
        # Note("sol", "secondo"),
    ]
    # "terza":[
    #     Note("la", "primo"),
    #     Note("si", "primo"),
    #     Note("do", "primo"),
    #     Note("re", "primo"),
    #     Note("mi", "primo"),
    #     Note("fa", "primo"),
    #     # Note("sol", "unico"),
    #     # Dopo il 12°
    #     # Note("la", "secondo"),
    #     # Note("si", "secondo"),
    #     # Note("do", "secondo"),
    #     # Note("re", "secondo"),
    #     # Note("mi", "secondo"),
    # ],
    # "quarta":[
    #     Note("mi", "primo"),
    #     Note("fa", "primo"),
    #     Note("sol", "primo"),
    #     Note("la", "primo"),
    #     Note("si", "primo"),
    #     Note("do", "primo"),
    #     # Note("re", "unico"),
    #     # Dopo il 12°
    #     # Note("mi", "secondo"),
    #     # Note("fa", "secondo"),
    #     # Note("sol", "secondo"),
    #     # Note("la", "secondo"),
    #     # Note("si", "secondo"),
    # ],
    # "quinta":[
    #     Note("si", "primo"),
    #     Note("do", "primo"),
    #     Note("re", "primo"),
    #     Note("mi", "primo"),
    #     Note("fa", "primo"),
    #     Note("sol", "primo"),
    #     # Note("la", "unico"),
    #     # Dopo il 12°
    #     # Note("si", "secondo"),
    #     # Note("do", "secondo"),
    #     # Note("re", "secondo"),
    #     # Note("mi", "secondo"),
    #     # Note("fa", "secondo"),
    # ],
    # "sesta":[
    #     Note("fa", "primo"),
    #     Note("sol", "primo"),
    #     Note("la", "primo"),
    #     Note("si", "primo"),
    #     Note("do", "primo"),
    #     Note("re", "primo"),
    #     # Note("mi", "unico"),
    #     # Dopo il 12°
    #     # Note("fa", "secondo"),
    #     # Note("sol", "secondo"),
    #     # Note("la", "secondo"),
    #     # Note("si", "secondo"),
    #     # Note("do", "secondo"),
    # ]
}

def main():
  # TTS init and properties
  samantha = pyttsx3.init()
  # Italian voice
  voices = samantha.getProperty("voices")
  samantha.setProperty("voice", voices[36].id)
  dict_copy = copy.deepcopy(fretboard)
  print("Beginning in 5 seconds...")
  print()
  time.sleep(5)
  while True:
    if areValuesEmpty(dict_copy):
      print()
      msg = "Tastiera completata, ricominciamo? [y/N]: "
      samantha.say(msg)
      samantha.runAndWait()
      done = False
      dict_copy = copy.deepcopy(fretboard)
    curr_string = selectNonEmptyString(dict_copy)
    curr_note = random.choice(tuple(dict_copy[curr_string]))
    # Note e corde
    curr_text = str(curr_string + " corda: " + curr_note.pitch)
    # Note, corde e ordine
    # curr_text = str(curr_string + " corda, " + curr_note.order + " " + curr_note.pitch)
    dict_copy[curr_string].remove(curr_note)
    samantha.say(curr_text)
    print(curr_text)
    print()
    samantha.runAndWait()
    time.sleep(2)

if __name__ == '__main__':
    # Tell Python to run the handler() function when SIGINT is recieved
  #count = 0
  #for voice in voices:
      #print("Voice:")
      #print(" - count: %s" % count)
      #print(" - ID: %s" % voice.id)
      #print(" - Name: %s" % voice.name)
      #print(" - Languages: %s" % voice.languages)
      #print(" - Gender: %s" % voice.gender)
      #print(" - Age: %s" % voice.age) # Copy Dictionary
      #count+=1
    signal(SIGINT, handler)
    main()
