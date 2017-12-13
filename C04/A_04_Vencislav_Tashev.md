# RSA API Routes

Request: *POST* `/rsas/`

Response: Creates a new RSA instance (should provide `n`, `e` and `d` keys)
```
{
  "id": <rsa_id>
}
```

---

Request: *POST* `/rsas/:id?values`

Response: Returns a specific RSA instance based on a filter
```
{
  "id": <rsa_id>,
  "n": <n_value>,
  "e": <e_value>,
  "d": <d_value>
}
```

---

Request: *GET* `/rsas/generate_keys/`

Response: Generates a new pair of keys
```
{
  "n": <n_value>,
  "e": <e_value>,
  "d": <d_value>
}
```

---

Request: *GET* `/rsas/:rsaId/n/`

Response: Returns the N part of a public key for a specific RSA
```
{
  "n": <n_value>
}
```

---

Request: *GET* `/rsas/:rsaId/e/`

Response: Returns the E part of the public key
```
{
  "e": <e_value>
}
```

---

Request: *GET* `/rsas/:rsaId/d/`

Response: Returns the private key
```
{
  "d": <d_value>
}
```

---

Request: *GET* `/rsas/:rsaId/encryptedMessages/`

Response: Returns all encrypted messages
```
{
  [
    {
      "id": <message_id>,
      "message": "a21309sadjlk21dsalkh21ds"
    },
    {
        ...
    }
  ]
}
```

---

Request: *POST* `/rsas/:rsaId/encryptedMessages/` (should provide `message` key)
```
{
  "message": "Hello world!"
}
```
Response: Returns the encrypted message representation
```
{
  "id": <message_id>,
  "message": "a21309sadjlk21dsalkh21ds"
}
```

---

Request: *GET* `/rsas/:rsaId/encryptedMessages/:messageId/`

Response: Returns a concrete message with given id
```
{
  "id": <message_id>,
  "message": "a21309sadjlk21dsalkh21ds"
}
```

---

Request: *GET* `/rsas/:rsaId/decryptedMessages/`

Response: Returns all decrypted messages
```
{
  [
    {
      "id": <message_id>,
      "message": "Hello world!"
    },
    {
        ...
    }
  ]
}
```

---

Request: *POST* `/rsas/:rsaId/decryptedMessages/` (should provide `message` key)
```
{
  "message": "a21309sadjlk21dsalkh21ds"
}
```
Response: Returns the decrypted message representation
```
{
  "id": <message_id>,
  "message": "Hello world!"
}
```

---

Request: *GET* `/rsas/:rsaId/decryptedMessages/:messageId/`

Response: Returns a concrete message with given id
```
{
  "id": <message_id>
  "message": "Hello world!"
}
```

