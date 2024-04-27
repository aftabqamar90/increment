<template>
    <div class="row">
        <div class="card" style="width: 100%">
            <div class="card-header">
                Welcome we are learning Smart contract development
            </div>
            <div class="card-body">
                <h5 class="card-title">
                    Counter : <small>{{Counter}}</small>
                </h5>

            </div>
            <div class="card-footer">
                <button @click="IsEnableButton" class="btn btn-danger">Connect Metamask</button>
                &nbsp;&nbsp;
                <button @click="increment" v-if="IsEnableButton" class="btn btn-success">Increment</button>
                &nbsp;&nbsp;
                <button @click="Decrement" v-if="IsEnableButton" class="btn btn-danger">Decrement</button>
                &nbsp;&nbsp;
                <button @click="GetCounter" class="btn btn-info">Counter</button>
            </div>
        </div>
    </div>
</template>
<script>
    import Web3 from "web3";
    import { ethers } from "ethers";
    import detectProvider from "@metamask/detect-provider";
    export default {
        data() {
            return {
                count: 1,
                Abi: [
                    {
                        "inputs": [],
                        "name": "decrement",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "stateMutability": "nonpayable",
                        "type": "constructor"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": false,
                                "internalType": "uint256",
                                "name": "value",
                                "type": "uint256"
                            }
                        ],
                        "name": "Decrement",
                        "type": "event"
                    },
                    {
                        "inputs": [],
                        "name": "increment",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "anonymous": false,
                        "inputs": [
                            {
                                "indexed": false,
                                "internalType": "uint256",
                                "name": "value",
                                "type": "uint256"
                            }
                        ],
                        "name": "Increment",
                        "type": "event"
                    },
                    {
                        "inputs": [],
                        "name": "GetCounter",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    }],
                ContractAddress: '0x3B02935EA2525De63519D22A2C1625bfc1bF171e',
                ConnectedAccounts: 'Not connected',
                IsEnableButton: false,
                provider: null,
                signer: null,
                walletContract: null,
                Api: '',
                Counter: 0
            }
        },
        methods: {
            async increment() {
                const app = this;
                const walletContract = await app.GetObject();
                walletContract.increment().then((e) => {
                    app.GetCounter();
                }).catch((e) => {
                    alert(e.message);
                });
            },
            async Decrement() {
                const app = this;
                const walletContract = await app.GetObject();
                walletContract.decrement().then((e) => {
                    app.GetCounter();
                }).catch((e) => {
                    alert(e.message);
                });
            },
            async GetCounter() {
                const app = this;
                const walletContract = await app.GetObject();
                walletContract.GetCounter().then((e) => {
                    app.Counter = e.toString();
                }).catch((e) => {
                });
            },
            ConnectMetaMask() {
                const app = this;
                app.IsEnableButton = false;
                const walletContract = app.GetObject().then((result) => {
                    app.IsEnableButton = true;
                    app.GetCounter();
                }).catch((e) => {
                    app.IsEnableButton = false;
                });
            },
            ReadOperation() {
                const app = this;

                const provider = new ethers.providers.JsonRpcProvider(app.Api);
                let walletContract = new ethers.Contract(
                    app.ContractAddress,
                    app.Abi,
                    provider
                )

                walletContract.GetCounter().then((result) => {
                    console.log(ethers.utils.formatEther(result));
                    console.log(result.toString());
                })


                //provider.send

                //provider.getBalance('0xf71c9D36bb8e9CcaE0c22e222607C251198403F5').then((result) => {
                //    console.log(ethers.utils.formatEther(result));
                //});
            },
            WriteOption() {
                const app = this;
                const provider = new ethers.providers.Web3Provider(window.ethereum);
                provider.send("eth_requestAccounts", []).then((result) => {
                    const signer = provider.getSigner();
                    debugger;
                    let walletContract = new ethers.Contract(
                        app.ContractAddress,
                        app.Abi,
                        signer
                    );
                    walletContract.increment().then((e) => {
                        alert('Successfully execute transactions');
                    }).catch((e) => {
                        alert(e.message);
                    });
                }).catch((error) => {
                    alert(error.message);
                });
            },
            async GenerateConnection() {
                const app = this;

                const walletContract = await app.GetObject();

                walletContract.increment().then((e) => {
                    alert('Successfully execute transactions');
                }).catch((e) => {
                    alert(e.message);
                });



                //app.GetObject().then((walletContract) => {
                //    walletContract.increment().then((e) => {
                //        alert('Successfully execute transactions');
                //    }).catch((e) => {
                //        alert(e.message);
                //    });
                //});

                //}).catch((e) => {
                //    app.IsEnableButton = false;
                //});
            },
            async GetObject() {
                const app = this;
                const provider = new ethers.providers.Web3Provider(window.ethereum);
                var result = await provider.send("eth_requestAccounts", []);
                const signer = provider.getSigner();
                const walletContract = new ethers.Contract(
                    app.ContractAddress,
                    app.Abi,
                    signer
                );
                return walletContract;

                //    .then((result) => {
                //    app.IsEnableButton = true;
                //    const signer = provider.getSigner();
                //    const walletContract = new ethers.Contract(
                //        app.ContractAddress,
                //        app.Abi,
                //        signer
                //    );
                //    return walletContract;
                //})
            },
        },
        mounted() {
            const app = this;
            app.ConnectMetaMask(); // CONNECT WITH METAMASK AND EXECUTE TRANSCTIONS AND MAKE CHANES ON THE BLOCKCHAIN.
        }
    }
</script>