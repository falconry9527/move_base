module move_base::transfer_uid {
    
    use sui::derived_object;    
    
    /// UID类型定义在sui::object模块中，它是ID 的封装，而 ID又封装了地址类型
    /// Some central application object.
    public struct Base has key { id: UID }

    /// Derived Object.
    public struct Derived has key { id: UID }

    /// Create and share a new Derived object using `address` as a `key`.
    public fun derive(base: &mut Base, key: address) {
        let id = derived_object::claim(&mut base.id, key);
        transfer::share_object(Derived { id })
    }

}
