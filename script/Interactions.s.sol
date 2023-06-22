// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import{MoodNft} from "../src/MoodNft.sol";
contract MintBasicNft is Script{
    string public ipfsLinkCONN="ipfs://Qmc8JTtPFS7z4RG2v4jUXdFJ53x521aLt8QgaVS9U7HwA1/?filename=CONN.json";
    function run() external{
        address mostRecenltyDeployed= getLatestDeploy();
        mintNftonContract(mostRecenltyDeployed);
    }

    function mintNftonContract(address _contractAddr) public{
       vm.startBroadcast();
       BasicNft(_contractAddr).mintNft(ipfsLinkCONN);
       vm.stopBroadcast();
    }

    function getLatestDeploy() public  returns(address){
       return DevOpsTools.get_most_recent_deployment("BasicNft",block.chainid);
    }
}

contract MintMoodNft is Script{
    
    function run() external{
        address mostRecenltyDeployed= getLatestDeploy();
        mintMoodNft(mostRecenltyDeployed);
    }

    function mintMoodNft(address _contractAddr) public{
       vm.startBroadcast();
       MoodNft(_contractAddr).MintNft();
       vm.stopBroadcast();
    }

    function getLatestDeploy() public  returns(address){
       return DevOpsTools.get_most_recent_deployment("MoodNft",block.chainid);
    }
}

contract FlipMoodNft is Script{
    
    function run() external{
        address mostRecenltyDeployed= getLatestDeploy();
        flipMoodonNft(mostRecenltyDeployed);
    }

    function flipMoodonNft(address _contractAddr) public{
       vm.startBroadcast();
       MoodNft(_contractAddr).flipMood(0);
       vm.stopBroadcast();
    }

    function getLatestDeploy() public  returns(address){
       return DevOpsTools.get_most_recent_deployment("MoodNft",block.chainid);
    }
}