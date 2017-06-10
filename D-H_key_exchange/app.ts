class User {
    secretKey: Number;
    message: String;
    p: Number;
    g: Number;
    private publicKey: Number;
    private commonSecretNumber: Number;

    constructor(_message:String, _secretKey: Number, _modulus: Number, _base: Number) {
        this.message = _message;
        this.secretKey = _secretKey;
        this.p = _modulus;
        this.g = _base;
        this.generatePublicKey();
    }

    private generatePublicKey() {
        let temp = Math.pow(this.g.valueOf(), this.secretKey.valueOf());
        let A = temp % this.p.valueOf();
        this.publicKey = A;
    }

    public getPublicKey() {
        return this.publicKey;
    }

    public generateCommonSecretNumber(partnerPublicKey: Number) {
        let temp = Math.pow(partnerPublicKey.valueOf(), this.secretKey.valueOf());
        let A = temp % this.p.valueOf();
        this.commonSecretNumber = A;
    }

    public getCommonSecretNumber() {
        return this.commonSecretNumber;
    }

}

let modulus: Number = 23;
let base: Number = 7;


let Alice = new User("Hello Bob!", 6, modulus, base);
let Bob = new User("Hello Alice!", 15, modulus, base);
Alice.generateCommonSecretNumber(Bob.getPublicKey());
Bob.generateCommonSecretNumber(Alice.getPublicKey());

console.log("Alice's public key: " + Alice.getPublicKey());
console.log("Bob's public key: " + Bob.getPublicKey());

console.log("Common key Alice: " + Alice.getCommonSecretNumber());
console.log("Common key Bob: " + Bob.getCommonSecretNumber());
