#!/usr/bin/env bash

set -euo pipefail

F2B="docker exec fail2ban fail2ban-client"

get_value() {
    local jail="$1"
    local field="$2"

    $F2B status "$jail" 2>/dev/null | \
        awk -F'\t' -v key="$field" '$1 ~ key {print $2}'
}

# ===== 404 =====

f404_failed=$(get_value nofelet-404 "Total failed:")
f404_banned=$(get_value nofelet-404 "Total banned:")
f404_active=$(get_value nofelet-404 "Currently banned:")

# ===== TLS =====

tls_failed=$(get_value nofelet-tls "Total failed:")
tls_banned=$(get_value nofelet-tls "Total banned:")
tls_active=$(get_value nofelet-tls "Currently banned:")

# ===== Scanner =====

scanner_failed=$(get_value nofelet-scanners "Total failed:")
scanner_banned=$(get_value nofelet-scanners "Total banned:")
scanner_active=$(get_value nofelet-scanners "Currently banned:")

# ===== Summary =====

active_bans=$((f404_active + tls_active + scanner_active))
total_bans=$((f404_banned + tls_banned + scanner_banned))

cat <<EOF

===========================
        Fail2Ban
===========================

Active bans      : $active_bans
Total bans       : $total_bans

404 failures     : $f404_failed
TLS failures     : $tls_failed

404 banned       : $f404_banned
TLS banned       : $tls_banned

===========================

EOF

echo "Current bans:"
echo

docker exec fail2ban fail2ban-client banned