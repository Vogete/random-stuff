<?php
    // setting a maximum time for execution (in seconds). after the time is up, PHP will stop working, so for longer brute force attacks, use a larger number
    set_time_limit(300);

    /*
    Some hashes to try:
        3 letter words:
            9756b18c0227354990c1632a416656f7bedc196b
            21a16b953f24ccb74214ea71bde2cf82e624c99c
            1047b56881438260286a8e7a57e07c53445ceb19
            96bf23fbb5fc3acef31f0d7329c94431e108e06e
            dce81a26299c85e4c529c7c89a4881fa056a82c8
        4 letter words:
            9772b510d71cb9c98af17b7f18d90834c1ea2576
            f350d780ea8aaa48030b4db64f790c14dbcd757f
            5c318e8fdd1886df0f344efeddf2435b79bdc6c5
        5 letter words:
            03de6c570bfe24bfc328ccd7ca46b76eadaf4334
            aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d
            15cd14c170424af73ea8e38a1c2bab04ba82054e
            883c32ca1de7d6f1ea122a725e17487bb949d081
    */


    function bruteForce($hash, $hashtype, $wordLength, $characterSet)
    {
        $results = [];
        // if it is decrypted at all, or not
        $decrypted = false;
        // number of tries
        $noWords = 0;


        // i = number of characters we use in the attack
        for ($i=0; $i < $wordLength; $i++) {
            // the current word we are attacking with
            $currentWord = new SplFixedArray($i+1);

            // initial values for each letter (the first letter in the characterSet)
            for ($j=0; $j < count($currentWord); $j++) {
                $currentWord[$j] = 0;
            }

            // j = the current character we are changing
            for ($j=count($currentWord)-1; $j >= 0 ; $j--) {

                // trying every single character in the characterSet for this specific letter
                for ($k=0; $k < count($characterSet); $k++) {

                    // writing the current word code
                    // echo "| " . implode(" | ", (array)$currentWord) . " |<br>";

                    $currentTextWord = implode("", pointerToWord($currentWord, $characterSet));
                    if (hash($hashtype, $currentTextWord) == $hash) {
                        $decrypted = true;

                        $results[0] = $decrypted;
                        $results[1] = $currentTextWord;
                        $results[2] = $noWords;

                        return $results;
                    }

                    $noWords += 1;
                    $currentWord[$j] += 1;

                }

                $ready = false;
                for ($k=$j; $k >= 0; $k--) {
                    if ($currentWord[$k] >= count($characterSet)-1) {
                        $currentWord[$k] = 0;
                        $ready = true;
                    } else {
                        $currentWord[$k] +=1;
                        $j += 1;
                        $ready = false;
                        break;
                    }
                }


                if ($ready) {
                    break;
                }

            }

        }

        $results[0] = $decrypted;
        $results[1] = $currentTextWord;
        $results[2] = $noWords;
        return $results;
    }

    function pointerToWord($array, $charSet)
    {
        $wordarray = [];
        for ($i=0; $i < count($array); $i++) {
            array_push($wordarray, $charSet[$array[$i]]);
        }
        return $wordarray;
    }

    function generateAsciiCharSet()
    {
        // defining our character set (in our case lowercase english letters and numbers)
        $characterSet = [];
        for ($i=48; $i <= 122; $i++) {
            if (!($i >= 58 && $i<= 96)) {
                // converting an ascii value into a character
                $temp = chr($i);
                // pushing the character into our character set
                array_push($characterSet, $temp);
            }
        }
        return $characterSet;
    }


    // maximum length of the word we are looking for
    // a wordLength of 5 means that the script will try every 1, 2, 3, 4 and 5 character long combinations
    $wordLength = 5;

    $characterSet = generateAsciiCharSet();

    // the hash we want to bruteforce
    $hash = "9756b18c0227354990c1632a416656f7bedc196b1";
    // the type of hash we want to bruteforce
    $hashtype = "sha1";

    echo "Hash to be decrypted: " . $hash. "<br>";
    echo "Character set: " . implode("", (array)$characterSet) . "<br>";

    $startTime = microtime(true);
    $result = bruteForce($hash, $hashtype, $wordLength, $characterSet);
    $endTime = microtime(true);


    $decrypted = $result[0];
    $decryptedText = $result[1];
    $noWords = $result[2];
    $deltaTime = $endTime-$startTime;

    if ($decrypted) {
        echo "Decrypted text: " . $decryptedText . "<br>";
        echo "Successfully decrypted after " . $noWords . " tries and " . $deltaTime .  " seconds <br>";

    } else {
        echo "Decryption failed after " . $noWords . " tries and " . $deltaTime .  " seconds  <br>";
    }


?>
