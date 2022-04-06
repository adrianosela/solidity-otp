// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

contract VerifiableOTP is AccessControlEnumerable {

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

}
