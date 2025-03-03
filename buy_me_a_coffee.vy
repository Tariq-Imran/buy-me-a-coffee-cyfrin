# Get frunds from users
# Withdraw Funds
# Set a minimum funding value in USD

# pragma version 0.4.0
# @ license MIT
# @ title Buy me a Coffee 
# @Auther: Imran
# @ notice This contract is for creating a sample funding contract

# We'll learn a new way to do interfaces later... 
 
interface AggregatorV3Interface:
    def decimals() -> uint8: view
    def description() -> String[1000]: view 
    def version() -> uint256: view
    def latestAnswer() -> int256: view

minimum_usd: uint256 
price_feed: AggregatorV3Interface
# Constant and Immutables

#MINIMUM_USD: public(constant(uint256)) = as_wei_value(5,"ether")
#PRICE_FEED: public(immutable(AggregatorV3Interface)) 
#OWNER: public(immutable(address))
#PRECISION: constant(uint256) = 1*(10**18)

# 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

# Storage
funders: public(DynArray[address, 1000])
funder_to_amount_funded: public(HashMap[address, uint256])

@deploy
def __init__(price_feed: address):
    self.minimum_usd = as_wei_value(5, "ether")
    self.price_feed = AggregatorV3Interface(price_feed)

#PRICE_FEED = AggregatorV3Interface(price_feed)

#OWNER: msg.sender

@external
@payable
def fund():
    #self._fund()
    usd_value_of_eth: uint256 = self._get_eth_to_usd_rate(msg.value)
    assert usd_value_of_eth >= self.minimum_usd, "You must spend more ETH!"

    #assert msg.value == as_wei_value(1, "ether"), "You must spend more ETH!"

#@internal
#@payable
#def _fund():
    #usd_value_of_eth: uint256 = self._get_eth_to_usd_rate(msg.value)
    #assert usd_value_of_eth >= MINIMUM_USD, "You must Sspend more ETH"

# Allows users to send $ to this contract
#  Have a minimum $ amount to send
# How do we convert the ETH amount to dollars amount?

@external
def withdraw():
    pass 

@internal 
@view
def _get_eth_to_usd_rate(eth_amount: uint256) -> uint256:
    
    price: int256 = staticcall self.price_feed.latestAnswer()
    eth_price: uint256 = (convert(price, uint256)) * (10**18)
    eth_amount_in_usd: uint256 = (eth_amount * eth_price) // (1 * (10**18))
    return eth_amount_in_usd


@external 
@view
def get_eth_to_usd_rate(eth_amount: uint256) -> uint256:
    return self._get_eth_to_usd_rate(eth_amount)

# Integer Division
@external
@view
def divide_me(number: uint256) -> uint256:
    return number//3

