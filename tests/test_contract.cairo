use array::ArrayTrait;
use result::ResultTrait;
use option::OptionTrait;
use traits::TryInto;
use starknet::ContractAddress;
use starknet::Felt252TryIntoContractAddress;

use snforge_std::{declare, PreparedContract, deploy};

use meat_raffle::IMeatRaffleSafeDispatcher;
use meat_raffle::IMeatRaffleSafeDispatcherTrait;

fn deploy_contract(name: felt252) -> ContractAddress {
    let class_hash = declare(name);
    let prepared = PreparedContract {
        class_hash, constructor_calldata: @ArrayTrait::new()
    };
    deploy(prepared).unwrap()
}

#[test]
fn test_ticket_price() {
    let contract_address = deploy_contract('MeatRaffle');

    let safe_dispatcher = IMeatRaffleSafeDispatcher { contract_address };

    // let price_before = safe_dispatcher.get_ticket_price().unwrap();
    // assert(price_before == 0, 'Invalid default price');

    // safe_dispatcher.set_ticket_price(100).unwrap();

    // TODO: The current raffle needs to finish before this becomes the current ticket price.
    // let price_after = safe_dispatcher.get_ticket_price().unwrap();
    // assert(price_after == 100, 'Invalid price after setting');
}

#[test]
fn test_cannot_buy_zero_tickets() {
    let contract_address = deploy_contract('MeatRaffle');

    let safe_dispatcher = IMeatRaffleSafeDispatcher { contract_address };

    // let tickets_before = safe_dispatcher.get_tickets().unwrap();
    // assert(tickets_before == 0, 'Invalid balance');

    // match safe_dispatcher.buy_tickets(0) {
    //     Result::Ok(_) => panic_with_felt252('Should have panicked'),
    //     Result::Err(panic_data) => {
    //         assert(*panic_data.at(0) == 'Count cannot be 0', *panic_data.at(0));
    //     }
    // };
}
