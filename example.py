#!/usr/bin/python

import requests


url = 'https://passer.smu.edu/api'
# fields: pdb, chain, model
data = {"pdb": "5DKK", "chain": "A"}

results = requests.post(url, data=data)
print(esults.json())
