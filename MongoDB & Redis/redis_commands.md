# Redis Commands

## Strings
```bash
SET user:1 "Carlos"
GET user:1
EXPIRE user:1 60
TTL user:1
```

## Hashes
```bash
HSET turn:1 id "001" user "user-123" status "waiting"
HGETALL turn:1
HGET turn:1 status
```

## Listas (colas)
```bash
LPUSH queue:today turn-001
RPUSH queue:today turn-002
LRANGE queue:today 0 -1
LPOP queue:today
```

## Sets
```bash
SADD services haircut shave massage
SMEMBERS services
```

## Sorted Sets (Rankings)
```bash
ZADD ranking 10 "player1" 20 "player2"
ZRANGE ranking 0 -1 WITHSCORES
```

## TTL / Expiración
```bash
SETEX reservation:001 30 "user-001"
TTL reservation:001
```
