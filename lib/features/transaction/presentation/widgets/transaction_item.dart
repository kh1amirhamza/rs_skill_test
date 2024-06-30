import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/constants.dart';
import '../../../../global/presentation/components/custom_text_tile.dart';
import '../../../../global/services/functions.dart';

class TransactionItem extends StatefulWidget {
  final Function() onItemClick;
  final Function() onReceiptClick;
  final String transactionID;
  final String paymentMethod;
  final double amount;
  final String status;
  const TransactionItem(
      {super.key,
      required this.onItemClick,
      required this.onReceiptClick,
      required this.transactionID,
      required this.paymentMethod,
      required this.amount,
      required this.status});

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  final pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onItemClick();
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(1, 2), // changes position of shadow
              ),
            ]),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextTile(
                    titleTextSize: 14,
                    title: 'Transaction ID:',
                    description: "\t\t${widget.transactionID}",
                    axis: Axis.horizontal,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  CustomTextTile(
                    titleTextSize: 14,
                    title: 'Payment Method:',
                    description: "\t\t${widget.paymentMethod}",
                    axis: Axis.horizontal,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  CustomTextTile(
                    titleTextSize: 14,
                    title: 'Amount:',
                    description: "\t\t\$${widget.amount}",
                    axis: Axis.horizontal,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      widget.status,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        //widget.onReceiptClick();
                        _createPDF();
                      },
                      icon: const Icon(
                        Icons.receipt_long_rounded,
                        color: primaryColor,
                        size: 35,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  int apiLevel = 0;

  Future<void> _createPDF() async {
    // var sign = '€';
    String sign = String.fromCharCode(0x80);
    final iconImage = (await rootBundle.load('assets/images/app-logo.jpg'))
        .buffer
        .asUint8List();

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    apiLevel = androidInfo.version.sdkInt;
    PermissionStatus? storagePermission;
    //
    // print("apiLevel $apiLevel");

    if (apiLevel < 33) {
      storagePermission = await Permission.storage.request();

      if (storagePermission == PermissionStatus.granted) {
        // try {
        generatePdfPage(iconImage, sign);
        List<int> bytes = await pdf.save();

        saveAndLaunchFile(bytes, 'invoice.pdf');
        // }
        // catch (e) {
        //   print("kjhjghdhj ${e.toString()}");
        //   Utils.errorSnackBar(context, "The document has already been saved");
        // }
      } else if (storagePermission == PermissionStatus.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Storage Permission is required',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      } else if (storagePermission == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    } else if (apiLevel >= 33) {
      try {
        generatePdfPage(iconImage, sign);
        List<int> bytes = await pdf.save();
        saveAndLaunchFile(bytes, 'invoice.pdf');
      } catch (e) {
        //print("kjhjghdhj ${e.toString()}");
        Get.snackbar("The document has already been saved", '');
      }
    }
  }

  void generatePdfPage(iconImage, sign) => pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return [
              pw.Center(
                child: pw.Text('Invoice',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center),
              ),
              // pw.Center(
              //   child: pw.Text(
              //       'Ride Invoice ${widget.voucherModel.pickDate}',
              //       style: pw.TextStyle(
              //           fontSize: 14,fontWeight: pw.FontWeight.bold
              //       ),
              //       textAlign: pw.TextAlign.center
              //   ),
              // ),
              pw.SizedBox(height: 8 * PdfPageFormat.mm),

              pw.Container(
                  padding: const pw.EdgeInsets.only(bottom: 20),
                  decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.circular(15),
                      border:
                          pw.Border.all(color: PdfColors.grey300, width: 2)),
                  child: pw.Column(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Flexible(
                            flex: 1,
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.SizedBox(width: 10),
                                      pw.Image(
                                        pw.MemoryImage(iconImage),
                                        height: 90,
                                        width: 220,
                                      ),
                                    ],
                                  ),
                                  CustomRichText(
                                      mainText: "Address: ",
                                      secondaryText:
                                          " 567 Pine Road, Villagetown, USA 13579"),
                                  pw.SizedBox(
                                    height: 5,
                                  ),
                                  CustomRichText(
                                      mainText: "Email: ",
                                      secondaryText: " info@milrenter.com"),
                                  pw.SizedBox(
                                    height: 5,
                                  ),
                                  CustomRichText(
                                      mainText: "Phone: ",
                                      secondaryText: "+1 169-854-7589"),
                                ]),
                          ),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  children: [
                                    pw.SizedBox(
                                      height: 30,
                                    ),
                                    CustomRichText(
                                        mainText: "Invoice Date: ",
                                        secondaryText: ": 23-May-2024",
                                        secondaryTextStyle: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColors.black)
                                        //widget.receiptModel.rentFirstname
                                        ),
                                    pw.SizedBox(
                                      height: 5,
                                    ),
                                    CustomRichText(
                                        mainText: "Customer Name: ",
                                        secondaryText: "Someone"
                                        //widget.receiptModel.rentEmail
                                        ),
                                    pw.SizedBox(
                                      height: 5,
                                    ),
                                    CustomRichText(
                                        mainText: "Customer Email: ",
                                        secondaryText: "someone@gmail.com"
                                        //widget .receiptModel.rentPhone .toString()
                                        ),
                                    pw.SizedBox(
                                      height: 5,
                                    ),
                                    CustomRichText(
                                        mainText: "Mobile: ",
                                        secondaryText: "PhoneNumber"
                                        //widget .receiptModel.rentPhone .toString()
                                        ),
                                    pw.SizedBox(
                                      height: 5,
                                    ),
                                    CustomRichText(
                                        mainText: "Transaction Number: ",
                                        secondaryText: "06C247196W348164B"
                                        //widget .receiptModel.rentPhone .toString()
                                        ),
                                    pw.SizedBox(
                                      height: 5,
                                    ),
                                  ]))
                        ],
                      ),
                    ),

                    pw.SizedBox(height: 5 * PdfPageFormat.mm),

                    ///
                    /// PDF Table Create
                    ///
                    pw.Table(
                        border: pw.TableBorder.all(
                            width: 1,
                            color: PdfColors.black,
                            style: pw.BorderStyle.solid),
                        children: [
                          pw.TableRow(children: [
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(5),
                                  child: pw.Text("Payment For",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold)),
                                )),
                            pw.Expanded(
                                flex: 4,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(5),
                                  child: pw.Text(
                                      "Account Verification" // "${sign.toString()}${formatPrice(widget.receiptModel.price)}"
                                      ),
                                )),
                          ]),
                          pw.TableRow(children: [
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(5),
                                  child: pw.Text("Price",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold)),
                                )),
                            pw.Expanded(
                                flex: 4,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(5),
                                  child: pw.Text(
                                      "\$2.0" //"${formatDateTime(DateTime.parse(receiptModel.pickDate.toString()))}"
                                      ),
                                )),
                          ]),
                          pw.TableRow(children: [
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(5),
                                  child: pw.Text("Payment Method",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold)),
                                )),
                            pw.Expanded(
                                flex: 4,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(5),
                                  child: pw.Text(
                                      "Paypal" //"${formatDateTime(DateTime.parse(receiptModel.pickDate.toString()))}"
                                      ),
                                )),
                          ]),
                          pw.TableRow(children: [
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(5),
                                  child: pw.Text("Payment Status",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold)),
                                )),
                            pw.Expanded(
                                flex: 4,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(5),
                                  child: pw.Text(
                                      "Paid" //"${formatDateTime(DateTime.parse(receiptModel.pickDate.toString()))}"
                                      ),
                                )),
                          ]),
                          pw.TableRow(children: [
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(5),
                                  child: pw.Text("Payment Date",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold)),
                                )),
                            pw.Expanded(
                                flex: 4,
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.all(5),
                                  child: pw.Text(
                                      "21 May 2024 06:39 AM" //"${formatDateTime(DateTime.parse(receiptModel.pickDate.toString()))}"
                                      ),
                                )),
                          ]),
                        ]),
                  ])),
            ];
          },
        ),
      );

  pw.RichText CustomRichText(
          {required String mainText,
          required String secondaryText,
          pw.TextStyle? mainTextStyle,
          pw.TextStyle? secondaryTextStyle}) =>
      pw.RichText(
        maxLines: 3,
        text: pw.TextSpan(
          text: mainText,
          style: mainTextStyle ??
              pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, color: PdfColors.black),
          children: <pw.TextSpan>[
            pw.TextSpan(
                text: secondaryText,
                style: secondaryTextStyle ??
                    pw.TextStyle(fontWeight: pw.FontWeight.normal)),
          ],
        ),
      );
}
