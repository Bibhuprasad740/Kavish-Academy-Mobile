import 'package:flutter/material.dart';
import 'package:kavish_academy/constants/colors.dart';
import 'package:kavish_academy/models/address_model.dart';

class AddressTile extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onTap;
  const AddressTile({
    Key? key,
    required this.address,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // color: GlobalColors.accent3.withOpacity(0.1),
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            const Icon(Icons.add_location),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${address.name}, ${address.locality}',
                    style: TextStyle(
                      fontFamily: 'Brand-Bold',
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Text(
                    '${address.state}, ${address.postalcode}, ${address.countryCode}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: GlobalColors.accent3,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
