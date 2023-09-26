set dotenv-load

run:
    docker build -t test .
    docker run --rm -it -v ${PWD}:/akv test
install-deps:
    brew install openssl curl json-c
build:
    mkdir build
    cmake -S src -B build
    cmake --build build
clean:
    rm -rf build
check-openssl:
    # OPENSSL_CONF=${PWD}/openssl.conf \
    # openssl list -engines
    OPENSSL_CONF=${PWD}/openssl.conf \
    openssl engine -vvv -t e_akv
check-curl:
    OPENSSL_CONF=${PWD}/openssl.conf \
    curl -sv \
        --engine e_akv \
        --cert-type PEM \
        --cert "${Certificate}" \
        --key-type ENG \
        --key "e_akv:${KeyVaultType}:${KeyVaultName}:${KeyName}" \
        --http1.1 \
        "${Site}"

