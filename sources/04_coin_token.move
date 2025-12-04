module move_base::my_token;

use sui::coin::{Self, TreasuryCap, Coin};
use sui::url;

/// One-Time Witness - 必须与模块名同名（大写）
/// 只能有 `drop` 能力，确保只能在 init 函数中使用一次
public struct MY_TOKEN has drop {}

/// 模块初始化函数 - 发布时自动调用一次
fun init(witness: MY_TOKEN, ctx: &mut TxContext) {
    // 创建代币，返回 TreasuryCap 和 CoinMetadata
    let (treasury_cap, metadata) = coin::create_currency(
        witness,                           // 一次性见证
        9,                                 // 小数位数（9 = 1 TOKEN = 1_000_000_000 最小单位）
        b"MYT",                            // 符号
        b"My Token",                       // 名称
        b"A sample token on Sui",          // 描述
        option::some(url::new_unsafe_from_bytes(
            b"https://example.com/icon.png"
        )),                                // 图标 URL
        ctx
    );
    
    // 将元数据设为不可变（冻结）
    transfer::public_freeze_object(metadata);
    
    // 将铸币权限转给发布者
    transfer::public_transfer(treasury_cap, ctx.sender());
}

/// 铸造新币 - 只有 TreasuryCap 持有者可调用
public fun mint(
    treasury_cap: &mut TreasuryCap<MY_TOKEN>,
    amount: u64,
    recipient: address,
    ctx: &mut TxContext
) {
    // 铸造指定数量的代币
    let coin = coin::mint(treasury_cap, amount, ctx);
    // 转给接收者
    transfer::public_transfer(coin, recipient);
}

/// 销毁代币 - 减少总供应量
public fun burn(
    treasury_cap: &mut TreasuryCap<MY_TOKEN>,
    coin: Coin<MY_TOKEN>
) {
    coin::burn(treasury_cap, coin);
}

/// 查询总供应量
public fun total_supply(treasury_cap: &TreasuryCap<MY_TOKEN>): u64 {
    coin::total_supply(treasury_cap)
}