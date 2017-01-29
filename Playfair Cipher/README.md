# Playfair en/decrypter

A [Playfair cipher](https://en.wikipedia.org/wiki/Playfair_cipher) based en/decoder program. The original 5×5 table is extended to 6×6, includes every letter of the english alphabet, and numbers as well (no more I/J confusion). The encryption key also accepts numbers.

### Original (5×5) table

|   |   |   |     |   |
|:-:|:-:|:-:|:---:|:-:|
| A | B | C | D   | E |
| F | G | H | I/J | K |
| L | M | N | O   | P |
| Q | R | S | T   | U |
| V | W | X | Y   | Z |
|   |   |   |     |   |

### Extended (6×6) table with numbers

|   |   |   |   |   |   |
|:-:|:-:|:-:|:-:|:-:|:-:|
| A | B | C | D | E | F |
| G | H | I | J | K | L |
| M | N | O | P | Q | R |
| S | T | U | V | W | X |
| Y | Z | 0 | 1 | 2 | 3 |
| 4 | 5 | 6 | 7 | 8 | 9 |
|   |   |   |   |   |   |
