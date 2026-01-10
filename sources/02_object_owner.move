module move_base::object_owner_demo {
    use std::string::String;
    use sui::dynamic_object_field as dof;

    /// 教学用：把 Sui 对象在链上的 “owner 类型” 抽象成 4 类
    public enum ObjectOwner has copy, drop, store {
        /// 由某个地址拥有（address-owned object）
        AddressOwner(address),
        /// 由父 Object 拥有（object-owned / child object），例如 dynamic_object_field / object_table
        Object { parent_id: ID },
        /// 共享对象（shared object）
        Shared,
        /// 不可变对象（immutable object）
        Immutable,
    }

    /// Address-owned 示例对象
    public struct AddressOwned has key { id: UID }

    /// Object-owned（child object）示例：父对象 + 子对象
    public struct Parent has key { id: UID }
    public struct Child has key, store {
        id: UID,
        name: String,
    }

    /// Shared / Immutable 示例对象
    public struct SharedCounter has key { id: UID, n: u64 }
    public struct FrozenCounter has key { id: UID, n: u64 }

    #[test]
    fun demo_object_owner_kinds() {
        let ctx = &mut tx_context::dummy();
        let sender = tx_context::sender(ctx);

        // 1) AddressOwner(address): 直接 transfer 给某地址
        let addr_obj = AddressOwned { id: object::new(ctx) };
        transfer::transfer(addr_obj, sender);
        let _owner_1 = ObjectOwner::AddressOwner(sender);

        // 2) Object(parent_id): 子对象挂在父对象上（此时 owner 是 parent）
        let mut parent = Parent { id: object::new(ctx) };
        let key = b"hat".to_string(); // Name: copy + drop + store
        let child = Child { id: object::new(ctx), name: b"cap".to_string() };
        dof::add(&mut parent.id, key, child);
        let _owner_2 = ObjectOwner::Object { parent_id: parent.id.to_inner() };

        // 想 transfer 子对象所有权：必须先从 parent 上 remove（detach）拿到对象本体
        let child_detached: Child = dof::remove(&mut parent.id, key);
        transfer::public_transfer(child_detached, sender);
        std::unit_test::destroy(parent);

        // 3) Shared: share_object 之后，成为 shared object（任意人可读，修改需要 shared 输入）
        let shared = SharedCounter { id: object::new(ctx), n: 0 };
        transfer::share_object(shared);
        let _owner_3 = ObjectOwner::Shared;

        // 4) Immutable: freeze_object 之后，成为 immutable object（全局可读，不可修改）
        let frozen = FrozenCounter { id: object::new(ctx), n: 0 };
        transfer::freeze_object(frozen);
        let _owner_4 = ObjectOwner::Immutable;
    }
}


