# # EncryptedNFT-Documents (Private EVM Network)


#  launch DApp


 launch  app to Encrypt Image or use a means of encrypting your image:

    https://github.com/QCloud-DevOps/EncryptedNFT-Documents.git
    cd safedun-server
    python3 server.py
    #Running on http://127.0.0.1:5000

launch [EncryptedNFTs.sol](https://github.com/QCloud-DevOps/EncryptedNFT-Documents/blob/main/contracts/EncryptedNFTs.sol "EncryptedNFTs.sol")
1. Encryption Key should be a sha256 hash of original the image hash + "randomKey"
2. Uniform Resource Identifier

>     {
>         "Document":"Encrypted File",
>         "Document_Hash":"2f9cc5904219eeb7851b51fca0f3b857081a138",
>         "url":"https://ipfs.io/ipfs/Qmgszg13pYrDKEoiu"
>     }

![Encrypted NFTs](https://user-images.githubusercontent.com/16103963/170800047-fb2760a6-39a4-4e5c-969c-d5997bd51e1f.png)
