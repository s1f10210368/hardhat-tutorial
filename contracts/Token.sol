//SPDX-License-Identifier: UNLICENSED

// Solidityファイルはこのプラグマから始める必要があります。
// これはSolidityコンパイラによってバージョンを検証するために使用されます。
pragma solidity ^0.8.0;

import "hardhat/console.sol";

// これはスマートコントラクトの主な構成要素です。
contract Token {
    // トークンを識別するためのいくつかの文字列型変数。
    string public name = "My Hardhat Token";
    string public symbol = "MHT";

    // 固定量のトークンを符号なし整数型変数に保存。
    uint256 public totalSupply = 1000000;

    // アドレスタイプの変数はEthereumアカウントを保存するために使用されます。
    address public owner;

    // マッピングはキー/バリューマップです。ここでは各アカウントの残高を保存します。
    mapping(address => uint256) balances;

    // Transferイベントはオフチェーンアプリケーションが
    // コントラクト内で何が起こっているかを理解するのに役立ちます。
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /**
     * コントラクトの初期化。
     */
    constructor() {
        // totalSupplyはトランザクション送信者に割り当てられます。
        // これはコントラクトをデプロイするアカウントです。
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    /**
     * トークンを転送する関数。
     *
     * `external`修飾子は関数をコントラクトの外部からのみ呼び出せるようにします。
     */
    function transfer(address to, uint256 amount) external {
        // トランザクション送信者が十分なトークンを持っているかを確認します。
        // `require`の最初の引数が`false`の場合、トランザクションは巻き戻されます。
        require(balances[msg.sender] >= amount, "Not enough tokens");

        console.log(
            "Transferring from %s to %s %s tokens",
            msg.sender,
            to,
            amount
        );

        // 金額を転送します。
        balances[msg.sender] -= amount;
        balances[to] += amount;

        // トランスファーをオフチェーンアプリケーションに通知します。
        emit Transfer(msg.sender, to, amount);
    }

    /**
     * 指定されたアカウントのトークン残高を取得する読み取り専用関数。
     *
     * `view`修飾子は、コントラクトの状態を変更しないことを示し、
     * トランザクションを実行せずに呼び出すことができます。
     */
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}
