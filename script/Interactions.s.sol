// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script{
    string public ipfsLinkCONN="ipfs://Qmc8JTtPFS7z4RG2v4jUXdFJ53x521aLt8QgaVS9U7HwA1/?filename=CONN.json";
    function run() external{
        address mostRecenltyDeployed=DevOpsTools.get_most_recent_deployment("BasicNft",block.chainid);
        mintNftonContract(mostRecenltyDeployed);
    }

    function mintNftonContract(address _contractAddr) public{
       vm.startBroadcast();
       BasicNft(_contractAddr).mintNft(ipfsLinkCONN);
       vm.stopBroadcast();
    }
}