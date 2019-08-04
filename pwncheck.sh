echo -n "pass> "
read -s pass_str
sha1=$(echo -n $pass_str | tr -d '\n' | sha1sum)
echo "Hash: $sha1"
echo "Hash prefix: ${sha1:0:5}"
echo "Hash suffix: ${sha1:5:35}"
result=$(curl https://api.pwnedpasswords.com/range/${sha1:0:5} 2>/dev/null | grep $(echo ${sha1:5:35} | tr '[:lower:]' '[:upper:]'))
printf "Your password appeared %d times in the database.\\n" "${result#*:}" 2>/dev/null