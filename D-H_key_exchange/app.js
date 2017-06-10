var User = (function () {
    function User(_message, _secretKey, _modulus, _base) {
        this.message = _message;
        this.secretKey = _secretKey;
        this.p = _modulus;
        this.g = _base;
        this.generatePublicKey();
    }
    User.prototype.generatePublicKey = function () {
        var temp = Math.pow(this.g.valueOf(), this.secretKey.valueOf());
        var A = temp % this.p.valueOf();
        this.publicKey = A;
    };
    User.prototype.getPublicKey = function () {
        return this.publicKey;
    };
    User.prototype.generateCommonSecretNumber = function (partnerPublicKey) {
        var temp = Math.pow(partnerPublicKey.valueOf(), this.secretKey.valueOf());
        var A = temp % this.p.valueOf();
        this.commonSecretNumber = A;
    };
    User.prototype.getCommonSecretNumber = function () {
        return this.commonSecretNumber;
    };
    return User;
}());
var modulus = 23;
var base = 7;
var Alice = new User("Hello Bob!", 6, modulus, base);
var Bob = new User("Hello Alice!", 15, modulus, base);
Alice.generateCommonSecretNumber(Bob.getPublicKey());
Bob.generateCommonSecretNumber(Alice.getPublicKey());
console.log("Alice's public key: " + Alice.getPublicKey());
console.log("Bob's public key: " + Bob.getPublicKey());
console.log("Common key Alice: " + Alice.getCommonSecretNumber());
console.log("Common key Bob: " + Bob.getCommonSecretNumber());
//# sourceMappingURL=app.js.map