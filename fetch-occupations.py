import json
import urllib.request

base_url = 'https://en.wikipedia.org/w/api.php?' \
           'action=query&format=json&prop=links&pllimit=500&titles='


def get_links(title):
    resp = json.loads(urllib.request.urlopen(
        base_url + title.replace(" ", "%20"), timeout=10).read(
    ).decode().rstrip())["query"]["pages"]
    return resp[[k for k in resp.keys()][0]]["links"]


for l1 in get_links("Lists of occupations"):
    for l2 in get_links(l1["title"]):
        if not any(c in l2["title"] for c in [":", "List"]):
            print(l2["title"])
