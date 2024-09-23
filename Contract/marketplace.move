module NftMarketplace::Marketplace {
    use aptos_framework::signer;
    use aptos_framework::token::{self, Token, TokenStore};
    use aptos_framework::collection::{self, Collection};

    struct NftCollection has key {
        owner: address,
        name: String,
        description: String,
        token_count: u64,
    }

    public fun create_collection(
        creator: &signer,
        name: String,
        description: String
    ): Collection {
        let collection = collection::create(creator, name, description);
        let collection_data = NftCollection {
            owner: signer::address_of(creator),
            name: name,
            description: description,
            token_count: 0,
        };
        move_to(creator, collection_data);
        collection
    }

    public fun show_collection(owner: address): (String, String, u64) {
        let collection_data = borrow_global<NftCollection>(owner);
        (collection_data.name, collection_data.description, collection_data.token_count)
    }

    public fun mint_nft(
        creator: &signer,
        collection: &mut Collection,
        metadata_uri: String
    ): Token acquires NftCollection {
        let token = token::create(creator, collection, metadata_uri, 1, true);
        let collection_data = borrow_global_mut<NftCollection>(signer::address_of(creator));
        collection_data.token_count = collection_data.token_count + 1;
        token
    }
}
