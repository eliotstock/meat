use starknet::ContractAddress;

#[starknet::interface]
trait IMeatRaffle<TContractState> {
    // Reads
    
    // fn get_ticket_price(self: @TContractState) -> felt252;
    // fn get_tickets(self: @TContractState) -> felt252;
    // fn get_tickets_total(self: @TContractState) -> felt252;

    // See the meat NFT that's up for grabs in the current raffle
    fn get_current_prize(self: @TContractState) -> ContractAddress;

    // See what the prize value is in the current raffle
    fn get_current_prize_value(self: @TContractState) -> u64;

    // See how many tickets remain to be sold before the current raffle runs
    fn get_current_tickets_remaining(self: @TContractState) -> u8;

    // See the winners (identified by Stark ID or address) of all previous raffles
    // fn get_past_winners(self: @TContractState) -> Array::<ContractAddress>;

    // See the prize NFTs of all previous raffles
    // fn get_past_prizes(self: @TContractState) -> Array::<ContractAddress>;

    // Writes
    fn set_ticket_price(ref self: TContractState, amount: felt252);
    fn buy_tickets(ref self: TContractState, count: felt252);
    fn run_raffle(ref self: TContractState);
}

#[starknet::contract]
mod MeatRaffle {
    use starknet::{get_caller_address, ContractAddress};

    #[derive(Drop, Serde, Copy, starknet::Store)]
    struct Ticket {
        // Max 255 tickets per raffle
        id: u8,

        // Holder of this ticket
        holder: ContractAddress
    }

    #[derive(Drop, Serde, Copy, starknet::Store)]
    struct Raffle {
        // Max 255 raffles ever
        id: u8,

        // Slab of raw meat
        prizeNft: ContractAddress,

        // Price of a single ticket
        pricePerTicketInGwei: u64,

        // Equal to 99% of the price per ticket times the number of tickets
        prizeAmountInGwei: u64,

        // List of tickets for this raffle, both sold and not yet sold
        // TODO: Fix: `error: Not a type`
        // Can't put Arrays in storage in Cairo. Consider using a LegacyMap
        // instead, and storing the length separately.
        // tickets: ArrayTrait::<Ticket>
    }

    #[storage]
    struct Storage {
        // Admin user address. Same as deployer.
        admin: ContractAddress,

        // Raffle instances, keyed by raffle ID (auto incrementing integer)
        raffles: LegacyMap::<u8, Raffle>,

        // Raffle prizes for both completed and upcoming raffles. Addresses of NFTs depicting the suculent meat.
        prizes: LegacyMap::<u8, ContractAddress>,

        // ticketPriceCurrent: felt252,

        // Price per ticket in gwei for the next raffle to start.
        nextRafflePricePerTicketInGwei: u64,

        // Number of tickets for the next raffle to start
        nextRaffleTicketCount: u64,

        // Run/stop boolean for admin to control whether another raffle will start as soon as the last ticket for this one is sold.
        run: bool

        // tickets_by_number: LegacyMap::<u8, ContractAddress>
    }

    #[external(v0)]
    impl MeatRaffleImpl of super::IMeatRaffle<ContractState> {
        // Reads
        
        // See the meat NFT that's up for grabs in the current raffle
        fn get_current_prize(self: @ContractState) -> ContractAddress {
            // TODO: Implement
            starknet::get_caller_address()
        }

        // See what the prize value is in the current raffle
        fn get_current_prize_value(self: @ContractState) -> u64 {
            0
        }

        // See how many tickets remain to be sold before the current raffle runs
        fn get_current_tickets_remaining(self: @ContractState) -> u8 {
            0
        }

        // See the winners (identified by Stark ID or address) of all previous raffles
        // fn get_past_winners(self: @ContractState) -> Array::<ContractAddress> {
        //     // TODO: Implement
        //     let mut a = ArrayTrait::<ContractAddress>::new();
        //     a.append(starknet::get_caller_address());

        //     a
        // }

        // See the prize NFTs of all previous raffles
        // fn get_past_prizes(self: @ContractState) -> Array::<ContractAddress> {
        //     // TODO: Implement
        //     let mut a = ArrayTrait::<ContractAddress>::new();
        //     a.append(starknet::get_caller_address());

        //     a
        // }

        // Writes
        fn set_ticket_price(ref self: ContractState, amount: felt252) {
            // TODO:
            //   only owner can call this
            //   price affects next raffle only
            //   current raffle retains current ticket price
            // self.ticket_price_next.write(amount);
        }

        fn buy_tickets(ref self: ContractState, count: felt252) {
            assert(count != 0, 'Count cannot be 0');

            // TODO:
            //   find the next available ticket
            //   find the remaining available ticket count
            //   assert that count is less than or equal to the number of remaining tickets to be sold
            //   set the owner of these tickets to the caller

            // self.balance.write(self.balance.read() + count);
        }

        fn run_raffle(ref self: ContractState) {
            // TODO:
            //   anyone can call this
            //   if some tickets remain to be sold, panic
            //   generate a random number between 0 and ticket count (watch for out by one error)
            //   pick a winner
            //   send them the NFT of the gorgeous meat
            //   send them 99% of the value in the contract
            //   send 1% of the value in the contract to the admin
            //   next ticket price overwrites current ticket price
            //   reset tickets_by_number to zeros
            panic_with_felt252(65);
        }
    }
}
