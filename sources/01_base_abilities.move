module move_base::base_abilities {

/*
一. 数据类型
基础类型 : bool,address,u8,u128
复合类型: string,struct,option,

集合类型：
可以遍历的：Vector(动态数组，内存连续，小容量)， VecMap (Key是动态数组，内存连续，小容量)
不能遍历的: Table(key-vaule 格式，无顺，查找快),linked_table (key-vaule 格式，有序，查找慢)

object_table : value 通常需要是有 key 的 object,ObjectTable 是主对象的字段，用来管理子对象
table : value 通常是基础类型，没有key的普通struct 实例 
更具体地说：它允许该类型作为某个会被持久化的对象/资源的字段存在，或出现在最终会被持久化的容器

二. struct 能力系统
1.常规 
struct 具有的 4 种能力（Ability）：
copy：允许类型被复制；大多数原生数值类型默认具备该能力。
drop：允许类型在作用域结束时被隐式丢弃；没有 drop 的类型 需要显式处理（例如 object::delete）。
key：表示链上对象，有全局唯一 ID，可放在全局存储里作为对象；不能与 copy 或 drop 共存。
store： 表示它可以作为元素被存到持久化结构里，并且 可以跨模块操作。

transfer 和 public_transfer
transfer<T: key> : 在当前调用模块里定义的对象类型 T
public_transfer<T: key + store> : 跨模块转移对象类型 T , 要求T额外具备 store 能力

2.1 特殊情况 ： Hot Potato 结构体（Move）
没有任何能力的 struct
只能在同一个交易中被创建并销毁，例如闪电贷款：
- 借款时向 用户 返回 Hot Potato
- 用户 必须在同一个交易中 完成还款
- 若未消耗该结构体，交易将直接失败

三. OBJECT 
具有 key 能力的 struct 类型的实例，如果拥有 UID 并被系统管理（transfer, share_object,freeze_object），就被称为 Object。

系统管理负责：
UID :  Object 的唯一身份标识(object::new(ctx))
Owner所有权限 (transfer, share_object,freeze_object)
版本号（Version）
生命周期（ delete ）
并发控制（parallel execution）

1. OBJECT UID 
coin.split 的时候，更改原来coin代币的余额，生成新uid的 coin
transfer::transfer 本质是一次系统级所有权变更，而非修改 Move 对象字段。

2. Object 的三种 Owner 类型
Owned Object（账户拥有）: transfer::transfer(obj, recipient);
Shared Object（共享对象）: transfer::share_object(obj); 
Immutable Object（不可变对象） :transfer::freeze_object(obj);

share_object：所有人可写的共享状态；常见的主对象 : hearn
freeze_object：所有人只读的不可变状态，例如创建代币的原始数据 metadata

3.为什么 Sui 能并行执行交易
Owned Object：不同 owner 的对象可并行
Shared Object：用 shared version + 共识锁


**/


    // 定义可复制结构体
    public struct Point has copy, drop {
        x: u8,
        y: u8,
    }

    public fun test_point() : u8 {
        let p1 = Point { x: 10, y: 20 };
        let p2 = p1; // ✅ 可以复制
        let p3 = p1; // ✅ 再次复制
        p2.x + p3.y // ✅ 使用了 p3
    }

}