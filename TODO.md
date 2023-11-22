# Design

## UI interactions

### Before participating

1. See the meat NFT that's up for grabs in the current raffle
    1. `get_current_prize()`
1. See what the prize value is in the current raffle
    1. `get_current_prize_value()`
1. See how many tickets remain to be sold before the current raffle runs
    1. `get_current_tickets_remaining()`
1. See the winners (identified by Stark ID or address) of all previous raffles
    1. `get_past_winners()`
1. See the prize NFTs of all previous raffles
    1. `get_past_prizes()`

### Admin interactions

1. Set the ticket price in ETH for the next raffle to start
    1. `set_next_ticket_price()`
1. Set the number of tickets for the next raffle to start
    1. `set_next_ticket_count()`
1. Set the run/stop boolean to control whether another raffle will start as soon as the last ticket for this one is sold
    1. `set_run()`
1. Contribute the NFT for the next raffle, or as many subsequent raffles as I like
    1. `push_prize()`

### Participation

1. Sign in with Starknet
1. See whether I won any of the previous raffles
    1. If so, show celebratory UX
1. Buy one or more tickets
    1. If I bought the last ticket, run the raffle
        1. Is generating a random number hard on Starknet?
        1. Yes, for high levels of randomness
        1. Maybe not, if we just base it on the has of the previous block?
    1. Suspenseful UX while the raffle runs

## Data structures

1. Ticket struct
    1. ID, auto incrementing integer, unique for this raffle only
    1. Holder (address, none for tickets not yet sold)
1. Raffle struct
    1. ID, auto incrementing integer
    1. Address of NFT depicting slab of meat
    1. Price per ticket in ETH or gwei
    1. Prize amount in ETH or gwei, equal to 99% of the price per ticket times the number of tickets
    1. List of ticket instances (sorted)
        1. Implementation: Cairo has no native support for storing arrays. We can write our own implementation of the Store trait for our custom types, but `LegacyMap` will be better performing if we know the keys.

## Storage

1. Admin user (address, same as deployer), `ContractAddress`.
1. List of raffle instances, current raffle last.
    1. But use a `LegacyMap` rather than an `Array`. Keys: raffle ID, values: Raffle instances.
1. List of NFT addresses to be used for subsequent raffle prizes.
    1. But use a `LegacyMap` rather than an `Array`. Keys: raffle ID, values: `ContractAddress` for the NFT.
1. Price per ticket in ETH or gwei for the next raffle to start, `u64`.
1. Number of tickets for the next raffle to start, `u8`.
1. Run/stop boolean for admin to control whether another raffle will start as soon as the last ticket for this one is sold, `bool`.
