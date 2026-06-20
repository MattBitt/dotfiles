function album-users
    ssh hmtc@5.78.146.228 "docker exec -i hmtc-subscribers-postgres psql -U postgres -d hmtcsubscribers -c 'SELECT id, username, email, created_at FROM users ORDER BY created_at DESC LIMIT 20'"
end
