#!/usr/bin/env python
import random
import string
import sys

if len(sys.argv[1:])==0: 
    print("This script accepts restricted strings as an argument to generate random password") 
    print('Example: ./generate_random_string.py', '\'\'\.\"\"\{\}')
    sys.exit(1)
else:
    restricted_Strings = sys.argv[1]


punctuation_Strings = string.punctuation


# Functionto generation the random strings 
def random_string_generator(str_size, allowed_chars):
    return ''.join(random.choice(allowed_chars) for x in range(str_size))


# remove strings from the punctuation strings
no_punct = ""
for char in punctuation_Strings:
   if char in restricted_Strings:
       next
   else:
       no_punct = no_punct + char

chars = string.ascii_letters + string.digits + no_punct 

# Limiting the size between 8 to 10 Characters
size = random.randint(8,10) 

print("Random String of length", (size))
print(random_string_generator(size, chars))
