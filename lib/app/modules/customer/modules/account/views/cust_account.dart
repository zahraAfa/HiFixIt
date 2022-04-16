import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/Customer/modules/account/widgets/account_edit_btn.dart';
import 'package:hifixit/app/modules/Customer/modules/account/widgets/account_input.dart';
import 'package:hifixit/app/modules/customer/widgets/menu_drawer.dart';

class CustAccount extends StatefulWidget {
  const CustAccount({Key? key}) : super(key: key);

  @override
  State<CustAccount> createState() => _CustAccountState();
}

class _CustAccountState extends State<CustAccount> {
  final TextEditingController firstNameC = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    final TextEditingController _fNameController = TextEditingController();
    final TextEditingController _lNameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _categoryController = TextEditingController();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const MenuDrawer(),
      backgroundColor: const Color.fromARGB(255, 229, 229, 229),
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          width: MediaQuery.of(context).size.width,
          // color: Color.fromARGB(255, 218, 218, 218),
          child: Column(
            children: [
              InkWell(
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.20,
                  backgroundColor: Colors.white,
                  backgroundImage: null,
                  child: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width * 0.20,
                    color: const Color(0xFFBF84B1),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "First Name",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    AccountInputCust(
                      onChanged: (value) {},
                      hintTitle: 'First Name',
                      keyboardType: TextInputType.text,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "Last Name",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    AccountInputCust(
                      onChanged: (value) {},
                      hintTitle: 'Last Name',
                      keyboardType: TextInputType.text,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "Email",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    AccountInputCust(
                      onChanged: (value) {},
                      hintTitle: 'Email',
                      keyboardType: TextInputType.text,
                      enabled: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "Phone No.",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    AccountInputCust(
                      onChanged: (value) {},
                      hintTitle: 'Phone No.',
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                child: AccountEditBtn(
                  label: 'Save Changes',
                  press: () {
                    // if ((_emailInput.isNotEmpty) &&
                    //     (_fNameInput.isNotEmpty) &&
                    //     (_lNameInput.isNotEmpty) &&
                    //     (_phoneInput.isNotEmpty) &&
                    //     (_passwordInput.isNotEmpty)) {
                    //   saveCustInfoNow(
                    //       context: context,
                    //       emailInput: _emailInput,
                    //       passwordInput: _passwordInput,
                    //       fNameInput: _fNameInput,
                    //       lNameInput: _lNameInput,
                    //       phoneInput: _phoneInput);
                    // } else {
                    //   // validateForm();
                    // }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
