module move_base::base_receiving{

    use sui::derived_object;
    use sui::transfer::Receiving; 

    public struct PostOffice has key { id: UID }

    public struct PostBox has key { id: UID, owner: address }

    public fun send<T: key + store>(office: &PostOffice, parcel: T, recipient: address) {
        let postbox = derived_object::derive_address(office.id.to_inner(), recipient);
        transfer::public_transfer(parcel, postbox)
    }

    public fun receive<T: key + store>(
        box: &mut PostBox,
        to_receive: Receiving<T>,
        ctx: &TxContext
    ): T {
        assert!(box.owner == ctx.sender());
        let parcel = transfer::public_receive(&mut box.id, to_receive);
        parcel
    }

    public fun register_address(office: &mut PostOffice, ctx: &mut TxContext) {
        transfer::share_object(PostBox {
            id: derived_object::claim(&mut office.id, ctx.sender()),
            owner: ctx.sender()
        })
    }

    fun init(ctx: &mut TxContext) {
        transfer::share_object(PostOffice { id: object::new(ctx) });
    }
}
