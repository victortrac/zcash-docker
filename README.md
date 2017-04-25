## zcash miner on docker ##
Zcash 1.0.8-1, configured to mine. 

    mkdir -p /opt/zcash
    cat <<EOF > /opt/zcash/zcash.conf
    addnode=mainnet.z.cash
    rpcuser=username
    rpcpassword=`head -c 32 /dev/urandom | base64`
    gen=1
    genproclimit=$(nproc)
    equihashsolver=tromp
    EOF
    git clone https://github.com/victortrac/zcash-docker
    cd zcash-docker
    docker build -t zcash .
    docker run -d --name zcash -v /opt/zcash:/root/.zcash zcash
    # Check outout/hashrate
    docker logs -f zcash
    # Generate a z-address
    docker exec zcash zcash-cli z_getnewaddress
    # Get z-addresses in wallet
    docker exec zcash zcash-cli z_listaddresses
    # Get balances
    docker exec zcash zcash-cli z_getnewaddress ${ADDRESS}

More info here: https://github.com/zcash/zcash/wiki/1.0-User-Guide
