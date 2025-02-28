# Get frunds from users
# Withdraw Funds
# Set a minimum funding value in USD

# pragma version 0.4.0
# @ license MIT
# @Auther: Imran

@external
@payable
def fund():
    assert msg.value == as_wei_value(1, "ether"), "You must spend more ETH!"

@external
def withdraw():
    pass 
