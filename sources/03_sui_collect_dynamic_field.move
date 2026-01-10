module move_base::dynamic_object_field;

use std::string::String;
public struct Character has key { id: UID }
public struct Metadata has store, drop { name: String }
public struct Accessory has key, store { id: UID }

use sui::dynamic_object_field as dof;
use sui::dynamic_field as df;

#[test]
fun equip_accessory() {
    let ctx = &mut tx_context::dummy();
    let mut character = Character { id: object::new(ctx) };

    let hat = Accessory { id: object::new(ctx) };

    // 值必须同时包key 和 store 类型，而不仅仅像动态字段那样只包含 store
    dof::add(&mut character.id, b"hat_key", hat);

    // 只包含 store 就可以了
    df::add(&mut character.id, b"metadata_key", Metadata {
        name: b"John".to_string()
    });

    let _hat_id = dof::id(&character.id, b"hat_key").extract(); // Option<ID>
    let _hat_ref: &Accessory = dof::borrow(&character.id, b"hat_key");
    let _hat_mut: &mut Accessory = dof::borrow_mut(&mut character.id, b"hat_key");
    let hat: Accessory = dof::remove(&mut character.id, b"hat_key");

    // 先 remove 拿到子对象所有权，再 transfer 给 recipient
    let sender = tx_context::sender(ctx);
    transfer::public_transfer(hat, sender);

    // dynamic_field 的值是 store 数据（不是 object），如果要销毁 character，
    // 需要先 remove 掉动态字段，否则 destroy 可能失败
    let _metadata: Metadata = df::remove(&mut character.id, b"metadata_key");
    std::unit_test::destroy(character);
}