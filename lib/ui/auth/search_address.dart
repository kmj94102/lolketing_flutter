import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:lolketing_flutter/custom/custom_button.dart';
import 'package:lolketing_flutter/custom/custom_text_field.dart';
import 'package:lolketing_flutter/model/address_model.dart';
import 'package:lolketing_flutter/network/auth_service.dart';
import 'package:lolketing_flutter/structure/base_container.dart';

import '../../style/color.dart';
import '../../util/common.dart';

class SearchAddressScreen extends StatefulWidget {
  const SearchAddressScreen({super.key});

  @override
  State<SearchAddressScreen> createState() => _SearchAddressScreenState();
}

class _SearchAddressScreenState extends State<SearchAddressScreen> {
  final addressController = TextEditingController();
  final addressDetailController = TextEditingController();
  var isSearchMode = true;
  var addressResult = AddressResult(list: [], isMoreData: false);
  var selectAddress = '';

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      isScroll: false,
      header: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 20),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: SvgPicture.asset(
                  '$imagesAddress/ic_arrow_left.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: '지번, 도로명, 건물명으로 검색',
              controller: addressController,
              textInputAction: TextInputAction.search,
              maxLength: 100,
              onSubmitted: (value) async {
                final result = await AuthService().searchAddress(value);
                setState(() {
                  addressResult = result;
                });
              },
              icon: SvgPicture.asset('$imagesAddress/ic_search.svg'),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: ColorStyle.gray,
            ),
            isSearchMode
                ? Expanded(
                    child: addressResult.list.isEmpty
                        ? _buildEmptyState()
                        : _buildAddressListView())
                : Expanded(
                    child: CustomTextField(
                        controller: addressDetailController,
                        icon: SvgPicture.asset('$imagesAddress/ic_address.svg'),
                        hintText: '상세 주소'))
          ],
        ),
      ),
      bottom: isSearchMode
          ? const SizedBox()
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                  text: '주소 설정',
                  borderRadius: 0,
                  onClick: () {
                    Get.back(
                        result:
                            '$selectAddress ${addressDetailController.text.trim()}');
                  }),
            ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        '지번, 도로명, 건물명으로\n검색해보세요',
        style: TextStyle(fontSize: 20, color: ColorStyle.gray),
      ),
    );
  }

  Widget _buildAddressListView() {
    return ListView.builder(
        itemCount: addressResult.list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              addressController.text = addressResult.list[index];

              setState(() {
                selectAddress = addressResult.list[index];
                isSearchMode = false;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    addressResult.list[index],
                    style:
                        const TextStyle(fontSize: 16, color: ColorStyle.white),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: ColorStyle.gray,
                )
              ],
            ),
          );
        });
  }
}
