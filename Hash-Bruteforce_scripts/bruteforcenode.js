var http = require('http');
var crypto = require('crypto');

http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    main(res);

}).listen(9999);


function bruteForce(hash, hashtype, wordLength, characterSet) {
    var results = [];
    // if it is decrypted at all, or not
    var decrypted = false;
    // number of tries
    var noWords = 0;

    var currentTextWord;

    for (var i = 0; i < wordLength; i++) {
        // the current word we are attacking with
        var currentWord = new Array(i+1);

        // initial values for each letter (the first letter in the characterSet)
        for (var j = 0; j < currentWord.length; j++) {
            currentWord[j] = 0;
        }

        // j = the current character we are changing
        for (var j = currentWord.length-1; j >= 0; j--) {

            // trying every single character in the characterSet for this specific letter
            for (var k = 0; k < characterSet.length; k++) {

                currentTextWord = pointerToWord(currentWord, characterSet).join("");

                // TODO: hashing in the condition ( hash($hashtype, $currentTextWord) == $hash )
                var _hashToTry = crypto.createHash(hashtype).update(currentTextWord).digest("hex");
                if (_hashToTry === hash) {
                    decrypted = true;

                    results[0] = decrypted;
                    results[1] = currentTextWord;
                    results[2] = noWords;

                    return results;
                }

                noWords +=1;
                currentWord[j] += 1;

            }

            var ready = false;
            for (var k = j; k >= 0; k--) {
                if ( currentWord[k] >= characterSet.length-1 ) {
                    currentWord[k] = 0;
                    ready = true;
                } else {
                    currentWord[k] +=1;
                    j += 1;
                    ready = false;
                    break;
                }
            }

            if (ready) {
                break;
            }

        }

    }

    results[0] = decrypted;
    results[1] = currentTextWord;
    results[2] = noWords;

    return results;


}

function pointerToWord(array, charSet) {
    var wordarray = [];
    for (var i = 0; i < array.length; i++) {
        wordarray.push( charSet[array[i]] );
    }
    return wordarray;
}


function main(res) {

    var wordLength = 4;
    characterSet = "0123456789abcdefghijklmnopqrstuvwxyz".split("");
    var hash = "9756b18c0227354990c1632a416656f7bedc196b1";
    var hashtype = "sha1";

    res.write( "Hash to be decrypted: " + hash + "\n");
    res.write( "Character set: " + characterSet.join("") + "\n");

    var startTime = new Date();
    var result = bruteForce(hash, hashtype, wordLength, characterSet);
    var endTime = new Date();

    var decrypted = result[0];
    var decryptedText = result[1];
    var noWords = result[2];
    var deltaTime = (endTime-startTime)/1000;

    if (decrypted) {
        res.write("Decrypted text: " + decryptedText + "\n");
        res.write("Successfully decrypted after " + noWords + " tries and " + deltaTime +  " seconds \n");
    } else {
        res.write("Decryption failed after " + noWords + " tries and " + deltaTime +  " seconds  \n");
    }

    res.end();
}
