// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Test,console} from "forge-std/Test.sol";
import{DeployMoodNft}from "../../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test{
DeployMoodNft public deployMoodNft;
function setUp()public{
deployMoodNft=new DeployMoodNft();
}

function testSvgToUri()public view{
    string memory expectedEncoded="data:image/svg+xml;base64,PHN2ZyAgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCI+PHRleHQgZmlsbD0iYmxhY2siIHg9IjAiIHk9IjE1Ij5IZXkgTWFkZSBCeSBNZSE8L3RleHQ+PC9zdmc+";
    string memory svg='<svg  xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text fill="black" x="0" y="15">Hey Made By Me!</text></svg>';

    string memory EncodedSvg=deployMoodNft.svgToUri(svg);
    assert(keccak256(abi.encodePacked(EncodedSvg))==keccak256(abi.encodePacked(expectedEncoded)));
}
}