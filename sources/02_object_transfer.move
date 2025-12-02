module move_base::transfer_to_sender{

    /// A struct with `key` is an object. The first field is `id: UID`!
    public struct AdminCap has key { id: UID }

    /// `init` function is a special function that is called when the module
    /// is published. It is a good place to do a setup for an application.
    fun init(ctx: &mut TxContext) {
        // Create a new `AdminCap` object, in this scope.
        let admin_cap = AdminCap { id: object::new(ctx) };
        // Transfer the object to the transaction sender.
        transfer::transfer(admin_cap, ctx.sender());
    }

    /// Transfers the `AdminCap` object to the `recipient`. Thus, the recipient
    /// becomes the owner of the object, and only they can access it.
    public fun transfer_admin_cap(cap: AdminCap, recipient: address) {
        transfer::transfer(cap, recipient);
    }
}
