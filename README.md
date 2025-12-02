# move_base

##  常用命令
```shell
sui move build
sui client active-address
sui client publish

sui move test

```

##  todo_list
```shell
sui client ptb \
--gas-budget 100000000 \
--assign sender @$MY_ADDRESS \
--move-call $PACKAGE_ID::todo_list::new \
--assign list \
--transfer-objects "[list]" sender

ptb :   Sui CLI 命令,调用模块、发送对象、测试交易
assign : 传入参数
move-call  ： 调用 具体方法
transfer-objects ： 把对象 list 转移给 sender
```

##  01_base_type
```shell
sui client call \
  --package 0x1bbbf7be9998372aef84a03e675d4fded5385895a95610032639605cf4f805e0 \
  --module base_type \
  --function test_vector

```

##  01_base_func
```shell
  sui client call \
  --package 0x3c3735314bad92c93025d82771a864de6531df9d9c085e2ae2962f77c83185cd \
  --module base_func \
  --function public_logic \
  --args "42" 
```