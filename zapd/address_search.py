import requests

NODE_ADDRESS = 'http://nodes.wavesnodes.com'
ZAP_WALLET = '3PCj4WTJ9abwYakwL4NBxiq1z4DmViFc5X3'
LIMIT_NO = 1000

addrs = {}

def find_addresses_via_transaction(node, wallet_address, limit, after=None):
    ASSETID = '9R3iLi4qGLVWKc16Tg98gmRvgg1usGEYd7SgC1W5D6HB'
    url = '%s/transactions/address/%s/limit/%s' % (node, wallet_address, limit)
    if after:
        url += '?after=%s' % after
    print(':: requesting %s..' % url)
    r = requests.get(url)
    if r.status_code != 200:
        print('ERROR: status code is %d' % r.status_code)
    txs = r.json()[0]
    print(':: retrieved %d records' % len(txs))
    for tx in txs:
        if (tx['assetId'] == ASSETID) & (tx['type'] == 4):
            if 'sender' in tx:
                sender = tx['sender']
                addrs[sender] = 1
            if 'recipient' in tx:
                recipient = tx['recipient']
                addrs[recipient] = 1

find_addresses_via_transaction(NODE_ADDRESS, ZAP_WALLET, LIMIT_NO)
