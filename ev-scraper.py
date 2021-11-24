# archives.gov electoral vote scraper

import requests
from bs4 import BeautifulSoup as bs
import pickle

elec_vote_map = dict()

for y in range(1976, 2021, 4):
    print(y)
    uri = f'https://www.archives.gov/electoral-college/{y}'
    r = requests.get(uri)
    states = bs(r.text, 'html.parser').findAll('tbody')[1].findAll('tr')
    for i in range(2,53):
        cell_list = states[i].findAll('td')
        s, ev = cell_list[0].text.upper(), int(cell_list[1].text)
        elec_vote_map[(y,s)] = ev


pickle.dump(elec_vote_map, open('datasets/elec_vote_map.pkl', 'wb'))