# # EncryptedNFT-Documents

As a delegated Authority you can have KYC contracts created when users submit a form and generate a contract in the contract will their user data be stored both the user who generated the contract and the original dapp creator will have access tokens to access their data. the user will only be able to view and show proof of their own data while the main application administrator can view all user data and approve all user KYC contracts.

Third Party smart contracts and DApps can use the KYC user auth token as a form of delegated Identification while trusting the  Delegated authority (Bank,Exchange,broker) to provide the correct status of the authenticity of the Identities 


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
