//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.12;

contract Deployer {
    constructor() {
        bytes memory bytecode = hex"4347526038196020525947fd";
        assembly {
            return(add(bytecode, 0x20), mload(bytecode))
        }
    }
}
