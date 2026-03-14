module become_whale::become_whale {
    use sui::coin::{Self, Coin};
    use sui::coin_registry;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct BWH has drop {}

    const TOTAL_SUPPLY: u64 = 68_686_868_866_888_886;

    fun init(witness: BWH, ctx: &mut TxContext) {
        let (mut currency, mut treasury_cap) = coin_registry::new_currency_with_otw(
            witness,
            0,
            b"BWH".to_string(),
            b"Become Whale".to_string(),
            b"Fixed supply. No extra mint. Free trading.".to_string(),
            b"".to_string(),
            ctx
        );

        let total_coin: Coin<BWH> = coin::mint(&mut treasury_cap, TOTAL_SUPPLY, ctx);

        currency.make_supply_fixed(treasury_cap);

        let metadata_cap = currency.finalize(ctx);

        let sender = tx_context::sender(ctx);
        transfer::public_transfer(total_coin, sender);
        transfer::public_transfer(metadata_cap, sender);
    }
}
