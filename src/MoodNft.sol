// SPDX-License-Identifier: MIT


pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
contract MoodNft is ERC721{

    /**errors */
    error MoodNft__NotOwnerorApproved();
    //----------------------------------------

    /**state-variables */
    uint256 private s_tokenCounter;
    string private  s_sadSvgImageUri;
    string private  s_happySvgImageUri;
    //-----------------------------------------
    

    enum Mood{
        HAPPY,
        SAD
    }

    mapping(uint256=>Mood) private s_tokenIdtoMood;
    constructor(
        string memory _sadSvgImageUri,
        string memory _happySvgImageUri) 
        ERC721("Mood NFT","MN"){
        s_tokenCounter=0;
        s_happySvgImageUri=_happySvgImageUri;
        s_sadSvgImageUri=_sadSvgImageUri;
    }

    function MintNft()public{
        _safeMint(msg.sender,s_tokenCounter);
        s_tokenIdtoMood[s_tokenCounter]=Mood.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 _tokenId) public{
        if(!_isApprovedOrOwner(msg.sender,_tokenId)){
            revert MoodNft__NotOwnerorApproved();
        }
        if(s_tokenIdtoMood[_tokenId]==Mood.HAPPY){
            s_tokenIdtoMood[_tokenId]=Mood.SAD;
        }else{
             s_tokenIdtoMood[_tokenId]=Mood.HAPPY;
        }
    }

function _baseURI() internal pure override returns(string memory){
    return "data:application/json;base64,";
}
    function tokenURI(uint256 _tokenId) public view override returns(string memory){
       string memory imageURI;

       if(s_tokenIdtoMood[_tokenId]==Mood.HAPPY){
        imageURI=s_happySvgImageUri;
       }else{
        imageURI=s_sadSvgImageUri;
       }

       return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}