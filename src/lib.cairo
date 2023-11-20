#[starknet::interface]
trait IMeatRaffle<TContractState> {
    // Reads
    fn get_ticket_price(self: @TContractState) -> felt252;
    fn get_tickets(self: @TContractState) -> felt252;
    fn get_tickets_total(self: @TContractState) -> felt252;

    // Writes:
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
        // Max 65_535 raffles ever
        id: u16,

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
        tickets: ArrayTrait::<Ticket>
    }

    #[storage]
    struct Storage {
        ticket_price_current: felt252, 
        ticket_price_next: felt252,
        tickets_by_number: LegacyMap::<u8, ContractAddress>
    }

    #[external(v0)]
    impl MeatRaffleImpl of super::IMeatRaffle<ContractState> {
        // Reads
        fn get_ticket_price(self: @ContractState) -> felt252 {
            self.ticket_price_current.read()
        }

        fn get_tickets(self: @ContractState) -> felt252 {
            // Return count of tickets this punter owns
            0
        }

        fn get_tickets_total(self: @ContractState) -> felt252 {
            // Return total count of tickets in raffle
            panic_with_felt252(35);
            0
        }

        // Writes
        fn set_ticket_price(ref self: ContractState, amount: felt252) {
            // TODO:
            //   only owner can call this
            //   price affects next raffle only
            //   current raffle retains current ticket price
            self.ticket_price_next.write(amount);
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
            //   send 1% of the value in the contract to the ower
            //   next ticket price overwrites current ticket price
            //   reset tickets_by_number to zeros
            panic_with_felt252(65);
        }
    }
}
