import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/saved_cards_screen/controller/saved_cards_controller.dart';
import 'package:awesome_card/awesome_card.dart';

class SavedCardsScreen extends GetWidget<SavedCardsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Saved Cards",
          style: GoogleFonts.getFont(
            'Signika Negative',
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: Get.width * 0.05,
            ),
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.grey),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Obx(
              () => controller.isLoading.value
                  ? SizedBox(
                      height: Get.height - 120,
                      child: Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                            color: Colors.blue, size: 50),
                      ),
                    )
                  : controller.creditCardDetails.isEmpty
                      ? SizedBox(
                          height: Get.height - 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonImageView(
                                  url: noCreditCardFound,
                                ),
                                Text(
                                  "No Credit Card found",
                                  style: GoogleFonts.getFont(
                                    'Signika Negative',
                                    textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: Get.width * 0.05,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            var cardDetails =
                                controller.creditCardDetails[index];
                            return GestureDetector(
                              onTap: () => cardDetails.showBack.toggle(),
                              child: Obx(
                                () => CreditCard(
                                  cardNumber: cardDetails.cardNumber,
                                  cardExpiry: cardDetails.expiryDate,
                                  cardHolderName: cardDetails.name,
                                  cvv: cardDetails.cvv,
                                  bankName: "Credit Card",
                                  cardType: (cardDetails.cardNumber[0] == "5" ||
                                          cardDetails.cardNumber[0] == "2")
                                      ? CardType.masterCard
                                      : cardDetails.cardNumber[0] == "4"
                                          ? CardType.rupay
                                          : cardDetails.cardNumber[0] == "3"
                                              ? CardType.americanExpress
                                              : CardType.other,
                                  showBackSide: cardDetails.showBack.value,
                                  frontBackground: CardBackgrounds.black,
                                  backBackground: CardBackgrounds.white,
                                  showShadow: true,
                                ),
                              ),
                            );
                          },
                          itemCount: controller.creditCardDetails.length,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 20,
                            );
                          },
                        ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () async {
          await openSavedCardsBottomSheet().then((value) {
            Get.back();
          });
        },
        tooltip: "Add Card",
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade800])),
          child: Icon(Icons.add_rounded, size: Get.width * 0.08),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String labelText,
    required TextEditingController controller,
    required String errorMessage,
    required int maxLength,
    double width = 50,
    bool readOnly = false,
    void Function(String)? onChanged,
    bool cardNumber = false,
    TextInputType type = TextInputType.number,
  }) {
    return Container(
      width: width == 50 ? Get.width - 75 : width,
      decoration: AppDecoration.inputBoxDecorationShaddow(),
      child: TextFormField(
        maxLength: maxLength,
        onChanged: onChanged,
        readOnly: readOnly,
        style: GoogleFonts.getFont(
          'Signika Negative',
          fontSize: Get.width * 0.05,
        ),
        keyboardType: type,
        decoration: AppDecoration().textInputDecoration(labelText, labelText),
        controller: controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return errorMessage;
          }
          if (cardNumber &&
              (controller.text[0] != "2" &&
                  controller.text[0] != "3" &&
                  controller.text[0] != "4" &&
                  controller.text[0] != "5")) {
            return "Invalid Card Number";
          }
          return null;
        },
      ),
    );
  }

  Future openSavedCardsBottomSheet() {
    return Get.bottomSheet(
      SingleChildScrollView(
        child: Form(
          key: controller.savedCardsFormKey,
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.03),
              buildTextField(
                labelText: "Name",
                controller: controller.nameController,
                errorMessage: "Enter Name",
                maxLength: 99,
                type: TextInputType.text,
              ),
              SizedBox(height: Get.height * 0.03),
              buildTextField(
                labelText: "Card Number",
                controller: controller.cardNumberController,
                errorMessage: "Enter Card Number",
                maxLength: 19,
                onChanged: (p0) => controller.formatNumber(),
                cardNumber: true,
              ),
              SizedBox(height: Get.height * 0.03),
              Container(
                width: Get.width - 75,
                decoration: AppDecoration.inputBoxDecorationShaddow(),
                child: TextFormField(
                  maxLength: 5,
                  onChanged: (value) {
                    if (value.length == 2 && !value.contains('/')) {
                      value += '/';
                      controller.expiryDateController.text = value;
                      controller.expiryDateController.selection =
                          TextSelection.fromPosition(
                        TextPosition(offset: value.length),
                      );
                    }
                  },
                  style: GoogleFonts.getFont(
                    'Signika Negative',
                    fontSize: Get.width * 0.05,
                  ),
                  keyboardType: TextInputType.datetime,
                  decoration: AppDecoration()
                      .textInputDecoration("Expiry Date", "MM/YY"),
                  controller: controller.expiryDateController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter Expiry Date";
                    }
                    String month = value.substring(0, 2);
                    int monthInt = int.tryParse(month) ?? 0;
                    if (monthInt < 1 || monthInt > 12) {
                      return "Invalid Expiry Date";
                    }
                    String year = value.substring(3);
                    int currentYear = DateTime.now().year % 100;
                    int yearInt = int.tryParse(year) ?? 0;
                    if (yearInt < currentYear) {
                      return "Invalid Expiry Date";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              buildTextField(
                labelText: "CVV",
                controller: controller.cvvController,
                errorMessage: "Enter CVV",
                maxLength: 4,
              ),
              SizedBox(height: Get.height * 0.03),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    if (controller.savedCardsFormKey.currentState!.validate()) {
                      await controller.addCard();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: Get.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade800],
                      ),
                    ),
                    child: Obx(
                      () => Center(
                        child: controller.isUploadPressed.value
                            ? LoadingAnimationWidget.threeArchedCircle(
                                color: Colors.white, size: Get.width * 0.1)
                            : Text(
                                "Add Card",
                                style: GoogleFonts.getFont(
                                  'Signika Negative',
                                  color: Colors.white,
                                  fontSize: Get.width * 0.06,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}
