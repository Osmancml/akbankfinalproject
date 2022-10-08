// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7;

contract Shopping {
    
    struct Product {    
        string productsName; //Ürün ismi tutulacak
        uint productsQuantity; // Kaç tane ürün alındığı görülebilecek
    }
    Product[] public productNames;

    constructor(string[] memory productName) { // bu constructor yapısında bi ürün aldığınız da sayacınız bir artar ve ürün ismi belirir.
        
        for(uint i = 0 ; i < productName.length ; i++) { 
            productNames.push(Product({productsName: productName[i], productsQuantity: 0})); 
        }
    }
    modifier checkProducts(uint256[] memory productName) { // eğer array içerisinde length 0 dan büyük değilse, ürün olmadığını söylüyor 
        require(productName.length > 0, "No products.");
        _;
    }
    
    struct Amount {  
        address priceSetter;  // Ürün fiyatlarını belirleyen kişi
        string paymentMethod;  // Alıcının ödeme şekli
        uint256[] productAmount; //ürün fiyatları tutulacak
    }

    Amount[] public amounts; // local fonksiyon buradaki array ile blockchaine kayıt oluyor

    event ProductAmountSetter(uint256 orderId, address indexed priceSetter); // siparişin ıd sini return dönmek yerine, event olarak yayınlayabiliriz 
    
    function marketAmount(string memory _paymentMethod, uint256[] memory _productAmount) public returns(uint256){
        Amount memory amount;
        amount.priceSetter = msg.sender; 
        amount.paymentMethod = _paymentMethod;
        amount.productAmount = _productAmount;
        amounts.push(amount);

        emit ProductAmountSetter(amounts.length - 1, msg.sender);

        return amounts.length - 1; // order uzunluğu bir eleman eklendiği için bir gelir o yüzden yanlış olur, bir eksiltmek gerekir
    }

    struct TotalAmount {
        uint totalProductAmount; //Burada alınan oyları tutacağız. burada toplam market tutarı yazacak
    }

    function totalProductAmount(uint[] calldata  _productAmount) public pure returns (uint sum) {
        sum = 0;
        for (uint i = 0; i < _productAmount.length; i++) {
            sum += _productAmount[i]; // bu kod sayesinde alışveriş sonrasında yapılan toplamı görebiliyoruz
        }
    }
    

}