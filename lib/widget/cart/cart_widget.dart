import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletons/skeletons.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  List selectedProduct = [];

  void selectProduct(int product, bool isAdding){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          int itemLenght = 3;
          return Container(
            height: 50+itemLenght*200,
            width: double.infinity,
            color: Colors.white,
            child: ListView(              
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        // fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: true,
                        onChanged: (bool? value) {
                          setState(() {
                            // isChecked = value!;
                          });
                        },
                      ),
                      Text(
                        "product.seller.user.username",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
            
                    ],
                  ),
                  Container(
                    height: itemLenght*200,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        bool? isChecked = false;
                        print(isChecked);
                        return Container(
                          height: 200,
                          alignment: AlignmentDirectional.topStart,
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.black,
                                // fillColor: ,
                                // fillColor: MaterialStateProperty.resolveWith(Colors.amber as MaterialPropertyResolver<Color?>),
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    print(value);
                                    // delete item from list
                                    selectedProduct.removeWhere((item) => item == '001'); 
    
                                    // adding item into list
                                    if (value == true) {
                                      selectedProduct.add("1");
                                    } 
                                    isChecked = value;
                                  });
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: FadeInImage(
                                  height: 80,
                                  width: 80,
                                  placeholder: AssetImage("images/loading.gif"),
                                  image: NetworkImage("https://lzd-img-global.slatic.net/g/p/d1299ffb43ab960b33ad38ee0170b816.jpg_720x720q80.jpg_.webp"),
                                ),
                              ),
                              Container(
                                alignment: AlignmentDirectional.topStart,
                                height: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "product.title",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "product.varian",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "product.price",
                                      style: GoogleFonts.poppins(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
          );
        },
      ),
    );
  }
}