set dotenv-load

install-deps:
    brew install openssl curl json-c
build:
    mkdir build
    cmake -S src -B build \
        -D SSL_LIB=`brew --prefix`/opt/openssl/lib/libssl.dylib \
        -D CRYPTO_LIB=`brew --prefix`/opt/openssl/lib/libcrypto.dylib \
        -D CURL_LIB=`brew --prefix`/opt/curl/lib/libcurl.dylib \
        -D JSONC_LIB=`brew --prefix`/opt/json-c/lib/libjson-c.dylib
    cmake --build build
clean:
    rm -rf build
check-openssl:
    OPENSSL_CONF=${PWD}/openssl.conf \
    /opt/homebrew/opt/openssl/bin/openssl list -engines
    OPENSSL_CONF=${PWD}/openssl.conf \
    /opt/homebrew/opt/openssl/bin/openssl engine -vvv -t e_akv
check-curl:
    OPENSSL_CONF=${PWD}/openssl.conf \
    /opt/homebrew/opt/curl/bin/curl -sv \
        --engine e_akv \
        --cert-type ENG \
        --cert "e_akv:${KeyVaultType}:${KeyVaultName}:${KeyName}" \
        --key-type ENG \
        --key "e_akv:${KeyVaultType}:${KeyVaultName}:${KeyName}" \
        --http1.1 \
        "${Site}"
