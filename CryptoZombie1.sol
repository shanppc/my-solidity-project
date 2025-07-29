// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    // Event: Emitted when a new zombie is created, allowing external applications to track new zombies.
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // Struct: Defines the data structure for a single Zombie, including its name and DNA.
    struct Zombie {
        string name;
        uint dna;
    }

    // Array: Stores all created Zombie structs. 'public' creates an automatic getter function.
    Zombie[] public zombies;

    // Internal function: Adds a new Zombie to the 'zombies' array and emits the NewZombie event.
    function _createZombie(string memory _name, uint _dna) private {
     uint id = zombies.push(Zombie(_name, _dna)) - 1; // 'push' adds to array, returns new length.
        emit NewZombie(id, _name, _dna); // Emits the event with the new zombie's details.
    }

    // Internal function: Generates a pseudo-random DNA value using keccak256 hash of a string.
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str))); // Generates a hash from the input string.
        return rand % dnaModulus; // Modulo ensures DNA fits within the defined digit length.
    }

    // Public function: Callable by anyone to create a new zombie with a random DNA based on the provided name.
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}