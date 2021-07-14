#!/usr/bin/python

import sys
import json
import svgwrite

# w
# w2
# h
# h2
# t = legend color
# f = legend size
# A\nG\nC\nI\nJ\nL\nD\nF\nB\nE\nH\nK
# 
# A B C    
# D E F    
# G H I    
# J K L    
#          
# A = Top    Left
# G = Bottom Left
# C = Top    Right
# I = Bottom Right
# J = Front  Left
# L = Front  Right
# D = Center Left
# F = Center Right
# B = Top    Center
# E = Center Center
# H = Bottom Center
# K = Front  Center
#
path = sys.argv[0]
with open(path, "r") as read_file:
    data = json.load(read_file)

dwg = svgwrite.Drawing(height='297mm', width='210mm')

dwg.add(dwg.line((0, 0), (10, 0), stroke=svgwrite.rgb(10, 10, 16, '%')))
dwg.add(dwg.text('Test', insert=(0, 0.2), fill='red'))
dwg.save()
