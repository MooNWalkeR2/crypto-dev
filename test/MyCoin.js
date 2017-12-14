var MyCoin = artifacts.require("./MyCoin.sol");

contract("MyCoin",function(accounts){

    var john_addr = accounts[0];
    var sam_addr  = accounts[1];
    var kane_addr = accounts[2];

    it("should assert to true",function(){
        var my_coin;
        return MyCoin.deployed().then(function(instance){
            my_coin = instance;
            // To check the initial currency details
            return my_coin.currencyDetails.call();
        }).then(function(result){
            printDetails(result);
            // Transfer funds to another account
            my_coin.transfer(sam_addr,130,{from:john_addr});
            return my_coin.checkBalance.call({from: sam_addr});
        }).then(function (result) {
            console.log(" Sam's balance  : " + result );
            my_coin.burn(100,{from:john_addr});
            return my_coin.checkBalance.call({from:john_addr});
        }).then(function (result) {
            console.log(" John's balance : " + result);
            return my_coin.checkBalance.call({from: sam_addr});
        }).then(function (result) {
            console.log(" Sam's balance  : " + result );
        })
    })
});

function printDetails(result){
    console.log(" Currency    : " + result[0] + "\n" +
        " Symbol      : " + result[1] + "\n" +
        " Decimal     : " + result[2] + "\n" +
        " TotalSupply : " + result[3] + "\n");
}