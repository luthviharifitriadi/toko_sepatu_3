import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_sepatu_3/models/message_model.dart';
import 'package:toko_sepatu_3/models/product_model.dart';
import 'package:toko_sepatu_3/providers/auth_provider.dart';
import 'package:toko_sepatu_3/services/message_service.dart';
import 'package:toko_sepatu_3/theme.dart';
import 'package:toko_sepatu_3/widgets/chat_buble.dart';

class DetaiChatPage extends StatefulWidget {
  ProductModel product;
  DetaiChatPage(this.product);

  @override
  _DetaiChatPageState createState() => _DetaiChatPageState();
}

class _DetaiChatPageState extends State<DetaiChatPage> {
  TextEditingController messageController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleAddMessage() async {
      await MessageService().addMessage(
        user: authProvider.user,
        isFromUser: true,
        product: widget.product,
        message: messageController.text,
      );
      setState(() {
        widget.product = UninitializedProductModel();
        messageController.text = '';
      });
    }

    Widget header() {
      return PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: backgroundColor1,
          centerTitle: false,
          title: Row(
            children: [
              Image.asset(
                'assets/Image_Shop_Online.png',
                width: 50,
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shoe Store',
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Online',
                    style: secondaryTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: StreamBuilder<List<MessageModel>>(
            stream: MessageService()
                .getMessagesByUserId(userId: authProvider.user.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  reverse: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  children: snapshot.data
                      .map((MessageModel message) => ChatBubble(
                            isSender: message.isFromUser,
                            text: message.message,
                            product: message.product,
                          ))
                      .toList(),
                  /*
                  children: [
                    ChatBubble(
                      isSender: true,
                      text: ('Hi, This Item is still available?'),
                      hasProduct: true,
                    ),
                  ],
                
                  children: [
                    ChatBubble(
                      isSender: true,
                      text: ('Hi, This Item is still available?'),
                      hasProduct: true,
                    ),
                  ],
                  */
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              /*
              return ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
                children: [
                  ChatBubble(
                    isSender: true,
                    text: ('Hi, This Item is still available?'),
                    hasProduct: true,
                  ),
                ],
              );
              */
            }),
      );
    }

    Widget productPreview() {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 225,
            height: 74,
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor5,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: primaryColor,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.product.galleries[0].url,
                    width: 54,
                  ),
                  /*
                  child: Image.asset(
                    'assets/Image_Shoes.png',
                    width: 54,
                  ),
                  */
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        //'COURT VISIO',
                        widget.product.name,
                        style: primaryTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '\$${widget.product.price}',
                        style: priceTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ),
                /*
                Image.asset(
                  'assets/Button_Close.png',
                  width: 27,
                ),
                */
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.product = UninitializedProductModel();
                    });
                  },
                  child: Image.asset(
                    'assets/Button_Close.png',
                    width: 27,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget chatInput() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            content(),
            //productPreview(),
            widget.product is UninitializedProductModel
                ? SizedBox()
                : productPreview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColor4,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: messageController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type Message....',
                          hintStyle: subtitleTextSyle,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: handleAddMessage,
                  child: Image.asset(
                    'assets/Send_Button.png',
                    width: 45,
                  ),
                )
                /*
                Image.asset(
                  'assets/Send_Button.png',
                  width: 45,
                )
                */
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor3,
      appBar: header(),
      //bottomNavigationBar: chatInput(),
      body: chatInput(),
    );
  }
}
