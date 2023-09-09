# homelab-vault-unseal

In my homelab I use hashicorp vault for PKI, Secret and Configuration management.  

Vault persistent storage is encrypted, and vault does not store the decryption keys - so it does not have the ability to decrypt itself.  This means if the vault service is stopped due to maintenance or outage of any kind, when it starts up it can't do anything because all of it's data encrypted - it's in a `sealed` state.

This is a simple service that will periodically check to see if vault is running in a sealed state, and if so - it will unseal it.  The unseal key is meant to be fed into the container via secret management (in my homelab i'm using docker swarm for that)


To see how I am running vault in my home lab, see [here](https://github.com/thefnordling/homelab-vault)