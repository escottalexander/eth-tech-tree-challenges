// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { console2 } from "../lib/forge-std/src/console2.sol";
import { Voting } from "./Voting.sol";

contract DecentralizedResistanceToken is ERC20, Ownable(msg.sender) {
  address public votingContract;

  constructor(
    uint256 initialSupply
  ) ERC20("DecentralizedResistanceToken", "DRT") {
    _mint(msg.sender, initialSupply);
  }

  function setVotingContract(
    address _votingContract
  ) external onlyOwner {
    votingContract = _votingContract;
  }

  function _update(address from, address to, uint256 amount) internal override {
    if (votingContract != address(0) && from != address(0)) {
      Voting(votingContract).removeVotes(from);
    }
    super._update(from, to, amount);
  }
}
