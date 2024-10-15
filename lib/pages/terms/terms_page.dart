import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:quyoshli/core/constants.dart';
import 'package:quyoshli/models/login/policy_model.dart';

import '../../services/http_service.dart';
import '../../services/log_service.dart';
import '../../widgets/custom_sliver_app_bar.dart';

class TermsPage extends StatefulWidget {
  static const String id = "terms_page";

  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  Policy? policy;

  getPolicy() async {
    try {
      var response = await Network.GET(Network.API_POLICY, {});

      setState(() {
        policy = policyModelFromJson(response!).data!;
      });
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CustomSliverAppBar(
              title: policy != null ? "${policy!.name}" : '',
              isLeading: true,
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
            child:
            Html(
              data: policy != null ? "${policy!.body}" : '',
            ),
            // Text(
            //   policy != null ? "${policy!.body}" : '',
            //   style: TextStyle(fontSize: 16),
            // ),
          ),
        ),
      ),
    );
  }
}
