module move_base::sui_context {
    use sui::debug;

    public fun some_action(ctx: &TxContext) {
        let me = ctx.sender(); // 交易发送者
        let epoch = ctx.epoch(); // 当前的区块链 epoch
        let digest = ctx.digest(); // 交易哈希
    }
}
