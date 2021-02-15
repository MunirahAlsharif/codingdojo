var Web3 = require('web3')

url = 'https://ropsten.infura.io/v3/4004ca0d6ff84b6e8f317707d64fee64';

var web3 = new Web3(url);

myaddress = '0xDa7BbA8a722E3b1599927D62C761aC1C6B8c59e2'

web3.eth.getBalance(myaddress , function(error, result) {
    var balance = result
    var ethBalance = web3.utils.fromWei(balance, 'ether');
    console.log('You have: ${ethBalance} ether');

});