# Design

## UI interactions

### Before participating

1. See the meat NFT that's up for grabs in the current (or next) raffle
1. See what the prize value is in the current (or next) raffle
1. See if there's currently a raffle running or not
1. If so
    1. See how long it has to run
1. If not
    1. See how many tickets remain to be sold before the raffle starts

### Admin interactions

1. Set the ticket price in ETH
1. Set the number of tickets
1. Open the raffle for ticket sales
1. Contribute the NFT for the next raffle, or as many subsequent raffles as I like

### Participation

1. Sign in with Starknet
1. See whether I won any of the previous raffles
    1. If so, show celebratory UX
1. See the winners (identified by Stark ID or address) of all previous raffles
1. Buy one or more tickets
    1. If I bought the last ticket, run the raffle
    1. Suspenseful UX while the raffle runs

## State

1. Raffle class
    1. ID, auto incrementing integer
    1. Number of tickets in total
    1. Number of tickets sold
1. Ticket
    1. ID, auto incrementing integer, unique for this raffle only
    1. Holder (address)
    1. Raffle (optional, ownership could be in other direction)
1. Global
    1. ID of currently running raffle.
