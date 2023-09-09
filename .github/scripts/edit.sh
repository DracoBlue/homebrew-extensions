fetch() {
  REPO="$(grep '^  homepage' < ./Formula/"$VERSION".rb | cut -d\" -f 2)"
  sudo cp "Formula/$VERSION.rb" "/tmp/$VERSION.rb"
  if [[ "$EXTENSION" =~ event|expect|gnupg|imagick|imap|mcrypt|pcov|snmp ]] ||
     [[ "$VERSION" =~ (amqp)@(7.4|8.[0-4]) ]] ||
     [[ "$VERSION" =~ (phalcon5)@(7.4|8.[0-2]) ]] ||
     [[ "$VERSION" =~ (propro)@7.[0-4] ]] ||
     [[ "$VERSION" =~ (msgpack)@(7.[0-4]|8.0) ]] ||
     [[ "$VERSION" =~ (apcu|grpc|igbinary|gearman|lua|memcached|pecl_http|protobuf|raphf|rdkafka|redis|ssh2|uuid|vips|xlswriter)@(7.[0-4]|8.[0-4]) ]] ||
     [[ "$VERSION" =~ (yaml)@(7.[1-4]|8.[0-4]) ]] ||
     [[ "$VERSION" =~ (ast|mcrypt|mongodb)@(7.[2-4]|8.[0-4]) ]] ||
     [[ "$VERSION" =~ (ds|mailparse|psr)@(7.[3-4]|8.[0-4]) ]] ||
     [[ "$VERSION" =~ (couchbase|memcache|swoole|sqlsrv|pdo_sqlsrv|xdebug)@(8.[0-4]) ]]; then
    sudo chmod a+x .github/scripts/update.sh && bash .github/scripts/update.sh "$EXTENSION" "$VERSION" "$REPO"
    url=$(grep '^  url' < ./Formula/"$VERSION".rb | cut -d\" -f 2)
    checksum=$(curl -sSL "$url" | shasum -a 256 | cut -d' ' -f 1)
    sed -i "s/^  sha256.*/  sha256 \"$checksum\"/g" ./Formula/"$VERSION".rb
  fi
}

check_changes() {
  new_url="$(grep -e "^  url.*" ./Formula/"$VERSION".rb | cut -d\" -f 2)"
  old_url="$(grep -e "^  url.*" /tmp/"$VERSION".rb | cut -d\" -f 2)"
  new_checksum="$(grep -e "^  sha256.*" ./Formula/"$VERSION".rb | cut -d\" -f 2)"
  old_checksum="$(grep -e "^  sha256.*" /tmp/"$VERSION".rb | cut -d\" -f 2)"
  echo "new_url: $new_url"
  echo "old_url: $old_url"
  echo "new_checksum: $new_checksum"
  echo "old_checksum: $old_checksum"
  if [[ "$GITHUB_MESSAGE" =~ .*--init.* ]]; then
    sed -Ei 's/\?init=true//' ./Formula/"$VERSION".rb || true
  elif [[ "$GITHUB_MESSAGE" =~ .*--rebuild.* ]]; then
    sed -Ei '/  revision.*/d' ./Formula/"$VERSION".rb || true
  elif [[ -z "$new_url" ]] || [[ "$new_url" = "$old_url" && "$new_checksum" = "$old_checksum" ]]; then
    sudo cp /tmp/"$VERSION".rb Formula/"$VERSION".rb
  fi
}

fetch
check_changes
