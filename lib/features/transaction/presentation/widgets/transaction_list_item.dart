import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs_skill_test/features/transaction/controllers/transaction_controller.dart';
import 'package:rs_skill_test/features/transaction/data/models/transaction_res_model.dart';
import 'package:rs_skill_test/features/transaction/presentation/pages/transaction_create_update_page.dart';
import 'package:rs_skill_test/global/presentation/components/custom_image_view.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;


  const TransactionListItem({super.key,
    required this.transaction,
  });


  /*
  *
  * transactionNo: transaction.transactionNo,
                          amount: transaction.amount,
                          transactionDate: transaction.transactionDate
                              .toIso8601String(),
                          details: transaction.details,
                          billNo: transaction.billNo,
                          imageFullPath:
                          transaction.imageFullPath ?? ""*/
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CustomImageView(
              imageType: CustomImageType.network,
              imageData: transaction.imageFullPath,
              isOval: true,
              width: 70,
              height: 70,
              boxFit: BoxFit.cover,
            ),
            const SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Transaction #${transaction.transactionNo}'),
                      const SizedBox(height: 5,),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        InkWell(
                            onTap: (){
                              Get.find<TransactionController>().isUpdate = true;
                              Get.to(() => const TransactionCreateUpdatePage(), arguments: transaction);
                              //Get.find<BranchController>().showCreateUpdateBranchDialog(branch: branch);
                            },
                            child: const Icon(Icons.edit, size: 20, color: Colors.green, )),
                        const SizedBox(width: 15,),
                        InkWell(
                            onTap: (){
                              Get.find<TransactionController>().showDeleteTransactionDialog(transactionID: transaction.id);
                            },
                            child: const Icon(Icons.delete_forever, size: 20, color: Colors.red, )),
                      ],),
                    ],
                  ),
                  Text('Transaction #${transaction.transactionNo}'),
                  Text('Amount: \$${transaction.amount}'),
                  Text('Date: ${transaction.transactionDate}'),
                  Text('Details: ${transaction.details.trim()}', maxLines: 2,),
                  Text('Bill No: ${transaction.billNo}'),
                ],
              ),
            ),

          ],
        ),
      )

    );
  }
}
