import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/providers/profile_provider.dart';
import 'package:tabibu/services/validators.dart';
import 'package:tabibu/widgets/buttons/auth_button.dart';
import 'package:tabibu/widgets/inputs/text_field_with_label.dart';

class ProfileEditTabView extends StatefulWidget {
  ProfileEditTabView({Key? key}) : super(key: key);

  @override
  State<ProfileEditTabView> createState() => _ProfileEditTabViewState();
}

class _ProfileEditTabViewState extends State<ProfileEditTabView> {
  GlobalKey<FormState> profileUpdateKey = GlobalKey<FormState>();
  TextEditingController _fullNameTextEditingController =
      TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController _bioTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future _refresh() async {
    await Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
    _fullNameTextEditingController.text =
        profileProvider.profileDetails.user!.fullName.toString();
    _emailTextEditingController.text =
        profileProvider.profileDetails.user!.email.toString();
    _phoneNumberTextEditingController.text =
        profileProvider.profileDetails.user!.phone.toString();
    _bioTextEditingController.text =
        profileProvider.profileDetails.bio.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      viewportBuilder: (context, position) {
        return Container(
          margin: const EdgeInsets.only(top: 3),
          padding: const EdgeInsets.only(
            top: 5,
            left: 5,
            right: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: profileUpdateKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  TextFieldWithLabel(
                    controller: _emailTextEditingController,
                    title: "Email",
                    prefix: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) =>
                        FormValidators().emailValidator(value!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWithLabel(
                    controller: _phoneNumberTextEditingController,
                    title: "Phone",
                    prefix: const Icon(
                      Icons.phone,
                      color: Colors.grey,
                    ),
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => FormValidators().phoneNumberValidator(
                      value!,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWithLabel(
                    controller: _fullNameTextEditingController,
                    title: "Full name",
                    prefix: const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) =>
                        FormValidators().fullNameValidator(value!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "About",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 106, 106, 106),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    autofocus: false,
                    controller: _bioTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      fillColor: const Color.fromARGB(255, 245, 170, 51),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 20, 106, 218),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: "About yourself",
                      prefixIcon: const Icon(
                        Icons.info,
                        color: Colors.grey,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 106, 106, 106),
                    ),
                    maxLines: 5,
                    minLines: 5,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthButton(
                    onPressed: () {},
                    child: Consumer<ProfileProvider>(
                      builder: (context, value, child) {
                        return const Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
