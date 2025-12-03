module move_base::bag_demo {

    use sui::bag::{Self, Bag, new, borrow, borrow_mut, remove};
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use std::string::String;

    public struct TodoList has key {
        id: UID,
        todos: Bag,
    }

    public  fun new_list(ctx: &mut TxContext) {
        let list = TodoList {
            id: object::new(ctx),
            todos: new(ctx),
        };
        transfer::transfer(list, tx_context::sender(ctx));
    }

public  fun add(
    list: &mut TodoList,
    ctx: &mut TxContext
) {

list.todos.add(b"my_key", b"my_value".to_string());
}

    public fun get(
        list: &TodoList,
        key: vector<u8>
    ): &String {
        borrow(&list.todos, key)
    }

    public  fun update(
        list: &mut TodoList,
        key: vector<u8>,
        new_value: String
    ) {
        let v = borrow_mut(&mut list.todos, key);
        *v = new_value;
    }

    public  fun remove_todo(
        list: &mut TodoList,
        key: vector<u8>
    ): String {
        remove(&mut list.todos, key)
    }
}
