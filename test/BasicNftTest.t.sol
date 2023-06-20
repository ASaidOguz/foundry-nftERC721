// SPDX-License-Identifier: MIT


pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test{
DeployBasicNft public deployBasicNft;
BasicNft public basicNft;
string public name="ConanTheBarbarian";
string public symbol="CONN";
string public ipfsLinkCONN="ipfs://Qmc8JTtPFS7z4RG2v4jUXdFJ53x521aLt8QgaVS9U7HwA1/?filename=CONN.json";
address public USER=makeAddr("user");
function setUp()public{
   deployBasicNft=new DeployBasicNft();
   basicNft=deployBasicNft.run();
}
//strings r represented as array of bytes
//so we cant compare it 
//we can compare primitive types=> uint,address,bool....
function testNameisCorrect()public view{
//! first check with correct --> second check with incorrect;
string memory incorrectName="ConanTheBarbaria";    
assert(keccak256(abi.encodePacked(name))==keccak256(abi.encodePacked(basicNft.name())));
assert(keccak256(abi.encodePacked(incorrectName))!=keccak256(abi.encodePacked(basicNft.name())));
}
function testCanMintandHaveBalance()public{
    
   vm.prank(USER);
   basicNft.mintNft(ipfsLinkCONN);
   assert(basicNft.balanceOf(USER)==1);
   assert(keccak256(abi.encodePacked(basicNft.tokenURI(0)))==keccak256(abi.encodePacked(ipfsLinkCONN)));
}

}


/*//! You can use abi.encodePacked to tightly pack multiple values, including strings,
 and then compute the hash of the packed data. This approach can be useful when you want
  to compare the hashes of large or variable-length strings without worrying 
  about potential storage fragmentation issues. 
  */