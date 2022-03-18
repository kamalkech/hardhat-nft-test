//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract MyContract is Ownable, ERC721URIStorage {
  using SafeMath for uint256;

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;
  struct tokenMetaData{
    uint tokenId;
    uint timeStamp;
    string tokenURI;
  }
  mapping(address => tokenMetaData[]) public ownershipRecord;

  mapping(address => uint) public balances;
  mapping(address => uint) public lockTime;

  event LogTransfer(address _from, address _to, uint256);

  constructor() ERC721 ("NFT-NAME", "NAME-SYMBOL") {}

  /*
   * @dev .....
   * @param _time lock time in seconds / datetime
   */
  function lockEther(uint256 _time) external payable {
    require(msg.sender != address(0));
    require(msg.value > 0);

    balances[msg.sender] += msg.value;
    lockTime[msg.sender] = block.timestamp + _time;
  }

  /*
   * @dev mint...
   */
  function withdraw() public {
    require(balances[msg.sender] > 0, "insufficient funds");
    require(block.timestamp > lockTime[msg.sender], "lock time has not expired");

    uint amount = balances[msg.sender];
    balances[msg.sender] = 0;

    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent, "Failed to send ether");
  }

  /*
   * @dev mint.....
   * @param recipient address
   */
  // function mintNFT(address recipient) onlyOwner public {
  //   require(owner()!= recipient, "Recipient cannot be the owner of the contract");

  //   uint256 newItemId = _tokenIds.current();
  //   _safeMint(msg.sender, newItemId);

  //   ownershipRecord[recipient].push(tokenMetaData(newItemId, block.timestamp, "https://miro.medium.com/max/1120/1*k_EY7dcLYB5Z5k8zhMcv6g.png"));

  //   _tokenIds.increment();
  // }

  /*
   * @dev mint.....
   * @param address recipient 
   * @param string tokenURI 
   */
  function mintNFT(address recipient, string memory tokenURI) public virtual payable {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    _safeMint(recipient, newItemId);
    _setTokenURI(newItemId, tokenURI);
  }
}