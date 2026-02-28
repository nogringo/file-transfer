# File Transfer

Zero SPOF file transfer over Nostr. End-to-end encrypted, decentralized, and private.

## Features

- 🔒 **End-to-End Encrypted** - AES-GCM encryption, keys never leave the client
- 🌐 **Zero SPOF** - Decentralized storage across multiple Blossom servers
- 📨 **Private Metadata** - NIP-59 giftwrap for secure event delivery
- 📦 **NIP-17 Compliant** - Standard file metadata format

## Security

- Files are encrypted **client-side** before upload
- Encryption keys are transmitted via **NIP-59 giftwrap** (only recipient can decrypt)
- Blossom servers store **encrypted blobs only**
- No central server has access to both the encrypted file and decryption keys
