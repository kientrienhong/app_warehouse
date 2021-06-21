import 'dart:io';

import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_button.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_input.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/models/entity/user.dart';
import 'package:app_warehouse/presenters/update_info_presenter.dart';
import 'package:app_warehouse/views/update_info_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(
                isHome: false,
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                text: 'Change information',
                color: CustomColor.black,
                context: context,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              UpdateInfoForm()
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateInfoForm extends StatefulWidget {
  @override
  _UpdateInfoFormState createState() => _UpdateInfoFormState();
}

class _UpdateInfoFormState extends State<UpdateInfoForm>
    implements UpdateInfoView {
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _addressController;
  TextEditingController _phoneController;
  File _image;
  FocusNode _nameFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _addressFocusNode;
  FocusNode _phoneFocusNode;
  UploadTask task;

  UpdateInfoPresenter presenter;
  User currentUser;
  @override
  void updateLoading() {
    setState(() {
      presenter.model.isLoading = !presenter.model.isLoading;
    });
  }

  @override
  void updateUser(User user) {
    setState(() {
      currentUser = user;
    });
  }

  @override
  void updateFile(File file) {
    setState(() {
      _image = file;
    });
  }

  @override
  void updateMsg(String msg, bool isError) {
    setState(() {
      presenter.model.msg = msg;
      presenter.model.isError = isError;
    });
  }

  @override
  void onClickUpdateInfo(File file, User user, UploadTask task) async {
    User currentUser = Provider.of(context, listen: false);
    User newUser =
        await presenter.onHandleUpdaetInfo(user, user.jwtToken, file, task);
    currentUser.setUser(user: newUser);
  }

  @override
  void onClickGalleryInfo() async {
    var picker = ImagePicker();
    PickedFile image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) presenter.onHandleAddImage(File(image.path));
  }

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<User>(context, listen: false);
    presenter = UpdateInfoPresenter(currentUser);
    presenter.view = this;
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();

    _nameController.text = currentUser.name;
    _emailController.text = currentUser.email;
    _addressController.text = currentUser.address;
    _phoneController.text = currentUser.phone;

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _addressFocusNode.dispose();
    _phoneFocusNode.dispose();
  }

  Widget _buildMsg({BuildContext context}) {
    if (presenter.model.isError) {
      if (presenter.model.msg.length > 0) {
        return CustomText(
            text: presenter.model.msg,
            color: CustomColor.red,
            textAlign: TextAlign.center,
            maxLines: 2,
            context: context,
            fontSize: 16);
      }
    } else {
      return CustomText(
          text: presenter.model.msg,
          color: CustomColor.green,
          maxLines: 2,
          context: context,
          fontSize: 16);
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: deviceSize.width / 4,
          height: deviceSize.width / 4,
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(deviceSize.width / 8),
              child: Container(
                  width: deviceSize.width / 4,
                  height: deviceSize.width / 4,
                  child: _image != null
                      ? Image.file(_image)
                      : Image.asset('assets/images/avatar.png')),
            ),
            Positioned(
              bottom: 0,
              right: 2,
              child: GestureDetector(
                onTap: () {
                  onClickGalleryInfo();
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: CustomColor.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 14,
                            offset: Offset(0, 6),
                            color: Colors.black.withOpacity(0.06))
                      ],
                      borderRadius: BorderRadius.circular(16)),
                  child:
                      Center(child: Image.asset('assets/images/imageIcon.png')),
                ),
              ),
            )
          ]),
        ),
        CustomSizedBox(
          context: context,
          height: 24,
        ),
        CustomOutLineInput(
          isDisable: false,
          deviceSize: deviceSize,
          labelText: 'Name',
          controller: _nameController,
          focusNode: _nameFocusNode,
          nextNode: _emailFocusNode,
        ),
        CustomOutLineInput(
          isDisable: true,
          deviceSize: deviceSize,
          labelText: 'Email',
          statusTypeInput: StatusTypeInput.DISABLE,
          controller: _emailController,
          focusNode: _emailFocusNode,
          nextNode: _addressFocusNode,
        ),
        CustomOutLineInput(
          isDisable: false,
          deviceSize: deviceSize,
          labelText: 'Adress',
          controller: _addressController,
          focusNode: _addressFocusNode,
          nextNode: _phoneFocusNode,
        ),
        CustomOutLineInput(
          isDisable: false,
          deviceSize: deviceSize,
          labelText: 'Phone',
          controller: _phoneController,
          focusNode: _phoneFocusNode,
          textInputType: TextInputType.number,
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        _buildMsg(context: context),
        if (presenter.model.msg.length > 0)
          CustomSizedBox(
            context: context,
            height: 16,
          ),
        CustomButton(
            isLoading: presenter.model.isLoading,
            height: 32,
            text: 'Done',
            width: double.infinity,
            textColor: CustomColor.green,
            onPressFunction: () {
              try {
                User currentUser = Provider.of<User>(context, listen: false);
                String name = _nameController.text;
                String email = _emailController.text;
                String phone = _phoneController.text;
                String address = _addressController.text;
                User user = User(
                    address: address, email: email, phone: phone, name: name);
                presenter.onHandleUpdaetInfo(
                    user, currentUser.jwtToken, _image, task);
                currentUser.setUser(user: user);
              } catch (e) {}
            },
            buttonColor: CustomColor.lightBlue,
            borderRadius: 8),
        CustomSizedBox(
          context: context,
          height: 32,
        ),
      ],
    );
  }
}
