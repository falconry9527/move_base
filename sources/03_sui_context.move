module move_base::sui_context {

    public fun some_action(ctx: &TxContext) {
        // let me = ctx.sender(); // 交易发送者
        // let digest = ctx.digest(); // 交易哈希
        // let epoch = ctx.epoch(); // 当前的区块链 epoch
        // let epoch_start = ctx.epoch_timestamp_ms();// 当前的时间戳
    }
    
}
