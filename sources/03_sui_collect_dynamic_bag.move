module move_base::dynamic_bag{

    #[test]
    fun dynamic_bag_test() {
        let hat: &Hat = &bag[b"key"];
        let hat_mut: &mut Hat = &mut bag[b"key"];
        
        let hat: &Hat = bag.borrow(b"key");
        let hat_mut: &mut Hat = bag.borrow_mut(b"key");
    }
  
}
