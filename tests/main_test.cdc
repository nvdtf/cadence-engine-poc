import Test

access(all) let blockchain = Test.newEmulatorBlockchain()
access(all) let engineAccount = blockchain.createAccount()

access(all) fun setup() {
    blockchain.deployContract(
        name: "SampleEngine",
        code: Test.readFile("../contracts/SampleEngine.cdc"),
        account: engineAccount,
        arguments: [],
    )

    blockchain.useConfiguration(Test.Configuration({
        "SampleEngine": engineAccount.address
    }))
}

access(all) fun testSampleEngine() {
    let scriptResult = blockchain.executeScript(
        Test.readFile("../scripts/tick.cdc"),
        [],
    )

    Test.expect(scriptResult, Test.beSucceeded())
}