// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

contract VerifiableOTP is AccessControlEnumerable {

    mapping(bytes32 => bool) public _answers;

    event OneTimePasscodeAnswerPublished(
        bytes32 answer
    );

    event OneTimePasscodeAnswerVerified(
        address verifiedBy,
        bytes32 answer
    );

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    function publishAnswer(bytes32 answer) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()));
        _answers[answer] = true;
        emit OneTimePasscodeAnswerPublished(answer);
    }

    function checkAnswer(string memory otp) external returns (bool) {
        require(bytes(otp).length == 64);

        bytes32 ans = keccak256(abi.encodePacked(otp));

        if (!_answers[ans]) {
            return false;
        }

        delete _answers[ans];
        emit OneTimePasscodeAnswerVerified(_msgSender(), ans);
        return true;
    }

}
