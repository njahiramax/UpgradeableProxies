// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BoxV2} from "../src/BoxV2.sol";

interface IUpgradableProxy {
    function upgradeTo(address newImplementation) external;
}

contract UpgradeBox is Script {
    function run() external returns (address) {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();

        address proxy = upgradeBox(mostRecentDeployment, address(newBox));
        return proxy;
    }

    function upgradeBox(address proxyAddress, address newBox) public returns (address) {
        vm.startBroadcast();
        IUpgradableProxy proxy = IUpgradableProxy(proxyAddress);
        proxy.upgradeTo(address(newBox));
        vm.stopBroadcast();

        return proxyAddress;
    }
}
