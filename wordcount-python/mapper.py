#!/usr/bin/env python

import sys
import json
import re

def read_input(file):
  global count
  count = 0

  for line in file:
    # do this "startwith" thing to skip empty lines
    if (line.startswith("{")):
      data = json.loads(line)
      # only look at normal tweet, not retweets
      if not data.get("retweeted_status"):
        count = count + 1
        text = json.dumps(data["text"])
        text = text.lower()
        text = re.sub('[^a-z]', ' ', text)
        text = text.split()
        for s in text:
          snippet = s.strip()
          # look for substring (han, hon, den, det, denna, denne, hen)
          if (("han" == snippet) or ("hon" == snippet) or("den" == snippet) or ("det" == snippet) or ("denna" == snippet) or ("denne" == snippet) or ("hen" == snippet)):
            yield snippet

def main(separator='\t'):

  # input comes from STDIN (standard input)
  data = read_input(sys.stdin)

  for word in data:
    print '%s%s%d' % (word, separator, 1)

  print '%s%s%d' % ("count", separator, count)

if __name__ == "__main__":
    main()