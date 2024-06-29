const { expect } = require("chai");

describe("Token contract", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    // ethers.jsのSignerはEthereumアカウントを表すオブジェクト、コントラクトや他のアカウントにトランザクションを送信するために使用される
    // ここでは、接続しているノード(ここではHardhat Network)のアカウントリストを取得して最初のアカウントだけを保持している
    const [owner] = await ethers.getSigners();

    // コードを常に明示的にしたい場合は以下の行を追加
    /*const { ethers } = require("hardhat");*/

    // 以下の行を呼び出すことで、デプロイメントが開始されPromiseが返される
    // このPromiseはコントラクトが解決された時に"Contract"オブジェクトを返す
    const hardhatToken = await ethers.deployContract("Token");

    // hardhatTokenでコントラクトメソッドを呼び出す
    // ここではオーナーアカウントの残高を取得
    const ownerBalance = await hardhatToken.balanceOf(owner.address);

    // 'Contract'インスタンスを使用してスマートコントラクト関数を呼び出している
    // totalSupplyはトークンの供給量を返し、それがownerBalanceと等しいことを意味している
    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
  });
});
