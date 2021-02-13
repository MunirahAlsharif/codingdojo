from flask import Flask, jsonify, request
# from flask_cors import CORS
from blockchain import Blockchain
from argparse import ArgumentParser

app = Flask(__name__)
# CORS(app)


@app.route('/', methods=['GET'])
def chian():
    chain = test.chain
    dictChain = [block.__dict__.copy() for block in chain]
    for dictBlock in dictChain:
        dictBlock['transactions'] = [tx.__dict__ for tx in dictBlock['transactions']]
    return jsonify(dictChain), 200


@app.route('/mine', methods=['POST'])
def mine():
    """ mine a block """
    "what I understand from Mr.Anwar, for mine block we need first check if is it empty or not then copy the block"
    "dicMB is dic Mine Block"
    MineBlock = test.addBlcok
    if MineBlock != None:
        dicMB = [tx.__dict__ for tx in MineBlock]
        result ={
            'mine a block': dicMB
        }
        return jsonify(result), 200
    else:
        result = {
            'Message': 'There is some issue'
        }
        return jsonify(result),500
    dicMB = [block.__dict__.copy() for block in MineBlock]


@app.route('/opentxs', methods=['GET'])
def opentxs():
    """ get the unconfirmed transactions or any transaction has not been included in a block """
    " use (for) cause we have multiple transaction also ensure this transaction is not empty "
    txs = test.unconfirmed
    if txs != None:
        dictTx = [tx.__dict__ for tx in txs]
        result = {
            'Transactions': dictTx
        }
        return jsonify(result), 200
    else:
        result = {
            'Message': 'There is no transaction!'
        } 
        "(500) meaning is from server side"
        return jsonify(result), 500  

@app.route('/sendtx', methods=['POST'])
def sendtx():
    """ send a transaction"""
    "(values) is sender,receiver,amount"
    values = request.get_json() 
    if not values:
        result = {
            'Message': 'There is no input!'
        }
        "(400) meaning client or customer fault"
        return jsonify(result), 400 
    reqKeys = ['sender','receiver', 'amount']
    if not all (key in values for key in reqKeys):
        result ={
            'Message' : 'There is a missing value'
        }
        return jsonify(result), 400
    sender = values ['sender']
    receiver = values ['receiver']  
    amount = values ["amount"]
    addTx = test.addTransaction(sender, receiver, amount) 
    if addTx != None:
        result = {
            'Transaction' :{
               'sender': values ['sender'],
               'receiver': values ['receiver'], 
               'amount': values ["amount"]
            }
        } 
        return jsonify(result),200
    else:
        result = {
            'Message': 'The transaction does not pass!'
        } 
        return jsonify(result), 500   


if __name__ == '__main__':
    ser = ArgumentParser()
    ser.add_argument('-p', '--port', default=8020)
    args = ser.parse_args()
    port = args.port
    test = Blockchain()
    app.run(debug=True, port=port)
