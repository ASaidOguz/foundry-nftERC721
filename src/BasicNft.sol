// SPDX-License-Identifier: MIT


pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//! used different approach then adding constructor,
contract BasicNft is ERC721{
   uint256 private s_tokenCounter;
   mapping(uint256=>string) private s_tokenIdtoUri;
  constructor() ERC721("ConanTheBarbarian","CONN"){
  s_tokenCounter=0;
  }

  function mintNft(string memory _tokenUri)public{
    s_tokenIdtoUri[s_tokenCounter]=_tokenUri;
    _safeMint(msg.sender,s_tokenCounter);
    s_tokenCounter++;
  }

  function tokenURI(uint256 _tokenId) public view override returns(string memory){
      return s_tokenIdtoUri[_tokenId];
  }


}