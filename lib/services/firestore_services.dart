import 'package:emart_app/consts/consts.dart';

class FirestoreServices {
  static getUser(uid) {
    return firestone
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get product according to category
  static getProducts(category) {
    return firestone
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }
  //get cart
  static getSubCategoryProducts(title){
    return firestone
        .collection(productsCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();

  }

  static getCart(uid) {
    return firestone
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }
  //delete document

  static deleteDocument(docId) {
    return firestone.collection(cartCollection).doc(docId).delete();
  }
  //get all chat messages

  static getChatMessages(docId) {
    return firestone
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestone
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return firestone
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestone
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestone
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestone
          .collection(productsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestone
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allproducts() {
    return firestone.collection(productsCollection).snapshots();
  }
  //get featured products methods

  static getFeaturedProducts() {
    return firestone
        .collection(productsCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

  static searchProducts(title) {
    return firestone.collection(productsCollection).get();
  }
}
