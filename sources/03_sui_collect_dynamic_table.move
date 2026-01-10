module move_base::table_demo {
    /// Imported from the `sui::table` module.
    use sui::table::{Self, Table};
    /// Imported from the `sui::object_table` module.
    use sui::object_table::{Self, ObjectTable};
    use std::string::String ;

    /// Some record type with `store`
    public struct Record has store { /* ... */ }

    /// An example of a `Table` as a struct field.
    #[allow(unused_field)]
    public struct UserRegistry has key {
        id: UID,
        table: Table<address, Record>
    }

    /// Value in `ObjectTable` must be an object (`key + store`)
    public struct Item has key, store {
        id: UID,
        name: String,
    }

    public fun test_table(ctx: &mut TxContext) {
          // Table requires explicit type parameters for the key and value
        // ...but does it only once in initialization.
        let mut table = table::new<address, String>(ctx);

        // table has the `length` function to get the number of elements
        // assert_eq!(table.length(), 0);

        table.add(@0xa11ce, b"my_value".to_string());
        table.add(@0xb0b, b"another_value".to_string());

        // length has changed to 2
        // assert_eq!(table.length(), 2);

        // in order: `borrow`, `borrow_mut` and `remove`
        let _value_ref = &table[@0xa11ce];
        let _value_mut = &mut table[@0xa11ce];

        // removing both values
        let _value = table.remove(@0xa11ce);
        let _another_value = table.remove(@0xb0b);

        // length is back to 0 - we can unpack
        table.destroy_empty();
    }

    #[test]
    fun test_object_table() {
        let ctx = &mut tx_context::dummy();

        // ObjectTable: key 是任意 copy + drop + store；value 必须是对象 key + store
        let mut ot: ObjectTable<String, Item> = object_table::new<String, Item>(ctx);

        let k1 = b"k1".to_string();
        let k2 = b"k2".to_string();

        let v1 = Item { id: object::new(ctx), name: b"first".to_string() };
        let v2 = Item { id: object::new(ctx), name: b"second".to_string() };

        ot.add(k1, v1);
        ot.add(k2, v2);

        // borrow / borrow_mut（支持 [] 语法）
        let _vref: &Item = &ot[k1];
        let vmut: &mut Item = &mut ot[k2];
        vmut.name = b"second_updated".to_string();

        // remove 返回对象本体（需要你自己处理：destroy / transfer / store elsewhere）
        let removed1 = ot.remove(k1);
        let removed2 = ot.remove(k2);

        // 为空才能销毁表
        ot.destroy_empty();

        std::unit_test::destroy(removed1);
        std::unit_test::destroy(removed2);
    }

}
