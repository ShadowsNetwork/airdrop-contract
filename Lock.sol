pragma solidity 0.5.15;

contract Lock {
    // address owner;
    // address unlockTime;
    constructor (address owner, uint256 unlockTime) public payable {
        assembly {
            sstore(0x00, owner)
            sstore(0x01, unlockTime)
        }
    }

    // Withdraw function once timestamp has passed unlock time
    function () external payable {
        assembly {
            switch gt(timestamp, sload(0x01))
            case 0 { revert(0, 0) }
            case 1 {
                switch call(gas, sload(0x00), balance(address), 0, 0, 0, 0)
                case 0 { revert(0, 0) }
            }
        }
    }
}
