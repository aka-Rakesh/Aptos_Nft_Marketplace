# Aptos NFT Marketplace

## Vision
The **Aptos NFT Marketplace** is designed to allow users to create and display their NFT collections seamlessly on the Aptos blockchain. The vision behind this marketplace is to provide a decentralized, user-friendly platform where anyone can mint NFTs and showcase their digital assets in a transparent and secure environment. By leveraging Aptos' high throughput and low-latency blockchain, the marketplace aims to enhance the NFT experience, empowering both creators and collectors with cutting-edge blockchain technology.

## Features
- **Create NFT Collections**: Users can easily create their own NFT collections, mint NFTs, and manage their assets on the marketplace.
- **View Collections**: The platform allows users to browse and view the details of NFT collections, ensuring transparency and easy accessibility.
- **Blockchain-based Ownership**: Every NFT and collection is securely stored on the Aptos blockchain, ensuring immutable ownership records.
- **Minimalistic Contract**: A simple, compact contract that focuses on core functionalities like creating and viewing NFT collections.
- **Decentralized & Trustless**: Operates in a decentralized manner, where users control their own assets without relying on centralized entities.

## Future Scope
- **Secondary Market**: Enable buying, selling, and trading NFTs on the marketplace.
- **Advanced Metadata**: Support for more complex metadata, including images, animations, and more.
- **Auctions & Bidding**: Integration of auction functionality, allowing creators to set auctions for their NFTs.
- **Royalties for Creators**: Implement royalty mechanisms to ensure creators earn a percentage of every resale.
- **Interoperability**: Support for cross-chain NFT transfers, allowing collections from other blockchains to be represented and traded on the Aptos platform.
- **User Profiles**: Advanced profile creation, showing a user's NFT portfolio, transaction history, and other relevant details.

## Smart Contract Information

### Main Functions
1. **Create Collection**: Allows a user to create a new NFT collection on the marketplace.
2. **Show Collection**: Displays the information of the existing NFT collections for users to view.

### Contract Code

```move
module NftMarketplace::Marketplace {
    use aptos_framework::signer;
    use aptos_framework::token::{self, TokenData, Token};
    use aptos_framework::collection::{self, Collection};

    /// Create a new NFT collection
    public fun create_collection(
        owner: &signer, 
        collection_name: vector<u8>, 
        description: vector<u8>, 
        uri: vector<u8>
    ): Collection {
        let collection_obj = collection::create_collection(
            owner,
            collection_name,
            description,
            uri,
            1000,       // Maximum number of NFTs in this collection
            some(aptos_coin::aptos(10))  // Optional creation fee (10 APT)
        );
        collection_obj
    }

    /// Show information of an NFT collection
    public fun show_collection(collection: &Collection): (vector<u8>, vector<u8>, vector<u8>, u64) {
        let name = collection::name(collection);
        let description = collection::description(collection);
        let uri = collection::uri(collection);
        let nft_count = collection::count(collection);
        (name, description, uri, nft_count)
    }
}
```

### Functions Description
1. **`create_collection`**: 
   - **Parameters**: 
     - `owner`: The signer creating the collection.
     - `collection_name`: The name of the NFT collection.
     - `description`: Description of the collection.
     - `uri`: Metadata URI for the collection.
   - **Returns**: A `Collection` object representing the new collection.
   
2. **`show_collection`**: 
   - **Parameters**: 
     - `collection`: The NFT collection to display.
   - **Returns**: A tuple containing the collection name, description, URI, and the number of NFTs in the collection.

## How to Use

### Prerequisites
- Set up the Aptos CLI and have an Aptos account.
- Ensure your development environment has the Move compiler and Aptos Framework installed.

### Steps
1. Clone the repository and navigate to the project directory.
2. Compile the contract using:
   ```bash
   aptos move compile
   ```
3. Deploy the contract to your Aptos account:
   ```bash
   aptos move publish --profile <your-profile>
   ```
4. Use the provided functions to create and view NFT collections:
   - Create a collection:
     ```bash
     aptos move run --function-id NftMarketplace::Marketplace::create_collection --args <owner-address> <collection-name> <description> <uri>
     ```
   - Show collection information:
     ```bash
     aptos move run --function-id NftMarketplace::Marketplace::show_collection --args <collection-id>
     ```

## Move.toml
Here is the `Move.toml` configuration file for building and managing the project:

```toml
[package]
name = "NftMarketplace"
version = "0.0.1"
license = "MIT"
authors = ["your_name"]
description = "A simple NFT marketplace to create and show NFT collections."

[dependencies]
AptosFramework = { local = "../aptos-core/aptos-move/framework/aptos-framework" }

[build]
output_dir = "build"

[addresses]
NftMarketplace = "_"

[dev-addresses]
default = "0xA550C18"

[layout]
modules = ["sources"]
```

## Conclusion
The **Aptos NFT Marketplace** aims to simplify the creation and display of NFT collections on the blockchain, with future features planned to expand its functionality. The current contract provides a basic foundation for NFT operations, and the roadmap envisions exciting possibilities for growth in decentralized NFT trading and management.

