import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'edit_bank_info.dart';



class BankInfo extends StatelessWidget {
  const BankInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pushUpAnimation(
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/bank.svg"),
                    const SizedBox(width: 20),
                    Text(
                      "bank_info".tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // bounceAnimation(
              //   c: EditBankInfo(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, {required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: HexColor.fromHex("#717088"),
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: HexColor.fromHex(AppTheme.primaryColor),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
